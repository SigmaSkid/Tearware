
player.Floorstrafe = function() 
    if not config.AdvGetBool(fFloorStrafe) then 
        return 
    end

    local velocity = GetPlayerVelocity()

    velocity[2] = 1

    SetPlayerGroundVelocity(velocity)
end