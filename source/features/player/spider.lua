player_Spider = function() 
    if not config_AdvGetBool(fSpider) then 
        return 
    end

    local pos = GetPlayerTransform().pos
    pos[2] = pos[2] + 1

    local hit = QueryRaycast(pos, Vec(0, 1, 0), 0.1, 0.7)

    if not hit or not utils_TWInputDown("jump") then 
        return 
    end

    local vel = GetPlayerVelocity()


    vel[2] = 4
    if utils_TWInputDown("shift") then 
        vel[2] = vel[2] + 3
    end
    if utils_TWInputDown("ctrl") then 
        vel[2] = vel[2] - 3
    end

    SetPlayerVelocity(vel)
end