-- server
server.playerFloorstrafe = function(playerID)
    local e = syncedPlayerSetting[playerID]
    if not e then return nil end

    local enabled = server.getPlayerConfigValue(playerID, config_getKey(fFloorStrafe))
    if not enabled then return nil end

    local velocity = GetPlayerVelocity(playerID)
    velocity[2] = -100
    SetPlayerGroundVelocity(velocity, playerID)
end
