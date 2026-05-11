server.playerQuickstop = function(playerID)
    local e = syncedPlayerSetting[playerID]
    if not e then return nil end

    local enabled = server.getPlayerConfigValue(playerID, config_getKey(fQuickstop))
    if not enabled then return nil end

    if server.utils_IsDirectionalInput(playerID) then 
        return 
    end

    local velocity = {0, 0, 0}
    velocity[2] = GetPlayerVelocity(playerID)[2]
    SetPlayerVelocity(velocity, playerID)
end