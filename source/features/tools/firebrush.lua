function FireBrush() 
    if not AdvGetBool(fFireBrush) then 
        return 
    end
    
    local TargetPos = GetPosWeAreLookingAt()
    if TargetPos ~= nil then 
        SpawnFire(TargetPos)
        PointLight(TargetPos, 0.7, 0.2, 0.2, 1)
    end
end