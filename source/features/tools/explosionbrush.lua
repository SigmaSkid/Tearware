function ExplosionBrush() 
    if not AdvGetBool(fExplosionBrush) then 
        return 
    end
    
    local Size = GetSubFloat(fExplosionBrush, fExplosionBrushSize)
    local TargetPos = GetPosWeAreLookingAt()
    if TargetPos ~= nil then 
        Explosion(TargetPos, Size)
    end
end