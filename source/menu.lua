-- tearware on top

function DrawMenu() 
    -- funny rgb blur background
    UiPush()
        UiAlign("center middle")

        local rgb = seedToRGB(GetTime())
        UiColor(rgb.R, rgb.G, rgb.B, 0.0420)
        
        UiTranslate(UiCenter(), UiMiddle())
        UiRect(UiWidth(), UiHeight())
        
        UiBlur(0.3)
    UiPop()

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
                NavButton("A", 0)
                NavSep(0)
                NavButton("B", 1)
                NavSep(1)
                NavButton("C", 2)
                NavSep(2)
                NavButton("D", 3)
                NavSep(3)
                NavButton("E", 4)
            UiPop()
        UiPop()

        UiTranslate(-UiCenter() + 10, UiMiddle() * -0.64)
        
        UiAlign("left top")
        UiColor(1, 1, 1, 1)
        
        UiPush()
            if GetInt(cfgstr .. "activetab") == 0 then 
                -- visuals

                Checkbox(fVisuals)

                Checkbox(fWatermark)
                ColorSelector(fWatermark)

                Checkbox(fFeatureList)
                ColorSelector(fFeatureList)

                Checkbox(fObjectiveEsp)
                ColorSelector(fObjectiveEsp)
                if AdvGetBool(fObjectiveEsp) then 
                    Checkbox(fOptionalEsp)
                    ColorSelector(fOptionalEsp)
                end

                Checkbox(fValuableEsp)
                ColorSelector(fValuableEsp)

                Checkbox(fToolEsp)
                ColorSelector(fToolEsp)

                Checkbox(fWeaponGlow)
                ColorSelector(fWeaponGlow)

                Checkbox(fActiveGlow)
                ColorSelector(fActiveGlow)

                Checkbox(fRainbowFog)
                ColorSelector(fRainbowFog, false)
                
                Checkbox(fPostProcess)
                ColorSelector(fPostProcess)
                
                -- very secret
                if InputDown("shift") and UiIsMouseInRect(125, 25) then 
                    Checkbox(fSpinnyTool)
                end

            elseif GetInt(cfgstr .. "activetab") == 1 then 
                -- movement

                Checkbox(fSpeed)
                if FunnySubmenuBegin(fSpeed, 120, 80) then 
                    SubSettingSlider(fSpeed, fSubSpeed, 10, 30)
                    SubSettingSlider(fSpeed, fSubBoost, 10, 40)
                    UiPop()
                end

                Checkbox(fSpider)
                Checkbox(fFly)
                if FunnySubmenuBegin(fFly, 120, 80) then 
                    SubSettingSlider(fFly, fSubSpeed, 10, 30)
                    SubSettingSlider(fFly, fSubBoost, 20, 40)
                    UiPop()
                end

                Checkbox(fNoclip)
                if FunnySubmenuBegin(fNoclip, 120, 80) then 
                    SubSettingSlider(fNoclip, fSubSpeed, 1, 5)
                    SubSettingSlider(fNoclip, fSubBoost, 1, 20)
                    UiPop()
                end

                Checkbox(fFloorStrafe)
                Checkbox(fJetpack)
                Checkbox(fJesus)
                Checkbox(fQuickstop)

            elseif GetInt(cfgstr .. "activetab") == 2 then 
                -- misc

                Checkbox(fInfiniteAmmo)
                Checkbox(fSuperStrength)
                Checkbox(fGodmode)
                Checkbox(fBulletTime)
                if FunnySubmenuBegin(fBulletTime, 120, 80) then 
                    SubSettingSlider(fBulletTime, fBulletTimeScale, 10, 100)
                    SubSettingCheckbox(fBulletTime, fBulletTimePatch)
                    UiPop()
                end

                Checkbox(fSkipObjective)
                Checkbox(fDisableAlarm)
                Checkbox(fDisableRobots)
                Checkbox(fDisablePhysics)
                Checkbox(fForceUpdatePhysics)
            
            elseif GetInt(cfgstr .. "activetab") == 3 then 
                -- tools

                Checkbox(fRubberband)
                ColorSelector(fRubberband, false)

                Checkbox(fTeleportValuables)
                Checkbox(fUnfairValuables)
                Checkbox(fTeleport)

                Checkbox(fExplosionBrush)
                if FunnySubmenuBegin(fExplosionBrush, 120, 50) then 
                    SubSettingSlider(fExplosionBrush, fExplosionBrushSize, 0.5, 4)
                    UiPop()
                end

                Checkbox(fFireBrush)

            elseif GetInt(cfgstr .. "activetab") == 4 then 
                -- debug
                if Button(fMenuResetConfig) then 
                    openMenu = "reset"
                end

                if Button(fMenuFinishLevel) then
                    SetString("level.state", "win") 
                end

                if Button(fMenuActivateRobots) then
                    local robots = FindBodies("body", true)

                    for i = 1, #robots do
                        local active = HasTag(robots[i], "inactive")
                        if active then 
                            RemoveTag(robots[i], "inactive")
                        end 
                    end
                end

                if Button(fRegistryTool) then
                    openMenu = "registry"
                end

            end

        UiPop()

    UiPop() 
end

