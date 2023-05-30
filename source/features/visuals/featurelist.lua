function FeatureList()
    if not AdvGetBool(fFeatureList) then 
        return 
    end

    local visibleFeatures = 0.05

    UiPush()
        UiAlign("top left")

        if AdvGetBool(fWatermark) then 
            UiTranslate(0, 25)
        end

        local color = GetColor(fFeatureList, GetTime())

        UiFont("bold.ttf", 12)
        UiTextShadow(0, 0, 0, color.alpha * 0.2, 1.5)
        UiTextOutline(0, 0, 0, color.alpha * 0.7, 0.07)

        for i=1, #featurelist do
            if AdvGetBool(featurelist[i]) then
                visibleFeatures = visibleFeatures + 0.05
                local color = GetColor(fFeatureList, GetTime() + visibleFeatures)
                UiColor(color.red, color.green, color.blue, color.alpha)

                UiText(featurelist[i][1], true)
            end
        end

    UiPop()
end
