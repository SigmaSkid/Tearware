-- server
server.playerBunnyhop = function(playerID, dt)
    local e = syncedPlayerSetting[playerID]
    if not e then 
        return  
    end

    local enabled = server.getPlayerConfigValue(playerID, config_getKey(fBunnyhop))
    if not enabled then 
        return  
    end

    if not IsPlayerGrounded(playerID) then 
        return 
    end

    if not server.utils_Input(InputDown, "jump", playerID) then
        return
    end

    if IsPlayerJumping(playerID) then
        return 
    end
    
    local pos = GetPlayerTransform(playerID).pos
    pos[2] = pos[2] - 1.7

    local hit, dist, normal, shape = QueryRaycast(pos, Vec(0, 1, 0), 1.1, 0.3)

    if not hit then 
        return 
    end

    local velocity = GetPlayerVelocity(playerID)

    if velocity[2] < -1 then 
        return 
    end

    velocity[2] = 6.5

    SetPlayerVelocity(velocity, playerID)
end