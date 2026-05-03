utils_generateUUID = function()
    local template = "xxxxxxxxxx" -- secure enough
    return (template:gsub("[xy]", function(c)
        local v = c == "x" and math.random(0, 15) or math.random(8, 11)
        return string.format("%x", v)
    end))
end

playerUUIDs = {}
localUUID = nil

server.issueUUID = function(playerIndex)
    DebugPrint("Client " .. playerIndex .. " requested new UUID")

    if playerUUIDs[playerIndex] ~= nil then 
        ClientCall(playerIndex, "client.receiveUUID", playerUUIDs[playerIndex])
    end

    local UUID = utils_generateUUID()
    DebugPrint("New UUID for client: " .. playerIndex .. " : " .. UUID)
    playerUUIDs[playerIndex] = UUID
    ClientCall(playerIndex, "client.receiveUUID", playerUUIDs[playerIndex])
end

client.receiveUUID = function(newUUID)
    DebugPrint("Client registered new UUID "  .. newUUID)
    localUUID = newUUID

    config_screamEverySecretAtTheServer()
end

serverVerify = function(ID, UUID)
    if UUID == nil then 
        -- player uuid is nil? 
        -- it should be preserved on quickloads right.. why did the client destroy it?
        -- please don't ever be printed. please.
        DebugPrint("[verify] UUID invalid " .. ID)
        return false
    end

    if playerUUIDs[ID] ~= UUID then
        -- if this ever gets printed, I would be so happy.
        DebugPrint("[verify] UUID mismatch for " .. ID .. " (" .. GetPlayerName(playerID) .. ") — possible spoof attempt")
        return false
    end

    if not IsPlayerValid(ID) then
        DebugPrint("[verify] Invalid player ", ID)
        playerUUIDs[ID] = nil -- clear uuid
        return false
    end

    return true
end
