-- tearware on top

legacyMenu_DrawLegacyMenu = function(rgb) 
    UiPush()
        UiFont("bold.ttf", 25)
        
        -- create context
        UiTranslate(UiCenter(), UiMiddle())
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
            if GetInt(cfgstr .. "activetab") == 0 then 
                -- visuals

                legacyMenu_Checkbox(fWatermark)
                legacyMenu_ColorSelector(fWatermark)

                legacyMenu_Checkbox(fFeatureList)
                legacyMenu_ColorSelector(fFeatureList)

                legacyMenu_Checkbox(fObjectiveEsp)
                legacyMenu_ColorSelector(fObjectiveEsp)
                if config_AdvGetBool(fObjectiveEsp) then 
                    legacyMenu_Checkbox(fOptionalEsp)
                    legacyMenu_ColorSelector(fOptionalEsp)
                end

                legacyMenu_Checkbox(fValuableEsp)
                legacyMenu_ColorSelector(fValuableEsp)

                legacyMenu_Checkbox(fToolEsp)
                legacyMenu_ColorSelector(fToolEsp)

                legacyMenu_Checkbox(fWeaponGlow)
                legacyMenu_ColorSelector(fWeaponGlow)

                legacyMenu_Checkbox(fActiveGlow)
                legacyMenu_ColorSelector(fActiveGlow)

                legacyMenu_Checkbox(fRainbowFog)
                legacyMenu_ColorSelector(fRainbowFog, false)
                
                legacyMenu_Checkbox(fPostProcess)
                legacyMenu_ColorSelector(fPostProcess)
                
                legacyMenu_Checkbox(fSpinnyTool)

            elseif GetInt(cfgstr .. "activetab") == 1 then 
                -- player

                legacyMenu_Checkbox(fSpeed)
                if legacyMenu_FunnySubmenuBegin(fSpeed, 120, 80) then 
                    legacyMenu_SubSettingSlider(fSpeed, fSubSpeed, 10, 30)
                    legacyMenu_SubSettingSlider(fSpeed, fSubBoost, 10, 40)
                    UiPop()
                end

                legacyMenu_Checkbox(fSpider)
                legacyMenu_Checkbox(fFly)
                if legacyMenu_FunnySubmenuBegin(fFly, 120, 80) then 
                    legacyMenu_SubSettingSlider(fFly, fSubSpeed, 10, 30)
                    legacyMenu_SubSettingSlider(fFly, fSubBoost, 10, 40)
                    UiPop()
                end

                legacyMenu_Checkbox(fNoclip)
                if legacyMenu_FunnySubmenuBegin(fNoclip, 120, 80) then 
                    legacyMenu_SubSettingSlider(fNoclip, fSubSpeed, 1, 5)
                    legacyMenu_SubSettingSlider(fNoclip, fSubBoost, 1, 20)
                    UiPop()
                end

                legacyMenu_Checkbox(fFloorStrafe)
                legacyMenu_Checkbox(fJetpack)
                legacyMenu_Checkbox(fJesus)
                legacyMenu_Checkbox(fQuickstop)
                legacyMenu_Checkbox(fInfiniteAmmo)
                legacyMenu_Checkbox(fSuperStrength)
                legacyMenu_Checkbox(fGodmode)

            elseif GetInt(cfgstr .. "activetab") == 2 then 
                -- world

                legacyMenu_Checkbox(fBulletTime)
                if legacyMenu_FunnySubmenuBegin(fBulletTime, 120, 80) then 
                    legacyMenu_SubSettingSlider(fBulletTime, fBulletTimeScale, 10, 100)
                    legacyMenu_SubSettingCheckbox(fBulletTime, fBulletTimePatch)
                    UiPop()
                end

                legacyMenu_Checkbox(fSkipObjective)
                legacyMenu_Checkbox(fDisableAlarm)
                legacyMenu_Checkbox(fDisableRobots)
                legacyMenu_Checkbox(fDisablePhysics)
                legacyMenu_Checkbox(fForceUpdatePhysics)
                legacyMenu_Checkbox(fTeleportValuables)
                legacyMenu_Checkbox(fUnfairValuables)


            elseif GetInt(cfgstr .. "activetab") == 3 then 
                -- tools

                legacyMenu_Checkbox(fRubberband)
                legacyMenu_ColorSelector(fRubberband, false)

                legacyMenu_Checkbox(fTeleport)

                legacyMenu_Checkbox(fExplosionBrush)
                if legacyMenu_FunnySubmenuBegin(fExplosionBrush, 120, 50) then 
                    legacyMenu_SubSettingSlider(fExplosionBrush, fExplosionBrushSize, 0.5, 4)
                    UiPop()
                end

                legacyMenu_Checkbox(fFireBrush)
                legacyMenu_Checkbox(fStructureRestorer)

            elseif GetInt(cfgstr .. "activetab") == 4 then 
                if legacyMenu_Button(fMenuResetConfig) then 
                    -- restart it's position, to prevent accidental clicks
                    resetDvd = {} 
                    resetDvd.width = 175 
                    resetDvd.height = 25
                    resetDvd.x = 0
                    resetDvd.y = 0
                    resetDvd.speedx = 100
                    resetDvd.speedy = 100

                    openMenu = "reset"
                end

                if legacyMenu_Button(fMenuFinishLevel) then
                    SetString("level.state", "win") 
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
    
    local currentkey = GetString(cfgstr .. var.configString .. "_key")
    local kw, kh = UiGetTextSize(" - " .. currentkey)

    local namew, nameh = UiGetTextSize(var.legacyName)
    
    local highlight = 0.6

    if UiIsMouseInRect(namew + kw, nameh) then
        -- make the stuff we're hovering over a little brighter.
        highlight = 0.8

        -- right click -> edit this bind
        if InputPressed("rmb") then 
            filthyglobal_editingkeybind = var.configString
        end
    end

    UiTextShadow(0, 0, 0, 0.5, 1.5)
    UiTextOutline(0, 0, 0, 1, 0.1)

    -- highlight the checkbox, if this is the keybind we're editing
    if filthyglobal_editingkeybind == var.configString then
        UiColor(1.0, 1.0, highlight, 1)    
    elseif GetBool(cfgstr .. var.configString) then 
        UiColor(highlight, 1.0, highlight, 1)
    else 
        UiColor(1.0, highlight, highlight, 1)
    end

    if UiTextButton(var.legacyName) then
        config_FlipBool(cfgstr .. var.configString)
    end

    -- check if this is the checkbox of the keybind we're editing
    if filthyglobal_editingkeybind == var.configString then
        local lastKey = InputLastPressedKey()
        -- if a button was pressed
        if lastKey ~= "" then 
            if lastKey == "return" or lastKey == "esc" or lastKey == "insert" then 
                -- remove keybind
                SetString(cfgstr .. var.configString .. "_key", "null") 
                currentkey = ""  
            else
                SetString(cfgstr .. var.configString .. "_key", lastKey)
                currentkey = lastKey
            end
            -- we're no longer editing a keybind.
            filthyglobal_editingkeybind = " " 
        end
    end

    if currentkey ~= "" and currentkey ~= "null" then 
        UiPush()
        UiTranslate(namew, 0)
        UiText(" - " .. currentkey, false)
        UiPop()
    end

    UiPop()
    UiText("", true)
    -- make rects not overlap
    UiTranslate(0, 3)
