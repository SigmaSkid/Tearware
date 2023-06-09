
visuals.WeaponGlow = function() 
    if not config.AdvGetBool(fWeaponGlow) then 
        return 
    end

    local toolBody = GetToolBody()
    if toolBody~=0 then
        local color = config.GetColor(fWeaponGlow, GetTime())
        DrawBodyOutline(toolBody, color.red, color.green, color.blue, color.alpha)
    end
end

visuals.ActiveGlow = function() 
    if not config.AdvGetBool(fActiveGlow) then 
        return 
    end
    local bodies = FindBodies(nil,true)
    local color = config.GetColor(fActiveGlow, GetTime())

	for i=1,#bodies do
		local body = bodies[i]
		if IsBodyActive(body) then
            if i % 10 == 0 then 
                color = config.GetColor(fActiveGlow, GetTime() + i)
            end 
            DrawBodyOutline(body, color.red, color.green, color.blue, color.alpha)
        end
    end
end

visuals.DrawGlow = function()
    visuals.WeaponGlow()
    visuals.ActiveGlow()
end