tools_ExplosionBrush = function() 
    if not config_GetLocalFeatureState(fExplosionBrush) then 
        return 
    end
    
    local Size = config_GetSubVar(GetFloat,fExplosionBrush, fSubSize)
    local TargetPos = utils_GetPosWeAreLookingAt()
    if TargetPos ~= nil then 
        Explosion(TargetPos, Size)
    end
end