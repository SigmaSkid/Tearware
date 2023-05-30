function Watermark()
    if not AdvGetBool(fWatermark) then 
        return 
    end

    UiPush()
        local color = GetColor(fWatermark, GetTime())
        UiColor(color.red, color.green, color.blue, color.alpha)
        UiAlign("left top")
        UiFont("bold.ttf", 25)
        UiTextShadow(0, 0, 0, color.alpha * 0.5, 1.5)
        UiTextOutline(0, 0, 0, color.alpha * 0.7, 0.07)
        UiText(fProjectName)
    UiPop()
end