tools.ExplosionBrush = function() 
    if not config.AdvGetBool(fExplosionBrush) then 
        return 
    end
    
    local Size = config.GetSubFloat(fExplosionBrush, fExplosionBrushSize)
    local TargetPos = utils.GetPosWeAreLookingAt()
    if TargetPos ~= nil then 
        Explosion(TargetPos, Size)
    end
end