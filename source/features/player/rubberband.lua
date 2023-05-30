function Rubberband() 
    
    if not AdvGetBool(fRubberband) then
        rubberband_pos = nil

        if rubberband_transform == nil then
            return
        end

        SetPlayerTransform(rubberband_transform, true)
        rubberband_transform = nil
        return
    end

    if rubberband_transform == nil then
        rubberband_transform = GetPlayerTransform(true)
        rubberband_pos = GetPlayerPos()
    end

    local color = GetColor(fRubberband, GetTime())

    ParticleReset()
    ParticleType("plain")
    ParticleColor(color.red, color.green, color.blue)
    SpawnParticle(rubberband_pos, Vec(0, -2, 0), 0.1)
end