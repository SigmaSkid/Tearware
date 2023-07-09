tools_ExplosionBrush = function() 
    if not config_AdvGetBool(fExplosionBrush) then 
        return 
    end
    
    local Size = config_GetSubFloat(fExplosionBrush, fExplosionBrushSize)
    local TargetPos = utils_GetPosWeAreLookingAt()
    if TargetPos ~= nil then 
        Explosion(TargetPos, Size)
    end
end