spinny_tool_current_rot = {0,0,0}
spinny_tool_target_rot = {0,0,0}

spinny_tool_current_pos = {0,0,0}
spinny_tool_target_pos = {0,0,0}

spinny_tool_started_transition_rot = 0
spinny_tool_started_transition_pos = 0

visuals_SpinningTool = function()
    if not config_AdvGetBool(fSpinnyTool) then 
        return
    end

    local toolBody = GetToolBody()
    if toolBody == nil then 
        return 
    end

    local speed = config_GetSubFloat(fSpinnyTool, fSubSpeed)

    local dist_rot = utils_VecDist(spinny_tool_current_rot, spinny_tool_target_rot)
    local dist_pos = utils_VecDist(spinny_tool_current_pos, spinny_tool_target_pos)

    local transition_state_rot = (GetTime() - spinny_tool_started_transition_rot) * speed /dist_rot
    local transition_state_pos = (GetTime() - spinny_tool_started_transition_pos) * speed /dist_pos

    -- infinite loop potential!
    -- GetTime() should in theory prevent infinite loop... but yk.
    -- :shrug:
    if transition_state_rot >= 1 then 
        spinny_tool_current_rot = spinny_tool_target_rot
        spinny_tool_target_rot = utils_RandomVector()
        spinny_tool_started_transition_rot = GetTime()
        
        -- the power of infinite loops and recursion!
        visuals_SpinningTool()

    elseif transition_state_pos >= 1 then 
        spinny_tool_current_pos = spinny_tool_target_pos
        spinny_tool_target_pos = utils_RandomVector()
        spinny_tool_started_transition_pos = GetTime()

        -- the power of infinite loops and recursion!
        visuals_SpinningTool()
    
    else 
        local transition_rot = VecLerp(spinny_tool_current_rot, spinny_tool_target_rot, transition_state_rot)
        local rot = QuatEuler(transition_rot[1] * 180, transition_rot[2] * 180, transition_rot[3] * 180)
        
        local pos = VecLerp(spinny_tool_current_pos, spinny_tool_target_pos, transition_state_pos)

        local offset = Transform( VecAdd( {-0.5, 0, -2}, pos),  rot)

        SetToolTransform(offset)
    end
end