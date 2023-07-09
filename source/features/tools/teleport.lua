tools_Teleport = function() 
    if not config_AdvGetBool(fTeleport) then 
        return 
    end

    local TargetPos = utils_GetPosWeAreLookingAt()

    if TargetPos ~= nil then 
        local t = Transform(TargetPos, GetCameraTransform().rot)
            
        SetPlayerTransform(t, true)
    end
        
    SetBool(cfgstr .. fTeleport.configString, false)
end