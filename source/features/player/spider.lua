server.playerSpider = function(playerID)
    local e = syncedPlayerSetting[playerID]
    if not e then 
        return 
    end

    local enabled = server.getPlayerConfigValue(playerID, config_getKey(fSpider))
    if not enabled then
         return 
    end

    local pos = GetPlayerTransform(playerID).pos
    pos[2] = pos[2] + 1

    local hit = QueryRaycast(pos, Vec(0, 1, 0), 0.1, 0.7)

    if not hit or not server.utils_Input(InputDown, "jump", playerID) then 
        return 
    end

    local vel = GetPlayerVelocity(playerID)

    vel[2] = 4
    if server.utils_Input(InputDown, "shift", playerID) then
        vel[2] = vel[2] + 3
    end

    if server.utils_Input(InputDown, "ctrl", playerID) then
        vel[2] = vel[2] - 3
    end

    SetPlayerVelocity(vel, playerID)
end