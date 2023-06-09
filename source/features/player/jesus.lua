player.Jesus = function()
	if not config.AdvGetBool(fJesus) then
        return
    end
    local transform = GetPlayerTransform()
    local inWater, depth = IsPointInWater(transform.pos)

    if not inWater then 
        return 
    end

    local velocity = GetPlayerVelocity()
    
    if utils.TWInputDown("jump") then 
        velocity[2] = 5
    else
        velocity[2] = utils.Clamp(depth*20, 0, 6)
    end

    SetPlayerVelocity(velocity)
end