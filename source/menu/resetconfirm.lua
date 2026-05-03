resetConfirmPage = 0
resetConfirmString = ""
selectedConfirmString = 1
resetTimer = 5.0
resetTimerController = 20.0

possibleConfirmStrings = {
    "sorry", 
    "please", 
    "sure", 
    "i understand the consequences",
    "i read the terms", 
    "trust me", 
    "why not", 
    "yessir", 
    "affirmative", 
    "continue",
    "confirm",
    "accept",
    "i agree to everything",
    "this is fine",
    "final answer",
    "i will regret this",
    "why is this here",
    "sudo",
    "i dont need a bootloader",
    "i consent",
    "this will end well",
    "my config was shit anyway",
    "what config",
    "famous last words",
    "the voices told me yes",
    "i dont even use half these features",
    "you cant stop me",
}


menu_setTimerColor = function(timeLeft)
    local green = Vec(0.5,1.0,0.5)
    local red   = Vec(1.0,0.5,0.5)
    local out = green

    if timeLeft < 10 then 
        out = VecLerp(red, green, timeLeft/10.0)
    
    end

    UiColor(out[1], out[2], out[3])
end

menu_DrawResetConfigConfirmation = function(dt)

    if LastInputDevice() == UI_DEVICE_GAMEPAD then 
        UiPush()
	        UiAlign("center middle")
            UiTranslate(UiWidth()/2, UiHeight()/2)
            UiFont("bold.ttf", 25)
            UiColor(0.9,0.9,0.9)
            UiTextShadow(0, 0, 0, 0.5, 1.5)
            UiTextOutline(0, 0, 0, 0.7, 0.07)
            UiText("Tearware config reset.")
            UiTranslate(0, 25)
            UiText("Press pause button to abort.")
            UiTranslate(0, 25)
            menu_setTimerColor(resetTimerController)
            UiText(utils_floatStr(resetTimerController, 5))
            resetTimerController = resetTimerController - dt
            if resetTimerController <= 0 then 
                config_ResetAllModData()
                openMenu = nil
                resetConfirmPage = 0
                resetTimerController = 20.0
            end
        UiPop()
        return
    else 
        resetTimerController = 20.0
    end

    if resetConfirmPage == 0 then
        UiPush()
            UiTranslate(resetDvd.x, resetDvd.y)

            -- UiColor(0, 0, 0)
            -- UiRect(resetDvd.width, resetDvd.height)

            local in_rect = UiIsMouseInRect(resetDvd.width, resetDvd.height)
            local pressed = InputPressed("lmb")

            if pressed and in_rect then 
                resetConfirmPage = 1 
                resetConfirmString = ""
                inputStringCursorPos = 1
                selectedConfirmString = math.random(#possibleConfirmStrings)

            elseif pressed and not in_rect then
                openMenu = nil
            end

            if in_rect then 
                dt = dt * 0.1
            end

            resetDvd = utils_animateDvd(resetDvd, dt)
            UiTranslate(5, 20)
            UiPush()
                UiFont("bold.ttf", 25)
                UiTextShadow(0, 0, 0, 0.5, 1.5)
                UiTextOutline(0, 0, 0, 0.7, 0.07)
                
                if in_rect then 
                    UiColor(0.7,0.7,0.7)
                else 
                    UiColor(0.9,0.9,0.9)
                end
                
                UiText("CONFIRM RESET")
            UiPop()
        UiPop()
    elseif resetConfirmPage == 1 then
        UiPush()
	        UiAlign("center middle")
            UiTranslate(UiWidth()/2, UiHeight()/2)
            UiColor(0.9,0.9,0.9)
            UiTextShadow(0, 0, 0, 0.5, 1.5)
            UiTextOutline(0, 0, 0, 0.7, 0.07)
            UiFont("bold.ttf", 25)

            local str = possibleConfirmStrings[selectedConfirmString]
            UiText("Write \"" .. str .. "\" to confirm config reset.")
        
            UiTranslate(0, 20)

            local modified = false
            resetConfirmString, modified, inputStringCursorPos = utils_ModifyString(resetConfirmString, inputStringCursorPos)

            local match = resetConfirmString == str 

            UiPush()
                local sizex, sizey = UiGetTextSize(resetConfirmString)
                
                if match then 
                    UiColor(0.5,1.0,0.5)
                end
                
                UiText(resetConfirmString)
                utils_DrawInputStringCursor(resetConfirmString, inputStringCursorPos, "center")
            UiPop()

            if match then 
                UiTranslate(0, 20)
                UiPush()
                    menu_setTimerColor(resetTimer)
                    UiText(utils_floatStr(resetTimer, 5))
                UiPop()
                resetTimer = resetTimer - dt

                if resetTimer <= 0.0 then 
                    config_ResetAllModData()
                    openMenu = nil
                    resetConfirmPage = 0
                    resetTimer = 5.0 
                    return
                end
            else
               resetTimer = 5.0 
            end

        UiPop()
    end
end