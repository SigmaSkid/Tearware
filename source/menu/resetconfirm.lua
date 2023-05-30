function DrawResetConfigConfirmation(dt)
    UiPush()
        UiTranslate(resetDvd.x, resetDvd.y)
        resetDvd = animateDvd(resetDvd, dt)
        UiPush()
            UiFont("bold.ttf", 25)
            if Button("CONFIRM RESET") then 
                overrideConfigValues = true
                ResetConfig() 
                overrideConfigValues = false
                openMenu = nil
            end
        UiPop()
    UiPop()
end