local teleport_start_pos = nil
local teleport_target_pos = nil
local teleport_transition_start = 0

tools_Teleport = function() 
    if not config_AdvGetBool(fTeleport) then
        -- in case you spam teleport key twice in 100ms 
        teleport_target_pos = nil
        return 
    end

    local method = config_GetSubInt(fTeleport, fMethod)

    if method == 0 then 
        tools_Teleport_instant()
    else 
        tools_Teleport_smooth()
    end
end

tools_Teleport_instant = function()

    local TargetPos = utils_GetPosWeAreLookingAt()

    if TargetPos ~= nil then 
        local t = Transform(TargetPos, GetCameraTransform().rot)
            
        SetPlayerTransform(t, true)
    end
        
    SetBool(cfgstr .. fTeleport.configString, false)
end

tools_Teleport_smooth = function()
    if teleport_target_pos == nil then 
        teleport_start_pos = GetPlayerTransform().pos
        teleport_target_pos = utils_GetPosWeAreLookingAt()
        teleport_transition_start = GetTime()
        return
    end

    -- step scalar 1 = 1 second transition
    -- step scalar 2 = 0.5 transition
    -- step scalar 3 = 0.33 
    -- 10 = 100ms
    local step_scalar = 10

    local transition_state = utils_Clamp( ( GetTime() - teleport_transition_start ) * step_scalar, 0, 1)
    
    local TargetPos = VecLerp(teleport_start_pos, teleport_target_pos, transition_state)

    if TargetPos ~= nil then 
        local t = Transform(TargetPos, GetCameraTransform().rot)
            
        SetPlayerTransform(t, true)
    end
        
    if transition_state >= 1 then 
        SetBool(cfgstr .. fTeleport.configString, false)
        teleport_target_pos = nil
    end
end