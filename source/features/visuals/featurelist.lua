visuals_FeatureList = function()
    if not config_AdvGetBool(fFeatureList) then 
        return 
    end

    local visibleFeatures = 0.05
    local alignment = config_GetSubInt(fFeatureList, fAlignmentLR)
    local font_size = config_GetSubInt(fFeatureList, fFontSize)
    local watermark_above = config_AdvGetBool(fWatermark) and config_GetSubInt(fWatermark, fAlignmentLR) == alignment
    local watermark_font_size = config_GetSubInt(fWatermark, fFontSize)

    local features_available_space = 1080
    if watermark_above then 
        features_available_space = features_available_space - watermark_font_size
    end

    local max_features_to_display = features_available_space / font_size

    local font_id = config_GetSubInt(fFeatureList, fFont) + 1
    
    UiPush()
        if alignment == 0 then 
            UiAlign("top left")
        else 
            UiAlign("top right")
            UiTranslate(1920, 0)
        end

        if watermark_above then
            UiTranslate(0, watermark_font_size)
        end

        local color = config_GetColor(fFeatureList, GetTime())

        UiFont(fonts_array[font_id], font_size)
        UiTextShadow(0, 0, 0, color.alpha * 0.2, 1.5)
        UiTextOutline(0, 0, 0, color.alpha * 0.7, 0.07)

        for i=1, #featurelist do
            if config_AdvGetBool(featurelist[i]) and max_features_to_display > 0 then
                max_features_to_display = max_features_to_display - 1
                visibleFeatures = visibleFeatures + 0.05
                local color = config_GetColor(fFeatureList, GetTime() + visibleFeatures)
                UiColor(color.red, color.green, color.blue, color.alpha)

                UiText(featurelist[i].legacyName, true)
            end
        end

    UiPop()
end