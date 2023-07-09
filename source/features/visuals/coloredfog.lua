visuals_ColoredFog = function() 
    if not config_AdvGetBool(fRainbowFog) then 
        if #cached_fog_color > 0 then 
            SetEnvironmentProperty("fogcolor", cached_fog_color[1], cached_fog_color[2], cached_fog_color[3])
            cached_fog_color = {}
        end
        return 
    end

    -- cache fog color
    if #cached_fog_color == 0 then 
        cached_fog_color[1], cached_fog_color[2], cached_fog_color[3] = GetEnvironmentProperty("fogcolor")
    else
        local color = config_GetColor(fRainbowFog, GetTime())
        SetEnvironmentProperty("fogcolor", color.red, color.green, color.blue)
    end
end