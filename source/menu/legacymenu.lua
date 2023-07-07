-- tearware on top

legacyMenu = {}

legacyMenu.DrawLegacyMenu = function(rgb) 
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
                legacyMenu.NavButtonImg("source/img/visuals-icon.png", 0)
                legacyMenu.NavSep(0)
                legacyMenu.NavButton("B", 1)
                legacyMenu.NavSep(1)
                legacyMenu.NavButton("C", 2)
                legacyMenu.NavSep(2)
                legacyMenu.NavButton("D", 3)
                legacyMenu.NavSep(3)
                legacyMenu.NavButton("E", 4)
            UiPop()
        UiPop()

        UiTranslate(-UiCenter() + 10, UiMiddle() * -0.64)
        
        UiAlign("left top")
        UiColor(1, 1, 1, 1)
        
        UiPush()
            if GetInt(cfgstr .. "activetab") == 0 then 
                -- visuals

                legacyMenu.Checkbox(fWatermark)
                legacyMenu.ColorSelector(fWatermark)

                legacyMenu.Checkbox(fFeatureList)
                legacyMenu.ColorSelector(fFeatureList)

                legacyMenu.Checkbox(fObjectiveEsp)
                legacyMenu.ColorSelector(fObjectiveEsp)
                if config.AdvGetBool(fObjectiveEsp) then 
                    legacyMenu.Checkbox(fOptionalEsp)
                    legacyMenu.ColorSelector(fOptionalEsp)
                end

                legacyMenu.Checkbox(fValuableEsp)
                legacyMenu.ColorSelector(fValuableEsp)

                legacyMenu.Checkbox(fToolEsp)
                legacyMenu.ColorSelector(fToolEsp)

                legacyMenu.Checkbox(fWeaponGlow)
                legacyMenu.ColorSelector(fWeaponGlow)

                legacyMenu.Checkbox(fActiveGlow)
                legacyMenu.ColorSelector(fActiveGlow)

                legacyMenu.Checkbox(fRainbowFog)
                legacyMenu.ColorSelector(fRainbowFog, false)
                
                legacyMenu.Checkbox(fPostProcess)
                legacyMenu.ColorSelector(fPostProcess)
                
                legacyMenu.Checkbox(fSpinnyTool)

            elseif GetInt(cfgstr .. "activetab") == 1 then 
                -- movement

                legacyMenu.Checkbox(fSpeed)
                if legacyMenu.FunnySubmenuBegin(fSpeed, 120, 80) then 
                    legacyMenu.SubSettingSlider(fSpeed, fSubSpeed, 10, 30)
                    legacyMenu.SubSettingSlider(fSpeed, fSubBoost, 10, 40)
                    UiPop()
                end

                legacyMenu.Checkbox(fSpider)
                legacyMenu.Checkbox(fFly)
                if legacyMenu.FunnySubmenuBegin(fFly, 120, 80) then 
                    legacyMenu.SubSettingSlider(fFly, fSubSpeed, 10, 30)
                    legacyMenu.SubSettingSlider(fFly, fSubBoost, 10, 40)
                    UiPop()
                end

                legacyMenu.Checkbox(fNoclip)
                if legacyMenu.FunnySubmenuBegin(fNoclip, 120, 80) then 
                    legacyMenu.SubSettingSlider(fNoclip, fSubSpeed, 1, 5)
                    legacyMenu.SubSettingSlider(fNoclip, fSubBoost, 1, 20)
                    UiPop()
                end

                legacyMenu.Checkbox(fFloorStrafe)
                legacyMenu.Checkbox(fAutoBunnyhop)
                legacyMenu.Checkbox(fJetpack)
                legacyMenu.Checkbox(fJesus)
                legacyMenu.Checkbox(fQuickstop)

            elseif GetInt(cfgstr .. "activetab") == 2 then 
                -- misc

                legacyMenu.Checkbox(fInfiniteAmmo)
                legacyMenu.Checkbox(fSuperStrength)
                legacyMenu.Checkbox(fGodmode)
                legacyMenu.Checkbox(fBulletTime)
                if legacyMenu.FunnySubmenuBegin(fBulletTime, 120, 80) then 
                    legacyMenu.SubSettingSlider(fBulletTime, fBulletTimeScale, 10, 100)
                    legacyMenu.SubSettingCheckbox(fBulletTime, fBulletTimePatch)
                    UiPop()
                end

                legacyMenu.Checkbox(fSkipObjective)
                legacyMenu.Checkbox(fDisableAlarm)
                legacyMenu.Checkbox(fDisableRobots)
                legacyMenu.Checkbox(fDisablePhysics)
                legacyMenu.Checkbox(fForceUpdatePhysics)


            elseif GetInt(cfgstr .. "activetab") == 3 then 
                -- tools

                legacyMenu.Checkbox(fRubberband)
                legacyMenu.ColorSelector(fRubberband, false)

                legacyMenu.Checkbox(fTeleportValuables)
                legacyMenu.Checkbox(fUnfairValuables)
                legacyMenu.Checkbox(fTeleport)

                legacyMenu.Checkbox(fExplosionBrush)
                if legacyMenu.FunnySubmenuBegin(fExplosionBrush, 120, 50) then 
                    legacyMenu.SubSettingSlider(fExplosionBrush, fExplosionBrushSize, 0.5, 4)
                    UiPop()
                end

                legacyMenu.Checkbox(fFireBrush)
                legacyMenu.Checkbox(fStructureRestorer)

            elseif GetInt(cfgstr .. "activetab") == 4 then 
                if legacyMenu.Button(fMenuResetConfig) then 
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

                if legacyMenu.Button(fMenuFinishLevel) then
                    SetString("level.state", "win") 
                end

                if legacyMenu.Button(fMenuActivateRobots) then
                    local robots = FindBodies("body", true)

                    for i = 1, #robots do
                        local active = HasTag(robots[i], "inactive")
                        if active then 
                            RemoveTag(robots[i], "inactive")
                        end 
                    end
                end

                if legacyMenu.Button(fRegistryTool) then
                    openMenu = "registry"
                end

                if legacyMenu.Button("dropdown menu") then
                    config.SetInt(fMenuStyle, 1)
                end
            end

        UiPop()

    UiPop() 
