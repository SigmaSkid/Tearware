visuals_WeaponGlow = function() 
    if not config_AdvGetBool(fWeaponGlow) then 
        return 
    end

    local toolBody = GetToolBody()
    if toolBody~=0 then
        local color = config_GetColor(fWeaponGlow, GetTime())
        DrawBodyOutline(toolBody, color.red, color.green, color.blue, color.alpha)
    end
end

visuals_ActiveGlow = function() 
    if not config_AdvGetBool(fActiveGlow) then 
        return 
    end
    local bodies = FindBodies(nil,true)
    local color = config_GetColor(fActiveGlow, GetTime())

	for i=1,#bodies do
		local body = bodies[i]
		if IsBodyActive(body) then
            if i % 10 == 0 then 
                color = config_GetColor(fActiveGlow, GetTime() + i)
            end 
            DrawBodyOutline(body, color.red, color.green, color.blue, color.alpha)
        end
    end
end


visuals_PlayerGlow = function()
    if not config_AdvGetBool(fPlayerGlow) then 
        return 
    end

    local color = config_GetColor(fPlayerGlow, GetTime())
    local players = GetAllPlayers()
    local isThirdPerson = GetBool("game.thirdperson")

    for id=1, #players do
        if IsPlayerValid(id) then 
            if not IsPlayerLocal(id) or isThirdPerson then 
                local bodies = GetPlayerBodies(id)
                for i=1,#bodies do
                    local body = bodies[i]
                    DrawBodyOutline(body, color.red, color.green, color.blue, color.alpha)
                end
            end
        end
    end
end 

visuals_DrawGlow = function()
    visuals_WeaponGlow()
    visuals_ActiveGlow()
    visuals_PlayerGlow()
end