end

legacyMenu_Button = function(name)
    UiPush()
    UiAlign("left top")

    UiTextShadow(0, 0, 0, 0.5, 2.0)
    UiTextOutline(0, 0, 0, 1, 0.1)
    
    local namew, nameh = UiGetTextSize(name)
    
    local highlight = 0.9

    if UiIsMouseInRect(namew, nameh) then
        highlight = 1
    end

    UiColor(highlight, highlight, highlight, 1)

    if UiTextButton(name) then
        UiPop()
        UiText("", true)
        UiTranslate(0, 3)
        return true
    end
    UiPop()
    UiText("", true)
    -- make rects not overlap
    UiTranslate(0, 3)
    return false
end

legacyMenu_SimpleCheckbox = function(name, value) 
    UiPush()
    UiAlign("left top")

    UiTextShadow(0, 0, 0, 0.5, 2.0)
    UiTextOutline(0, 0, 0, 1, 0.1)
    
    local namew, nameh = UiGetTextSize(name)
    
    local highlight = 0.6

    if UiIsMouseInRect(namew, nameh) then
        highlight = 0.8
    end

    if value == true then 
        UiColor(highlight, 1.0, highlight, 1)
    else 
        UiColor(1.0, highlight, highlight, 1)
    end

    if UiTextButton(name) then
        UiPop()
        UiText("", true)
        -- make rects not overlap
        UiTranslate(0, 3)
        return true
    end

    UiPop()
    UiText("", true)
    -- make rects not overlap
    UiTranslate(0, 3)
    return false
