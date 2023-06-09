tools.FireBrush = function() 
    if not config.AdvGetBool(fFireBrush) then 
        return 
    end
    
    local TargetPos = utils.GetPosWeAreLookingAt()
    if TargetPos ~= nil then 
        SpawnFire(TargetPos)
        PointLight(TargetPos, 0.7, 0.2, 0.2, 1)
    end
end