draggingMenu = false
dragMenuLastMousePos = nil

legacyMenu_DrawLegacyMenu = function(rgb) 
    local windowPos = {}
    local x_, y_ =  UiGetMousePos()

    -- permanent temporary solution :3
    -- I pray they never change the UI scaling from 1920x1080, 
    -- because this entire menu will fall apart when they do.
    windowPos.x = 255 + (config_GetVar(GetFloat,fMenuX) * 1410)
    windowPos.y = 305 + (config_GetVar(GetFloat,fMenuY) * 470)

    -- DebugPrint(windowPos.x .. " " .. windowPos.y)

    UiPush()
        UiFont("bold.ttf", 25)
        
        -- create context
        UiTranslate(windowPos.x, windowPos.y)
        UiWindow(500, 600)

        -- draw window background
        UiAlign("center middle")
        UiColor(0.23, 0.23, 0.23, 1)
        UiRect(510, 610)

        UiColor(0.53, 0.53, 0.53, 0.6)
        UiRect(500, 600)

        -- gradient bar, very important for every cheat
        UiPush()
            -- rgb defined in the same scope by background blur
            UiColor(rgb.R, rgb.G, rgb.B, 1)
            UiTranslate(0, -UiMiddle() - 2)
            UiRect(UiWidth(), 2)
        UiPop()

        -- dragging the window.
        UiPush()
            UiTranslate(0, -UiMiddle() - 4)
            -- UiColor(1, 0, 0)
            -- UiRect(UiWidth(), 8)
            
            local hover = UiIsMouseInRect(UiWidth(), 8)
            
            if hover and InputPressed("lmb") then 
                dragging = true
                dragMenuLastMousePos = {x=x_, y=y_}
            end
            if hover and InputPressed("rmb") then 
                config_SetVar(SetFloat,fMenuX, 0.5)
                config_SetVar(SetFloat,fMenuY, 0.5)
            end
            if not InputDown("lmb") then
                dragging = false
            end
            
            if dragging then
                local dx = x_ - dragMenuLastMousePos.x
                local dy = y_ - dragMenuLastMousePos.y 

                windowPos.x = windowPos.x + dx
                windowPos.y = windowPos.y + dy

                local nextx = (windowPos.x - 255) / 1410
                local nexty = (windowPos.y - 305) / 470

                dragMenuLastMousePos = {x=x_, y=y_}
                
                -- DebugWatch("x", nextx)
                -- DebugWatch("y", nexty)

                config_SetVar(SetFloat,fMenuX, utils_Clamp(nextx,0.0,1.0))
                config_SetVar(SetFloat,fMenuY, utils_Clamp(nexty,0.0,1.0))
            end
        UiPop()

        
        -- navigtor
        UiPush()
            UiAlign("center top")
            UiColor(0.23, 0.23, 0.23, 1)
            UiTranslate(0, -UiMiddle() * 0.7)
            UiRect(UiWidth(), 5)

            UiTranslate(-UiCenter(), (-UiMiddle() * 0.3))

            UiPush()
                UiTranslate(0, 14)
                legacyMenu_NavButtonImg("source/img/visuals-icon.png", 0)
                legacyMenu_NavSep(0)
                legacyMenu_NavButtonImg("source/img/player-icon.png", 1)
                legacyMenu_NavSep(1)
                legacyMenu_NavButtonImg("source/img/world-icon.png", 2)
                legacyMenu_NavSep(2)
                legacyMenu_NavButtonImg("source/img/tools-icon.png", 3)
                legacyMenu_NavSep(3)
                legacyMenu_NavButtonImg("source/img/misc-icon.png", 4)
            UiPop()
        UiPop()

        UiTranslate(-UiCenter() + 10, UiMiddle() * -0.64)
        
        UiAlign("left top")
        UiColor(1, 1, 1, 1)
        
        UiPush()
            UiTranslate(0, -5)
            if GetInt(cfgstr .. "activetab") == 0 then 
                -- visuals

                legacyMenu_Checkbox(fWatermark)
                legacyMenu_ColorSelector(fWatermark)
                if legacyMenu_FunnySubmenuBegin(fWatermark, 67, 40, 1) then 
                    legacyMenu_SubSettingCycleList(fWatermark, fAlignmentLR, left_right_string_array)
                    UiPop()
                end

                legacyMenu_Checkbox(fFeatureList)
                legacyMenu_ColorSelector(fFeatureList)
                if legacyMenu_FunnySubmenuBegin(fFeatureList, 67, 40, 1) then 
                    legacyMenu_SubSettingCycleList(fFeatureList, fAlignmentLR, left_right_string_array)                     
                    UiPop()
                end

                if isSessionCampagin then
                    legacyMenu_Checkbox(fObjectiveEsp)
                    legacyMenu_ColorSelector(fObjectiveEsp)
                    if config_GetLocalFeatureState(fObjectiveEsp) then 
                        legacyMenu_Checkbox(fOptionalEsp)
                        legacyMenu_ColorSelector(fOptionalEsp)
                    end
                    
                    legacyMenu_Checkbox(fValuableEsp)
                    legacyMenu_ColorSelector(fValuableEsp)
                end

                legacyMenu_Checkbox(fToolEsp)
                legacyMenu_ColorSelector(fToolEsp)

                legacyMenu_Checkbox(fPlayerGlow)
                legacyMenu_ColorSelector(fPlayerGlow)

                legacyMenu_Checkbox(fWeaponGlow)
                legacyMenu_ColorSelector(fWeaponGlow)

                legacyMenu_Checkbox(fActiveGlow)
                legacyMenu_ColorSelector(fActiveGlow)
                
                if isLocalPlayerTheHost then 
                    legacyMenu_Checkbox(fRainbowFog)
                    legacyMenu_ColorSelector(fRainbowFog, false)
                end

                legacyMenu_Checkbox(fPostProcess)
                legacyMenu_ColorSelector(fPostProcess)


            elseif GetInt(cfgstr .. "activetab") == 1 then 
                -- player

                legacyMenu_Checkbox(fSpeed)
                if legacyMenu_FunnySubmenuBegin(fSpeed, 120, 100) then 
                    legacyMenu_SubSettingSlider(fSpeed, fSubSpeed, 10, 30)
                    legacyMenu_SubSettingSlider(fSpeed, fSubBoost, 10, 40)
                    UiPop()
                end

                legacyMenu_Checkbox(fSpider)
                legacyMenu_Checkbox(fFly)

                legacyMenu_Checkbox(fFloorStrafe)
                legacyMenu_Checkbox(fBunnyhop)
                legacyMenu_Checkbox(fJetpack)
                legacyMenu_Checkbox(fJesus)
                legacyMenu_Checkbox(fQuickstop)
                legacyMenu_Checkbox(fInfiniteAmmo)
                legacyMenu_Checkbox(fSuperStrength)
                legacyMenu_Checkbox(fGodmode)

                legacyMenu_Checkbox(fAntiAim)
                if legacyMenu_FunnySubmenuBegin(fAntiAim, 200, 350) then 

                    UiColor(0.6, 0.6, 0.6, 1)
                    UiText("Yaw: ")
                    UiPush()
                    UiTranslate(45, 0)
                        legacyMenu_SubSettingCycleList(fAntiAim, fAntiAimYawModes, antiaim_yaw_modes)        
                    UiPop()
                    UiTranslate(0, 20)
                    legacyMenu_SubSettingSlider(fAntiAim, fSubYawOffset, -180, 180)  
                    legacyMenu_SubSettingSlider(fAntiAim, fSubYawSpeed, -10, 10)  
                    legacyMenu_SubSettingSlider(fAntiAim, fSubYawAmp, 10, 180)  
                    UiTranslate(0, 20)

                    UiText("Pitch: ")
                    UiPush()
                    UiTranslate(45, 0)
                        legacyMenu_SubSettingCycleList(fAntiAim, fAntiAimPitchModes, antiaim_pitch_modes)
                    UiPop()
                    UiTranslate(0, 20)
                    legacyMenu_SubSettingSlider(fAntiAim, fSubPitchOffset, -90, 90)
                    legacyMenu_SubSettingSlider(fAntiAim, fSubPitchSpeed, -10, 10)
                    legacyMenu_SubSettingSlider(fAntiAim, fSubPitchAmp, 10, 90)
                    UiPop()     
                end

                -- only clients need to 'resolve.'
                if not isLocalPlayerTheHost then 
                    legacyMenu_Checkbox(fResolver)
                end 


            elseif GetInt(cfgstr .. "activetab") == 2 then 
                -- world

                if isLocalPlayerTheHost then 
                    legacyMenu_Checkbox(fBulletTime)
                    if legacyMenu_FunnySubmenuBegin(fBulletTime, 120, 60) then 
                        legacyMenu_SubSettingSlider(fBulletTime, fSubScale, 10, 100)
                        UiPop()
                    end

                    legacyMenu_Checkbox(fDisableRobots)
                    legacyMenu_Checkbox(fDisablePhysics)
                    legacyMenu_Checkbox(fForceUpdatePhysics)

                    if isSessionCampagin then
                        legacyMenu_Checkbox(fSkipObjective)
                        legacyMenu_Checkbox(fDisableAlarm)
                        legacyMenu_Checkbox(fTeleportValuables)
                        legacyMenu_Checkbox(fUnfairValuables)
                    end
                else 
                    UiPush()
                        UiTranslate(0, 25)
                        UiTextShadow(0, 0, 0, 0.5, 1.5)
                        UiTextOutline(0, 0, 0, 1, 0.1)
                        UiText("Features affecting the world\nare for the hosting player only")
                        UiFont("bold.ttf", 15)
                        UiTranslate(0, 50)
                        UiText("unlucky")
                    UiPop()
                end


            elseif GetInt(cfgstr .. "activetab") == 3 then 
                -- tools

                legacyMenu_Checkbox(fRubberband)
                legacyMenu_ColorSelector(fRubberband, false)

                legacyMenu_Checkbox(fTeleport)
                if legacyMenu_FunnySubmenuBegin(fTeleport, 120, 60) then 
                    legacyMenu_SubSettingSlider(fTeleport, fSubDelay, 0, 1000)
                    UiPop()
                end

                legacyMenu_Checkbox(fExplosionBrush)
                if legacyMenu_FunnySubmenuBegin(fExplosionBrush, 120, 60) then 
                    legacyMenu_SubSettingSlider(fExplosionBrush, fSubSize, 0.5, 4)
                    UiPop()
                end

                legacyMenu_Checkbox(fFireBrush)

                if isLocalPlayerTheHost then 
                    legacyMenu_Checkbox(fStructureRestorer)
                end

            elseif GetInt(cfgstr .. "activetab") == 4 then 
                
                if legacyMenu_Button(fMenuResetConfig) then 
                    -- restart it's position, to prevent accidental clicks
                    resetDvd.x = 0
                    resetDvd.y = 0
                    openMenu = "reset"
                    resetConfirmPage = 0
                    resetConfirmString = ""
                    resetTimerController = 20.0
                end

                if isLocalPlayerTheHost and isSessionCampagin then 
                    if legacyMenu_Button(fMenuFinishLevel) then
                        SetString("level.state", "win") 
                    end
                end

                if legacyMenu_Button(fMenuActivateRobots) then
                    local robots = FindBodies("body", true)

                    for i = 1, #robots do
                        local active = HasTag(robots[i], "inactive")
                        if active then 
                            RemoveTag(robots[i], "inactive")
                        end 
                    end
                end

                if legacyMenu_Button(fRegistryTool) then
                    openMenu = "registry"
                end

                --if legacyMenu_Button("Dropdown Menu") then
                --    config_SetInt(fMenuStyle, 1)
                --end
            end

        UiPop()

    UiPop() 
