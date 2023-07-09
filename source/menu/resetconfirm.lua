menu_DrawResetConfigConfirmation = function(dt)
    UiPush()
        UiTranslate(resetDvd.x, resetDvd.y)
        resetDvd = utils_animateDvd(resetDvd, dt)
        UiPush()
            UiFont("bold.ttf", 25)
            -- todo: use a different method than a text button,
            -- text buttons are unreliable while moving, 
            -- so resetting sometimes takes a few clicks.
            if legacyMenu_Button("CONFIRM RESET") then 
                config_ResetAllModData()
                openMenu = nil
            end
        UiPop()
    UiPop()
end