function Checkbox(var)
    UiPush()
    UiAlign("left top")
    
    local currentkey = GetString(cfgstr .. var[2] .. "_key")
    local kw, kh = UiGetTextSize(" - " .. currentkey)

    local namew, nameh = UiGetTextSize(var[1])
    
    local highlight = 0.6

    if UiIsMouseInRect(namew + kw, nameh) then
        -- make the stuff we're hovering over a little brighter.
        highlight = 0.8

        -- right click -> edit this bind
        if InputPressed("rmb") then 
            filthyglobal_editingkeybind = var[2]
        end
    end

    UiTextShadow(0, 0, 0, 0.5, 1.5)
    UiTextOutline(0, 0, 0, 1, 0.1)

    -- highlight the checkbox, if this is the keybind we're editing
    if filthyglobal_editingkeybind == var[2] then
        UiColor(1.0, 1.0, highlight, 1)    
    elseif GetBool(cfgstr .. var[2]) then 
        UiColor(highlight, 1.0, highlight, 1)
    else 
        UiColor(1.0, highlight, highlight, 1)
    end

    if UiTextButton(var[1]) then
        SetBool(cfgstr .. var[2], not GetBool(cfgstr .. var[2]))
    end

    -- check if this is the checkbox of the keybind we're editing
    if filthyglobal_editingkeybind == var[2] then
        local lastKey = InputLastPressedKey()
        -- if a button was pressed
        if lastKey ~= "" then 
            if lastKey == "return" or lastKey == "esc" or lastKey == "insert" then 
                -- remove keybind
                SetString(cfgstr .. var[2] .. "_key", "null") 
                currentkey = ""  
            else
                SetString(cfgstr .. var[2] .. "_key", lastKey)
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

function Button(name)
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

function SimpleCheckbox(name, value) 
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

function NavButton(name, tabid)
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

function NavSep(tabid)
    UiPush()
        UiTranslate(100 + (tabid * 100), -14)
        UiColor(0.23, 0.23, 0.23, 1)
        UiRect(3, UiHeight() * 0.15)
    UiPop()
end

function ColorSelector(var, alpha)
    if alpha == nil then 
        alpha = true
    end

    local color = GetColor(var, GetTime())

    if active_sub_menu == var[2] then 
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

                if SimpleCheckbox("rainbow", color.rainbow) then 
                    color.rainbow = not color.rainbow
                end
            UiPop()

            UiPush()

                UiTranslate(20, 30)
                UiColor(1, 0.5, 0.5)
                color.red = optionsSlider(color.red * 100, 0, 100, 40) / 100

                UiTranslate(0, 30)
                UiColor(0.5, 1, 0.5)
                color.green = optionsSlider(color.green * 100, 0, 100, 40) / 100

                UiTranslate(0, 30)
                UiColor(0.5, 0.5, 1)
                color.blue = optionsSlider(color.blue * 100, 0, 100, 40) / 100
                
                if alpha then 
                    UiTranslate(0, 30)
                    UiColor(0.7, 0.7, 0.7)
                    color.alpha = optionsSlider(color.alpha * 100, 0, 100, 40) / 100
                end
            UiPop()

        UiPop() 
        
        SetColor(var, color)
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
                active_sub_menu = var[2]
            elseif InputPressed("rmb") then 
                funnyColorCopyCache = color
            elseif InputPressed("mmb") then 
                SetColor(var, funnyColorCopyCache)
            elseif InputPressed("backspace") then 
                ResetColorToDefault(var)
            end
        end
    UiPop()
end

function optionsSlider(val, mi, ma, width)
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
                    val = Clamp(val, mi, ma)
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
        val = Clamp(val, mi, ma)

		UiTranslate(width + 30, 0)
		UiText(MathRound(val*10)/10)
	UiPop()
	return val
end

function SubSettingSlider(var, sub, min, max) 
    UiPush()
        UiColor(1,1,1,1)
        local value = GetSubFloat(var, sub)
        value = optionsSlider(value, min, max, 40)
        SetSubFloat(var, sub, value)
    UiPop()
    UiTranslate(0, 30)
end

function FunnySubmenuBegin(var, w, h)
    local literallyJustEnabled = false
    UiPush()
        UiAlign("left top")
        UiTranslate(UiWidth() - 35, -20)
        
        local colorSquareSize = 20
        UiPush()
            UiColor(0.3,0.3,0.3,1)
            UiRect(colorSquareSize, colorSquareSize)
            UiTranslate(2,2)
            UiColor(0.7,0.7,0.7,1)
            UiRect(colorSquareSize-2, colorSquareSize-2)
        UiPop()

        if UiIsMouseInRect(colorSquareSize, colorSquareSize) then
            if InputPressed("lmb") then 
                active_sub_menu = var[2]
                literallyJustEnabled = true
            end
        end
    UiPop()
    local enabled = active_sub_menu == var[2]

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

function SubSettingCheckbox(var, sub)
    UiPush()
    UiTranslate(-10, -20)
    UiAlign("left top")
    
    local namew, nameh = UiGetTextSize(sub[1])
    
    local highlight = 0.6

    if UiIsMouseInRect(namew, nameh) then
        highlight = 0.8
    end

    UiTextShadow(0, 0, 0, 0.5, 1.5)
    UiTextOutline(0, 0, 0, 1, 0.1)

    -- highlight the checkbox, if this is the keybind we're editing
    if GetBool(cfgstr .. var[2] .. sub[2]) then 
        UiColor(highlight, 1.0, highlight, 1)
    else 
        UiColor(1.0, highlight, highlight, 1)
    end

    if UiTextButton(sub[1]) then
        SetBool(cfgstr .. var[2] .. sub[2], not GetBool(cfgstr .. var[2] .. sub[2]))
    end

    UiPop()
    UiText("", true)
end

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