end

legacyMenu_Checkbox = function(var)
    UiPush()
    UiAlign("left top")
    

    local inputStr = config_getKeyInput(var)

    local currentkey = GetString(inputStr)
    local namew, nameh = UiGetTextSize(var.legacyName)

    -- debug rect
    -- UiPush()
    --     UiTranslate(7, 2)
    --     UiColor(0.0, 0.0, 0.0, 1.0)
    --     UiRect(300, 25)
    -- UiPop()

    local highlight = 0.6
    local hovering = UiIsMouseInRect(300, 25) -- whatever, just hardcode at highest width

    if hovering then
        -- make the stuff we're hovering over a little brighter.
        highlight = 0.8

        -- right click -> edit this bind
        if InputPressed("rmb") then 
            filthyglobal_editingkeybind = var.configString
        end
        if InputPressed("lmb") then 
            config_ToggleFeature(var)
        end
    end

    UiTextShadow(0, 0, 0, 0.5, 1.5)
    UiTextOutline(0, 0, 0, 1, 0.1)

    -- highlight the checkbox, if this is the keybind we're editing
    if filthyglobal_editingkeybind == var.configString then
        UiColor(1.0, 1.0, highlight, 1)    
        UiButtonHoverColor(1.0, 1.0, highlight, 1.0)
    elseif GetBool(cfgstr .. var.configString) then 
        UiColor(highlight, 1.0, highlight, 1)
    else 
        UiColor(1.0, highlight, highlight, 1)
    end

    UiText(var.legacyName)

    -- check if this is the checkbox of the keybind we're editing
    if filthyglobal_editingkeybind == var.configString then
        local lastKey = InputLastPressedKey()
        -- if a button was pressed
        if lastKey ~= "" then 
            if lastKey == "return" or lastKey == "esc" or lastKey == "insert" then 
                -- remove keybind
                SetString(inputStr, "null") 
                currentkey = ""  
            else
                SetString(inputStr, lastKey)
                currentkey = lastKey
            end
            -- we're no longer editing a keybind.
            filthyglobal_editingkeybind = " " 
        end
    end

    if  currentkey ~= nil and currentkey ~= "" and currentkey ~= "null" then 
        UiPush()
            UiFont("bold.ttf", 16)
            local kw, kh = UiGetTextSize(currentkey)
            local offset = 10

            -- background rect
            -- UiPush()
            --     local pad = 6
            --     local halfpad = pad/2
            --     UiTranslate(namew + offset - halfpad, halfpad)
            --     UiColor(0.0, 0.0, 0.0, 0.5)
            --     UiRect(kw + pad, kh + pad)
            -- UiPop()

            -- key
            UiPush()
                UiTranslate(namew + offset, 5)
                UiTextShadow(0, 0, 0, 0.5, 1.0)
                UiTextOutline(0, 0, 0, 1, 0.2)
                
                UiText(currentkey, false)
            UiPop()




        UiPop()
    end

    UiPop()
    UiTranslate(0, 28)
