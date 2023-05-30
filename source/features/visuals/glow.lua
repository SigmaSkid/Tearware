
function WeaponGlow() 
    if not AdvGetBool(fWeaponGlow) then 
        return 
    end

    local toolBody = GetToolBody()
    if toolBody~=0 then
        local color = GetColor(fWeaponGlow, GetTime())
        DrawBodyOutline(toolBody, color.red, color.green, color.blue, color.alpha)
    end
end

function ActiveGlow() 
    if not AdvGetBool(fActiveGlow) then 
        return 
    end
    local bodies = FindBodies(nil,true)
    local color = GetColor(fActiveGlow, GetTime())

	for i=1,#bodies do
		local body = bodies[i]
		if IsBodyActive(body) then
            if i % 10 == 0 then 
                color = GetColor(fActiveGlow, GetTime() + i)
            end 
            DrawBodyOutline(body, color.red, color.green, color.blue, color.alpha)
        end
    end
end

function DrawGlow()
    WeaponGlow()
    ActiveGlow()
end