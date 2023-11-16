visuals_FeatureList = function()
    if not config_AdvGetBool(fFeatureList) then 
        return 
    end

    local visibleFeatures = 0.05
    local alignment = config_GetSubInt(fFeatureList, fAlignmentLR)
    local watermark_above = config_AdvGetBool(fWatermark) and config_GetSubInt(fWatermark, fAlignmentLR) == alignment
    
    local features_available_space = 1080
    if watermark_above then 
        features_available_space = features_available_space - 25
    end

    local max_features_to_display = features_available_space / 14

    
    UiPush()
        if alignment == 0 then 
            UiAlign("top left")    
            UiTranslate(5, 0)
        else 
            UiAlign("top right")
            UiTranslate(1920, 0)
            UiTranslate(-5, 0)
        end

        if watermark_above then
            UiTranslate(0, 25)
        end

        local color = config_GetColor(fFeatureList, GetTime())

        UiFont(fonts.orbitron_sbold, 14)
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


visuals_sortFeatureList = function() 
    -- sort for feature list.
    UiPush()
        UiFont(fonts.orbitron_sbold, 14)
        table.sort(featurelist, function (left, right)
            return UiGetTextSize(left.legacyName) > UiGetTextSize(right.legacyName)
        end)
    UiPop()
end