end

legacyMenu_Button = function(name)
    UiPush()
    UiAlign("left top")
    
    local namew, nameh = UiGetTextSize(name)
    
    local highlight = 0.7
    local clicked = false

    local pad = 5
    UiTranslate(-pad, -pad)
    namew = namew + 2*pad
    nameh = nameh + 2*pad

    if UiIsMouseInRect(namew, nameh) then
        highlight = 1.0
        if InputPressed("lmb") then
            clicked = true
        end
    end

    UiTextShadow(0, 0, 0, 0.5, 2.0)
    UiTextOutline(0, 0, 0, 1, 0.1)
    
    UiColor(highlight, highlight, highlight, 1)
    
    UiTranslate(pad, pad)
    UiText(name)

    UiPop()
    UiTranslate(0, nameh)
    return clicked
end

legacyMenu_SimpleCheckbox = function(name, value) 
    UiPush()
    UiAlign("left top")
    
    local namew, nameh = UiGetTextSize(name)
    
    local highlight = 0.6
    local clicked = false

    local pad = 5
    UiTranslate(-pad, -pad)
    namew = namew + 2*pad
    nameh = nameh + 2*pad

    if UiIsMouseInRect(namew, nameh) then
        highlight = 0.8
        if InputPressed("lmb") then
            clicked = true
        end
    end

    UiTextShadow(0, 0, 0, 0.5, 2.0)
    UiTextOutline(0, 0, 0, 1, 0.1)
    
    if value == true then 
        UiColor(highlight, 1.0, highlight, 1)
    else 
        UiColor(1.0, highlight, highlight, 1)
    end

    UiTranslate(pad, pad)
    UiText(name)

    UiPop()
    UiTranslate(0, nameh)
    return clicked
