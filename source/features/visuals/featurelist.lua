visuals.FeatureList = function()
    if not config.AdvGetBool(fFeatureList) then 
        return 
    end

    local visibleFeatures = 0.05

    UiPush()
        UiAlign("top left")

        if config.AdvGetBool(fWatermark) then 
            UiTranslate(0, 25)
        end

        local color = config.GetColor(fFeatureList, GetTime())

        UiFont("bold.ttf", 12)
        UiTextShadow(0, 0, 0, color.alpha * 0.2, 1.5)
        UiTextOutline(0, 0, 0, color.alpha * 0.7, 0.07)

        for i=1, #featurelist do
            if config.AdvGetBool(featurelist[i]) then
                visibleFeatures = visibleFeatures + 0.05
                local color = config.GetColor(fFeatureList, GetTime() + visibleFeatures)
                UiColor(color.red, color.green, color.blue, color.alpha)

                UiText(featurelist[i][1], true)
            end
        end

    UiPop()
end
