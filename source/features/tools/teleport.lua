
tools_Teleport = function() 
    if not config_AdvGetBool(fTeleport) then
        -- in case you spam teleport key twice in 100ms 
        teleport_target_pos = nil
        return 
    end

    local delay = config_GetSubFloat(fTeleport, fSubDelay) / 1000
    -- sub 20ms is instant anyway
    if delay <= 0.02 then 
        tools_Teleport_instant()
    else
        tools_Teleport_smooth(delay)
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

-- need to be global for SetValue
local teleport_transition_start = 0
teleport_current_posX = 0
teleport_current_posY = 0
teleport_current_posZ = 0
teleport_target_pos = nil

-- you would assume this isn't needed, but it is!
local teleport_start_pos = nil

tools_Teleport_smooth = function(delay)
    if teleport_target_pos == nil then 
        teleport_target_pos = utils_GetPosWeAreLookingAt()
        -- if looking at skybox return.
        if teleport_target_pos == nil then return end

        teleport_start_pos = GetPlayerTransform().pos
        teleport_transition_start = GetTime()

        teleport_current_posX = teleport_start_pos[1]
        teleport_current_posY = teleport_start_pos[2]
        teleport_current_posZ = teleport_start_pos[3]

        SetValue("teleport_current_posX", teleport_target_pos[1], "cosine", delay)
        SetValue("teleport_current_posY", teleport_target_pos[2], "cosine", delay)
        SetValue("teleport_current_posZ", teleport_target_pos[3], "cosine", delay)
        return
    end

    local TargetPos = { teleport_current_posX, teleport_current_posY, teleport_current_posZ }
    local t = Transform(TargetPos, GetCameraTransform().rot)
    SetPlayerTransform(t, true)
    SetPlayerVelocity({0,0,0})

    if GetTime() - teleport_transition_start > delay then 
        SetBool(cfgstr .. fTeleport.configString, false)
        teleport_target_pos = nil
    end
end