end

legacyMenu_NavButtonImg = function(image, tabid)
    UiPush()
        UiTranslate(50 + (tabid * 100), -20)
        
        UiPush()
            UiTranslate(0, 10)
            local in_rect = UiIsMouseInRect(90,80)
        UiPop()

        local pressed = InputPressed("lmb")

        -- color stuff
        if tabid == GetInt(cfgstr .. "activetab") then 
            if in_rect then 
                -- enabled, hover
                UiColor(1, 1, 1, 1)
            else

            -- enabled, no hover
            UiColor(0.8, 0.8, 0.8, 1)
            end

        elseif in_rect then 
            -- disabled, hover
            UiColor(0.4, 0.4, 0.4, 1)
        else 
            -- disabled, no hover
            UiColor(0.3, 0.3, 0.3, 1)
        end
        --

        -- button logic 
        if in_rect and pressed then 
            SetInt(cfgstr .. "activetab", tabid)
            UiColor(0,0,0,1)
        end
        --

        -- affected by uicolor
        UiImage(image)
    UiPop()
end

legacyMenu_NavSep = function(tabid)
    UiPush()
        UiTranslate(100 + (tabid * 100), -14)
        UiColor(0.23, 0.23, 0.23, 1)
        UiRect(3, UiHeight() * 0.15)
    UiPop()
