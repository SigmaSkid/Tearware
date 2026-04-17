syncedPlayerSetting = {}

server.updateServerConfig = function(playerID, UUID, setting, values)
    if not serverVerify(playerID, UUID) then return end

    DebugPrint("server.updateServerConfig " .. playerID .. " " .. GetPlayerName(playerID) .. " " .. setting)

    syncedPlayerSetting[playerID][setting] = values
end

server.requestServerConfig = function(playerID, UUID)
    if not serverVerify(playerID, UUID) then return end
    DebugPrint("server.requestServerConfig " .. playerID .. " " .. GetPlayerName(playerID))

    ClientCall(playerID, "client.receiveServerConfig", syncedPlayerSetting[playerID])
end

client.receiveServerConfig = function(serverSideSettings)
    DebugPrint("Received config from server: " .. utils_boolStr(serverSideSettings ~= nil))
end