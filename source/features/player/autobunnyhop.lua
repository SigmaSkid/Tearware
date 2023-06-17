
player.AutoBunnyhop = function() 
    if not config.AdvGetBool(fAutoBunnyhop) then 
        return 
    end

    local hit = QueryRaycast(GetPlayerTransform().pos, Vec(0, -1, 0), 0.01, 0.1)

    --DebugWatch(hit, dist)

    if not hit or not utils.TWInputDown("jump") then 
        return 
    end

    local vel = GetPlayerVelocity()
    vel[2] = 7
    SetPlayerVelocity(vel)
end