end

legacyMenu_ColorSelector = function(var, alpha)    
    UiPush()
    UiTranslate(0, -28) -- checkbox offset

    if alpha == nil then 
        alpha = true
    end

    local color = config_GetColor(var, GetTime())

    -- sub menu
    if active_sub_menu == var.configString .. "color" then 
        if active_sub_menu_mode == "default" then 
            local length = 160 
            if not alpha then 
                length = length - 30
            end

            UiPush()
                UiTranslate(UiWidth() - 5, -20)
                if InputPressed("lmb") then 
                    if not UiIsMouseInRect(120, length) then
                        active_sub_menu = nil
                    end
                end

                UiPush()
                    UiColor(0.23, 0.23, 0.23, 1)
                    UiRect(120, length)

                    UiTranslate(2, 2)

                    UiColor(0.53, 0.53, 0.53, 0.6)
                    UiRect(116, length-4)

                    UiTranslate(10, length - 35)

                    if color.rainbow then 
                        UiColor(0.6, 1.0, 0.6, 1)
                    else 
                        UiColor(1.0, 0.6, 0.6, 1)
                    end

                    if legacyMenu_SimpleCheckbox("rainbow", color.rainbow) then 
                        color.rainbow = not color.rainbow
                    end
                UiPop()

                UiPush()

                    UiTranslate(20, 30)
                    UiColor(1, 0.5, 0.5)
                    color.red = legacyMenu_optionsSlider(color.red * 100, 0, 100, 40) / 100

                    UiTranslate(0, 30)
                    UiColor(0.5, 1, 0.5)
                    color.green = legacyMenu_optionsSlider(color.green * 100, 0, 100, 40) / 100

                    UiTranslate(0, 30)
                    UiColor(0.5, 0.5, 1)
                    color.blue = legacyMenu_optionsSlider(color.blue * 100, 0, 100, 40) / 100
                    
                    if alpha then 
                        UiTranslate(0, 30)
                        UiColor(0.7, 0.7, 0.7)
                        color.alpha = legacyMenu_optionsSlider(color.alpha * 100, 0, 100, 40) / 100
                    end
                UiPop()

            UiPop() 
            
            config_SetColor(var, color)
        elseif active_sub_menu_mode == "alt" then 
            local length = 100
            local width = 80

            UiPush()
                UiTranslate(UiWidth() - 5, -20)
                if InputPressed("lmb") then 
                    if not UiIsMouseInRect(width, length) then
                        active_sub_menu = nil
                    end
                end

                UiPush()
                    UiColor(0.23, 0.23, 0.23, 1)
                    UiRect(width, length)

                    UiTranslate(2, 2)

                    UiColor(0.53, 0.53, 0.53, 0.6)
                    UiRect(width-4, length-4)

                    UiTranslate(10, length - 35)
                UiPop()


                UiPush()
                UiTranslate(10, 10)
                if legacyMenu_Button("Copy") then 
                    funnyColorCopyCache = color
                end

                if legacyMenu_Button("Paste") then 
                    config_SetColor(var, funnyColorCopyCache)
                end

                if legacyMenu_Button("Reset") then 
                    config_ResetColorToDefault(var)
                end
                UiPop()

            UiPop() 
        end
    end

    -- funny button
    UiPush()
        UiTranslate(0, 20)
        UiAlign("left top")
        UiTranslate(UiWidth() - 35, -20)

        local colorSquareSize = 20

        UiColor(0.3,0.3,0.3,1)
        UiRect(colorSquareSize, colorSquareSize)
        UiTranslate(1, 1)

        UiColor(color.red, color.green, color.blue,1)
        UiRect(colorSquareSize-2, colorSquareSize-2)


        if UiIsMouseInRect(colorSquareSize, colorSquareSize) then
            if InputPressed("lmb") then 
                active_sub_menu = var.configString  .. "color"
                active_sub_menu_mode = "default"

            elseif InputPressed("rmb") then 
                active_sub_menu = var.configString  .. "color"
                active_sub_menu_mode = "alt"

            elseif InputPressed("backspace") then 
                config_ResetColorToDefault(var)
            end

            if InputDown("ctrl") then 
                if InputPressed("c") then 
                    funnyColorCopyCache = color
                end

                if InputPressed("v") then 
                    config_SetColor(var, funnyColorCopyCache)
                end
                
                if InputPressed("r") then 
                    config_ResetColorToDefault(var)
                end
            end
        end
    UiPop()

    UiPop()
