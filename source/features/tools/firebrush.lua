tools_FireBrush = function() 
    if not config_AdvGetBool(fFireBrush) then 
        return 
    end
    
    local TargetPos = utils_GetPosWeAreLookingAt()
    if TargetPos ~= nil then 
        SpawnFire(TargetPos)
        PointLight(TargetPos, 0.7, 0.2, 0.2, 1)
    end
end