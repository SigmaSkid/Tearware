function Teleport() 
    if not AdvGetBool(fTeleport) then 
        return 
    end

    local TargetPos = GetPosWeAreLookingAt()

    if TargetPos ~= nil then 
        local t = Transform(TargetPos, GetCameraTransform().rot)
            
        SetPlayerTransform(t, true)
    end
        
    SetBool(cfgstr .. fTeleport[2], false)
end