end

legacyMenu_optionsSlider = function(val, mi, ma, width)
	UiPush()
        UiPush()
            UiTranslate(-10, -18)
            if UiIsMouseInRect(width + 60, 20) then
                local scrollPos = InputValue("mousewheel")
                if scrollPos ~= 0 then
                    if InputDown("shift") then 
                        val = val + scrollPos
                    else
                        val = val + scrollPos/10
                    end
                    val = utils_Clamp(val, mi, ma)
                end
            end
            -- UiRect(width + 60, 20)
        UiPop()

        UiTranslate(0, -8)

        UiTextShadow(0, 0, 0, 0.5, 1.5)
        UiTextOutline(0, 0, 0, 1, 0.1)
		val = (val-mi) / (ma-mi)
		
		UiRect(width, 3)
		UiAlign("center middle")
		val = UiSlider("ui/common/dot.png", "x", val*width, 0, width) / width
		val = val*(ma-mi)+mi
        val = utils_Clamp(val, mi, ma)

        if width + 50 > UiWidth() then 
            UiTranslate(width - 10, -20)
        else
            UiTranslate(width + 30, 0)
        end

		UiText(utils_Round(val*10)/10)
	UiPop()
    
	return val
end

legacyMenu_optionsSliderInt = function(val, mi, ma, width)
	UiPush()
        UiPush()
            UiTranslate(-10, -18)
            if UiIsMouseInRect(width + 60, 20) then
                local scrollPos = InputValue("mousewheel")
                if scrollPos ~= 0 then
                    if InputDown("shift") then 
                        val = val + scrollPos*10
                    else
                        val = val + scrollPos
                    end
                    val = utils_Clamp(val, mi, ma)
                end
            end
            -- UiRect(width + 60, 20)
        UiPop()

        UiTranslate(0, -8)

        UiTextShadow(0, 0, 0, 0.5, 1.5)
        UiTextOutline(0, 0, 0, 1, 0.1)
		val = (val-mi) / (ma-mi)
		
		UiRect(width, 3)
		UiAlign("center middle")
		val = UiSlider("ui/common/dot.png", "x", val*width, 0, width) / width
		val = val*(ma-mi)+mi
        val = utils_Clamp(val, mi, ma)
        val = utils_Round(val)

        if width + 50 > UiWidth() then 
            UiTranslate(width - 10, -20)
        else
            UiTranslate(width + 30, 0)
        end

		UiText(val)


	UiPop()
    
	return val
