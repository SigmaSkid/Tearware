-- is this.. preserved on quickload?? oh god oh no.
syncedPlayerSetting = {}

server.updateServerConfig = function(playerID, UUID, setting, value)
    if not serverVerify(playerID, UUID) then 
        server.ImpolitelyReject(playerID, setting)
        return 
    end

    DebugPrint("server.updateServerConfig " .. playerID .. " " .. GetPlayerName(playerID) .. " " .. setting)

    -- register serverside config if not present yet.
    if syncedPlayerSetting[playerID] == nil then 
        syncedPlayerSetting[playerID] = {}
    end

    syncedPlayerSetting[playerID][setting] = value

    -- if string starts with savegame.mod.antiaim -> send new resolver data to all players.
    -- if param based feature [fly/godmode] just set the param.
    server.handleParamFeatures(playerID, setting, value)

end

server.requestServerConfig = function(playerID, UUID)
    if not serverVerify(playerID, UUID) then 
        server.ImpolitelyReject(playerID, "request config")
        return 
    end
    DebugPrint("server.requestServerConfig " .. playerID .. " " .. GetPlayerName(playerID))

    ClientCall(playerID, "client.receiveServerConfig", syncedPlayerSetting[playerID])
end

client.receiveServerConfig = function(serverSideSettings)
    DebugPrint("Received config from server: " .. utils_boolStr(serverSideSettings ~= nil))
end

client.ScreamAtServerPolitely = function(setting, value)
    DebugPrint("Screaming at server " .. setting)
    ServerCall("server.updateServerConfig", GetLocalPlayer(), localUUID, setting, value)
end

server.ImpolitelyReject = function(playerID, setting)

    ClientCall(playerID, "client.handleRejection", setting)
end

client.handleRejection = function(str)
    -- wee woo wee woo 
    -- we're on fire
    DebugPrint("server rejected our request for: " .. str)
end

server.getPlayerConfigValue = function(playerID, key)
    local e = syncedPlayerSetting[playerID]
    if not e then return nil end

    local val = e[key]
    if val ~= nil then 
        return val
    end

    DebugPrint("[server] No value for " .. playerID .. " : " .. key)

    -- server doesn't have this var yet, request current value.
    return nil
end

server.handleParamFeatures = function(playerID, setting, value)
    -- DebugPrint("Setting: " .. setting)
    if setting == cfgstr .. fGodmode.configString then 
        SetPlayerParam("godmode", value, playerID)
    elseif setting == cfgstr .. fFly.configString then 
        SetPlayerParam("flymode", value, playerID)
    end
end