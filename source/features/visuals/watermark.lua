visuals_Watermark = function()
    if not config_AdvGetBool(fWatermark) then 
        return 
    end

    local alignment = config_GetSubInt(fWatermark, fAlignmentLR)

    UiPush()
        local color = config_GetColor(fWatermark, GetTime())
        UiColor(color.red, color.green, color.blue, color.alpha)
        if alignment == 0 then 
            visuals_WatermarkLeft()
        else 
            visuals_WatermarkRight()
        end

        UiFont("bold.ttf", 25)
        UiTextShadow(0, 0, 0, color.alpha * 0.5, 1.5)
        UiTextOutline(0, 0, 0, color.alpha * 0.7, 0.07)
        UiText(fProjectName)
    UiPop()
end


visuals_WatermarkLeft = function()
    UiAlign("top left")
end

visuals_WatermarkRight = function()
    UiAlign("top right")
    UiTranslate(1920, 0)
end