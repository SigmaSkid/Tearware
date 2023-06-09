player.Quickstop = function() 
    if not config.AdvGetBool(fQuickstop) then 
        return 
    end

    if utils.IsDirectionalInputDown() then
        return 
    end

    local velocity = {0, 0, 0}
    velocity[2] = GetPlayerVelocity()[2]
    SetPlayerVelocity(velocity) 
end