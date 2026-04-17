syncedPlayerSetting = {}

server.updateServerConfig = function(playerID, UUID, setting, values)
    if not serverVerify(playerID, UUID) then 
        serverImpolitelyReject(playerID, setting)
        return 
    end

    DebugPrint("server.updateServerConfig " .. playerID .. " " .. GetPlayerName(playerID) .. " " .. setting)

    -- register serverside config if not present yet.
    if syncedPlayerSetting[playerID] == nil then 
        syncedPlayerSetting[playerID] = {}
    end

    syncedPlayerSetting[playerID][setting] = values
end

server.requestServerConfig = function(playerID, UUID)
    if not serverVerify(playerID, UUID) then 
        serverImpolitelyReject(playerID, "request config")
        return 
    end
    DebugPrint("server.requestServerConfig " .. playerID .. " " .. GetPlayerName(playerID))

    ClientCall(playerID, "client.receiveServerConfig", syncedPlayerSetting[playerID])
end

client.receiveServerConfig = function(serverSideSettings)
    DebugPrint("Received config from server: " .. utils_boolStr(serverSideSettings ~= nil))
end

clientScreamAtServerPolitely = function(setting, values)
    ServerCall("server.updateServerConfig", GetLocalPlayer(), localUUID, setting.configString, values)
end

clientScreamParamToggle = function(setting, value)
    --
    ServerCall("server.updateServerParam", GetLocalPlayer(), localUUID, setting, value)
end

server.updateServerParam = function(playerID, UUID, setting, value)
    if not serverVerify(playerID, UUID) then 
        serverImpolitelyReject(playerID, setting)
        return 
    end

    SetPlayerParam(setting, value, playerID)
    DebugPrint("server.updateServerParam " .. playerID .. " " .. GetPlayerName(playerID) .. " " .. setting .. "=" .. utils_boolStr(value))

    -- verify which params the client is able to edit, to limit it to just fly and godmode?
    -- we could also later allow the host to disable feature access per client.
end

serverImpolitelyReject = function(playerID, setting)

    ClientCall(playerID, "client.handleRejection", setting)
end

client.handleRejection = function(str)
    -- wee woo wee woo 
    -- we're on fire
    DebugPrint("server rejected our request for: " .. str)
end


-- Does the API guarantee that the serverCall is received?
-- What happens if server or client has high packet drop?

-- Another issue with this approach. We naively trust the client to network the correct table.
-- IF the client networks garbage, they can crash functions on the server side.
-- Assume that anything in values table could be nil.

-- We might want to tell the client, if something failed.