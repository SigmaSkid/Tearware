function Spider() 
    if not AdvGetBool(fSpider) then 
        return 
    end

    local hit = QueryRaycast(GetPlayerPos(), Vec(0, -1, 0), 0.1, 0.7)

    if not hit or not TWInputDown("jump") then 
        return 
    end

    local vel = GetPlayerVelocity()
    vel[2] = 4
    SetPlayerVelocity(vel)
end