end

legacyMenu.Checkbox = function(var)
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
        config.FlipBool(cfgstr .. var.configString)
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

legacyMenu.Button = function(name)
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

legacyMenu.SimpleCheckbox = function(name, value) 
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

legacyMenu.NavButton = function(name, tabid)
    UiPush()
        UiTranslate(50 + (tabid * 100), -20)
        UiFont("bold.ttf", 120)
        UiTextOutline(0, 0, 0, 1, 0.1)

        if tabid == GetInt(cfgstr .. "activetab") then 
            UiColor(0.8, 0.8, 0.8, 1)
            UiTextShadow(0.7, 0.7, 0.7, 0.5, 1.0)
        else
            UiColor(0.5, 0.5, 0.5, 1)
            UiTextShadow(0, 0, 0, 0.5, 1.0)
        end

        if UiTextButton(name) then
            SetInt(cfgstr .. "activetab", tabid)
        end
    UiPop()
end

legacyMenu.NavButtonImg = function(image, tabid)
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

legacyMenu.NavSep = function(tabid)
    UiPush()
        UiTranslate(100 + (tabid * 100), -14)
        UiColor(0.23, 0.23, 0.23, 1)
        UiRect(3, UiHeight() * 0.15)
    UiPop()
end

legacyMenu.ColorSelector = function(var, alpha)
    if alpha == nil then 
        alpha = true
    end

    local color = config.GetColor(var, GetTime())

    if active_sub_menu == var.configString then 
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

                if legacyMenu.SimpleCheckbox("rainbow", color.rainbow) then 
                    color.rainbow = not color.rainbow
                end
            UiPop()

            UiPush()

                UiTranslate(20, 30)
                UiColor(1, 0.5, 0.5)
                color.red = legacyMenu.optionsSlider(color.red * 100, 0, 100, 40) / 100

                UiTranslate(0, 30)
                UiColor(0.5, 1, 0.5)
                color.green = legacyMenu.optionsSlider(color.green * 100, 0, 100, 40) / 100

                UiTranslate(0, 30)
                UiColor(0.5, 0.5, 1)
                color.blue = legacyMenu.optionsSlider(color.blue * 100, 0, 100, 40) / 100
                
                if alpha then 
                    UiTranslate(0, 30)
                    UiColor(0.7, 0.7, 0.7)
                    color.alpha = legacyMenu.optionsSlider(color.alpha * 100, 0, 100, 40) / 100
                end
            UiPop()

        UiPop() 
        
        config.SetColor(var, color)
    end

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
            elseif InputPressed("rmb") then 
                funnyColorCopyCache = color
            elseif InputPressed("mmb") then 
                config.SetColor(var, funnyColorCopyCache)
            elseif InputPressed("backspace") then 
                config.ResetColorToDefault(var)
            end
        end
    UiPop()
end

legacyMenu.optionsSlider = function(val, mi, ma, width)
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
                    val = utils.Clamp(val, mi, ma)
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
        val = utils.Clamp(val, mi, ma)

		UiTranslate(width + 30, 0)
		UiText(utils.Round(val*10)/10)
	UiPop()
    
	return val
end

legacyMenu.SubSettingSlider = function(var, sub, min, max) 
    UiPush()
        UiColor(1,1,1,1)
        local value = config.GetSubFloat(var, sub)
        value = legacyMenu.optionsSlider(value, min, max, 40)
        config.SetSubFloat(var, sub, value)
    UiPop()
    UiTranslate(0, 30)
end

legacyMenu.FunnySubmenuBegin = function(var, w, h)
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

legacyMenu.SubSettingCheckbox = function(var, sub)
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
        config.FlipBool(cfgstr .. var.configString .. sub.configString)
    end

    UiPop()
    UiText("", true)
end