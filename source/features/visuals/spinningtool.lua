spinny_tool_current_vector = {0,0,0}
spinny_tool_target_vector = {0,0,0}
spinny_tool_started_transition = 0

visuals_SpinningTool = function()
    if not config_AdvGetBool(fSpinnyTool) then 
        return
    end

    local toolBody = GetToolBody()
    if toolBody == nil then 
        return 
    end

    local speed = config_GetSubFloat(fSpinnyTool, fSubSpeed)

    local dist = utils_VecDist(spinny_tool_current_vector, spinny_tool_target_vector)
    local transition_state = (GetTime() - spinny_tool_started_transition) * speed /dist

    if transition_state >= 1 then 
        spinny_tool_current_vector = spinny_tool_target_vector
        spinny_tool_target_vector = utils_RandomVector()
        spinny_tool_started_transition = GetTime()
        transition_state = 0
        -- the power of infinite loops and recursion!
        visuals_SpinningTool()
        return 
    end

    local transition = VecLerp(spinny_tool_current_vector, spinny_tool_target_vector, transition_state)
    local rot = QuatEuler(transition[1] * 180, transition[2] * 180, transition[3] * 180)
    
    local offset = Transform( VecAdd( {-0.1, 0, -2}, VecScale(rot, -0.5)),  rot)

    SetToolTransform(offset)
end