end

legacyMenu_SubSettingSlider = function(var, sub, min, max, size) 
    if size == nil then size = UiWidth()-40 end

    UiPush()
        local name = sub.legacyName

        UiPush()    
            UiFont("bold.ttf", 12)
            UiTextShadow(0, 0, 0, 0.5, 1.5)
            UiTextOutline(0, 0, 0, 1, 0.1)
            UiColor(0.9,0.9,0.9, 1)
            UiText(name)
        UiPop()

        UiTranslate(10, 35)

        UiColor(1,1,1,1)
        local value = config_GetSubVar(GetFloat,var, sub)
        value = legacyMenu_optionsSlider(value, min, max, size)
        config_SetSubVar(SetFloat,var, sub, value)
    UiPop()
    UiTranslate(0, 40)
end

legacyMenu_SubSettingSliderInt = function(var, sub, min, max, size)
    if size == nil then size = UiWidth()-40 end
    
    UiPush()
        local name = sub.legacyName

        UiPush()    
            UiFont("bold.ttf", 12)
            UiTextShadow(0, 0, 0, 0.5, 1.5)
            UiTextOutline(0, 0, 0, 1, 0.1)
            UiColor(0.9,0.9,0.9, 1)
            UiText(name)
        UiPop()

        UiTranslate(10, 35)

        UiColor(1,1,1,1)
        local value = config_GetSubVar(GetInt,var, sub)
        value = legacyMenu_optionsSliderInt(value, min, max, size)
        config_SetSubVar(SetInt,var, sub, value)
    UiPop()
    UiTranslate(0, 40)
end

open_sub_menu_offset = {x=0, y=0}

