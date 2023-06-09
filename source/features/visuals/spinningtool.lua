visuals.SpinningTool = function()
    if not config.AdvGetBool(fSpinnyTool) then 
        return
    end
    
    local toolBody = GetToolBody()
    if toolBody == nil then 
        return 
    end

    -- color to spin! science!
    local rgb = utils.seedToRGB(GetTime())

    local rot = QuatEuler(rgb.R * 360, rgb.G* 360, rgb.B* 360)
    local offset = Transform( Vec(0, 0, -2), rot)

    SetToolTransform(offset)
end