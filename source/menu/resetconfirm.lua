menu.DrawResetConfigConfirmation = function(dt)
    UiPush()
        UiTranslate(resetDvd.x, resetDvd.y)
        resetDvd = utils.animateDvd(resetDvd, dt)
        UiPush()
            UiFont("bold.ttf", 25)
            -- todo: use a different method than a text button,
            -- text buttons are unreliable while moving, 
            -- so resetting sometimes takes a few clicks.
            if legacyMenu.Button("CONFIRM RESET") then 
                config.ResetAllModData()
                openMenu = nil
            end
        UiPop()
    UiPop()
end