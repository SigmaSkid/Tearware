-- server
server.playerNofall = function(playerID)
    local e = syncedPlayerSetting[playerID]
    if not e then return nil end

    local enabled = server.getPlayerConfigValue(playerID, config_getKey(fNoFall))
    if not enabled then return nil end

    local velocity = GetPlayerVelocity(playerID)
    velocity[2] = -100

    if not IsPlayerGrounded(playerID) then  
        SetPlayerGroundVelocity(velocity, playerID)
    end
end