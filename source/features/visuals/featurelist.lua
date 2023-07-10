visuals_FeatureList = function()
    if not config_AdvGetBool(fFeatureList) then 
        return 
    end

    local visibleFeatures = 0.05
    local alignment = config_GetSubInt(fFeatureList, fAlignmentLR)
    local watermark_above = config_AdvGetBool(fWatermark) and config_GetSubInt(fWatermark, fAlignmentLR) == alignment

    UiPush()
        if alignment == 0 then 
            UiAlign("top left")
        else 
            UiAlign("top right")
            UiTranslate(1920, 0)
        end

        if watermark_above then
            UiTranslate(0, 25)
        end

        local color = config_GetColor(fFeatureList, GetTime())

        UiFont("bold.ttf", 12)
        UiTextShadow(0, 0, 0, color.alpha * 0.2, 1.5)
        UiTextOutline(0, 0, 0, color.alpha * 0.7, 0.07)

        for i=1, #featurelist do
            if config_AdvGetBool(featurelist[i]) then
                visibleFeatures = visibleFeatures + 0.05
                local color = config_GetColor(fFeatureList, GetTime() + visibleFeatures)
                UiColor(color.red, color.green, color.blue, color.alpha)

                UiText(featurelist[i].legacyName, true)
            end
        end

    UiPop()
end