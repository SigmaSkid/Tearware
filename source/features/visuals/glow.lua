visuals_WeaponGlow = function() 
    if not config_AdvGetBool(fWeaponGlow) then 
        return 
    end

    local toolBody = GetToolBody(GetLocalPlayer())
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
    -- DebugWatch("GLOW ACTIVE", #bodies)
end


visuals_PlayerGlow = function()
    if not config_AdvGetBool(fPlayerGlow) then 
        return 
    end

    local color = config_GetColor(fPlayerGlow, GetTime())
    local players = GetAllPlayers()
    local isThirdPerson = GetBool("game.thirdperson") -- this needs testing in multiplayer
    local localPlayerID = GetLocalPlayer()
  
    for id=1, #players do
        if id == localPlayerID then 
            if isThirdPerson then 
                local bodies = GetPlayerBodies(id)
                for i=1,#bodies do
                    local body = bodies[i]
                    if body and body ~= equippedTool then 
                        DrawBodyOutline(body, color.red, color.green, color.blue, color.alpha)
                    end
                end
            end
        elseif IsPlayerValid(id) then 
            local bodies = GetPlayerBodies(id)
            
            for i=1,#bodies do
                local body = bodies[i]
                if body and body ~= equippedTool then 
                    DrawBodyOutline(body, color.red, color.green, color.blue, color.alpha)
                end
            end
        end
    end
end 

visuals_DrawGlow = function()
    visuals_PlayerGlow()
    visuals_WeaponGlow()
    visuals_ActiveGlow()
end