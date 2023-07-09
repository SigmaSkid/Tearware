player_Jetpack = function(dts) 
    if not config_AdvGetBool(fJetpack) then 
        return 
    end

    if utils_TWInputDown("jump") then 
        local velocity = GetPlayerVelocity()

        velocity[2] = velocity[2] + (0.5 * dts)
        if velocity[2] > 7 then 
            velocity[2] = 7 
        end

        SetPlayerVelocity(velocity) 
    end

end