end

legacyMenu_NavButtonImg = function(image, tabid)
    UiPush()
        UiTranslate(50 + (tabid * 100), -20)
        
        local in_rect = UiIsMouseInRect(95,95)
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
    if alpha == nil then 
        alpha = true
    end

    local color = config_GetColor(var, GetTime())

    -- sub menu
    if active_sub_menu == var.configString then 
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
            local length = 90
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
                UiTranslate(10, 5)
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
                active_sub_menu = var.configString
                active_sub_menu_mode = "default"

            elseif InputPressed("rmb") then 
                active_sub_menu = var.configString
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

		UiTranslate(width + 30, 0)
		UiText(utils_Round(val*10)/10)
	UiPop()
    
	return val
end

legacyMenu_SubSettingSlider = function(var, sub, min, max) 
    UiPush()
        UiColor(1,1,1,1)
        local value = config_GetSubFloat(var, sub)
        value = legacyMenu_optionsSlider(value, min, max, 40)
        config_SetSubFloat(var, sub, value)
    UiPop()
    UiTranslate(0, 30)
end

legacyMenu_FunnySubmenuBegin = function(var, w, h)
    local literallyJustEnabled = false
    UiPush()
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
                active_sub_menu = var.configString
                literallyJustEnabled = true
            end
        end
    UiPop()
    local enabled = active_sub_menu == var.configString

    if enabled then 
        UiPush()
            UiTranslate(UiWidth() - 5, -20)
            if not UiIsMouseInRect(w, h) then
                if not literallyJustEnabled then 
                    if InputPressed("lmb") then 
                        active_sub_menu = nil
                    end    
                end
            end
            UiColor(0.23, 0.23, 0.23, 1)
            UiRect(w, h)

            UiTranslate(1, 1)

            UiColor(0.53, 0.53, 0.53, 0.6)
            UiRect(w -4, h-4)
            UiTranslate(20, 30)

    end
    return enabled
end

legacyMenu_SubSettingCheckbox = function(var, sub)
    UiPush()
    UiTranslate(-10, -20)
    UiAlign("left top")
    
    local namew, nameh = UiGetTextSize(sub.legacyName)
    
    local highlight = 0.6

    if UiIsMouseInRect(namew, nameh) then
        highlight = 0.8
    end

    UiTextShadow(0, 0, 0, 0.5, 1.5)
    UiTextOutline(0, 0, 0, 1, 0.1)

    -- highlight the checkbox, if this is the keybind we're editing
    if GetBool(cfgstr .. var.configString .. sub.configString) then 
        UiColor(highlight, 1.0, highlight, 1)
    else 
        UiColor(1.0, highlight, highlight, 1)
    end

    if UiTextButton(sub.legacyName) then
        config_FlipBool(cfgstr .. var.configString .. sub.configString)
    end

    UiPop()
    UiText("", true)
end