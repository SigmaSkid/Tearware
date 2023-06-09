player.Spider = function() 
    if not config.AdvGetBool(fSpider) then 
        return 
    end

    local hit = QueryRaycast(GetPlayerPos(), Vec(0, -1, 0), 0.1, 0.7)

    if not hit or not utils.TWInputDown("jump") then 
        return 
    end

    local vel = GetPlayerVelocity()
    vel[2] = 4
    SetPlayerVelocity(vel)
end