legacyMenu_FunnySubmenuBegin = function(var, w, h, offset)
    if offset == nil then offset = 0 end

    UiPush()

        local literallyJustEnabled = false
        UiTranslate(-offset * 25, -28)
        -- de_square
        UiPush()
            UiTranslate(0, 20)
            UiAlign("left top")
            UiTranslate(UiWidth() - 35, -20)
            
            local colorSquareSize = 20
            UiPush()
                UiColor(0.3,0.3,0.3,1)
                UiRect(colorSquareSize, colorSquareSize)
                UiTranslate(1,1)
                UiColor(0.7,0.7,0.7,1)
                UiRect(colorSquareSize-2, colorSquareSize-2)
            UiPop()

            if UiIsMouseInRect(colorSquareSize, colorSquareSize) then
                if InputPressed("lmb") then 
                    active_sub_menu = var.configString .. offset
                    literallyJustEnabled = true
                end
            end
        UiPop()
        local enabled = active_sub_menu == var.configString .. offset

    UiPop()

    -- de_popup
    if enabled then 
        UiPush()
            UiTranslate(UiWidth() - 5, -36)
            if not UiIsMouseInRect(w, h) then
                if not literallyJustEnabled then 
                    if InputPressed("lmb") then 
                        active_sub_menu = nil
                    end    
                end
            end
            UiColor(0.23, 0.23, 0.23, 1)
            
            UiTranslate(open_sub_menu_offset.x, open_sub_menu_offset.y)
            UiWindow(w, h)
            UiRect(w, h)

            UiFont("bold.ttf", 18)
            UiTranslate(1, 1)

            UiColor(0.53, 0.53, 0.53, 0.6)
            UiRect(w -4, h-4)
            UiTranslate(5, 10)
    end

    return enabled
end

legacyMenu_SubSettingCheckbox = function(var, sub)
    UiPush()
    UiAlign("left top")
    
    local namew, nameh = UiGetTextSize(sub.legacyName)
    
    local highlight = 0.6
    local in_rect = false

    local pad = 5
    UiTranslate(-pad, -pad)
    namew = namew + 2*pad
    nameh = nameh + 2*pad

    -- debug rect
    -- UiPush()
    -- UiColor(0.0, 0.0, 0.0, 1.0)
    -- UiRect(namew, nameh)
    -- UiPop()

    if UiIsMouseInRect(namew, nameh) then
        highlight = 0.8
        in_rect = true
    end

    UiTextShadow(0, 0, 0, 0.5, 1.5)
    UiTextOutline(0, 0, 0, 1, 0.1)

    if GetBool(cfgstr .. var.configString .. sub.configString) then 
        UiColor(highlight, 1.0, highlight, 1)
    else 
        UiColor(1.0, highlight, highlight, 1)
    end

    UiTranslate(pad, pad)
    UiText(sub.legacyName)

    if in_rect and InputPressed("lmb") then
        local newVal = not config_GetSubVar(GetBool, var, sub)
        config_SetSubVar(SetBool, var, sub, newVal)
    end

    UiPop()
    UiTranslate(0, 20)
end

legacyMenu_SubSettingCycleList = function(var, sub, list)
    if #list <= 0 then return end
    
    local value = config_GetSubVar(GetInt,var, sub)

    value = utils_Clamp(value + 1, 1, #list)

    local string = list[value]
    local namew, nameh = UiGetTextSize(string)

    UiPush()
    UiAlign("left top")

    local highlight = 0.8
    local in_rect = false

    local pad = 5 
    UiTranslate(-pad, -pad)
    namew = namew + 2*pad
    nameh = nameh + 2*pad

    -- debug rect
    -- UiPush()
    -- UiColor(0.0, 0.0, 0.0, 1.0)
    -- UiRect(namew, nameh)
    -- UiPop()

    if UiIsMouseInRect(namew, nameh) then
        highlight = 0.9
        in_rect = true
    end

    UiTextShadow(0, 0, 0, 0.5, 1.5)
    UiTextOutline(0, 0, 0, 1, 0.1)
    UiColor(highlight, highlight, highlight, 1)
    UiTranslate(pad, pad)
    UiText(string)

    local return_value = true

    if in_rect and InputPressed("lmb") then 
        value = value + 1 

        if value > #list then value = 1 end
        config_SetSubVar(SetInt,var, sub, value - 1)

    elseif in_rect and InputPressed("rmb") then 
        value = value - 1

        if value < 1 then value = #list end
        config_SetSubVar(SetInt,var, sub, value - 1)
    else
        return_value = false
    end

    UiPop()
    UiTranslate(0, 20)
    return return_value
end