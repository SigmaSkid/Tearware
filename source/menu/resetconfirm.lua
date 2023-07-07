menu.DrawResetConfigConfirmation = function(dt)
    UiPush()
        UiTranslate(resetDvd.x, resetDvd.y)
        resetDvd = utils.animateDvd(resetDvd, dt)
        UiPush()
            UiFont("bold.ttf", 25)
            if legacyMenu.Button("CONFIRM RESET") then 
                config.ResetAllModData()
                openMenu = nil
            end
        UiPop()
    UiPop()
end