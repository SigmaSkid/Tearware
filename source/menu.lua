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
                -- weapons/aim/triggerbot idk?

                Checkbox(fInfiniteAmmo)

            elseif GetInt(cfgstr .. "activetab") == 1 then 
                -- visuals

                Checkbox(fVisuals)
                if GetBool(cfgstr .. "visuals") then 
                
                    Checkbox(fWatermark)
                    Checkbox(fFeatureList)
                    Checkbox(fObjectiveEsp)
                    Checkbox(fValuableEsp)
                    Checkbox(fToolEsp)
                    Checkbox(fWeaponGlow)
                    Checkbox(fActiveGlow)

                end

            elseif GetInt(cfgstr .. "activetab") == 2 then 
                -- movement

                Checkbox(fSpeed)
                Checkbox(fSpider)
                Checkbox(fFly)
                Checkbox(fNoclip)
                Checkbox(fFloorStrafe)
                Checkbox(fJetpack)
                Checkbox(fJesus)
                Checkbox(fQuickstop)

            elseif GetInt(cfgstr .. "activetab") == 3 then 
                -- misc

                Checkbox(fGodmode)
                Checkbox(fBulletTime)
                Checkbox(fSkipObjective)
                Checkbox(fDisableAlarm)
                Checkbox(fDisablePhysics)
                Checkbox(fForceUpdatePhysics)
            
            elseif GetInt(cfgstr .. "activetab") == 4 then 
                -- tools

                Checkbox(fRubberband)
                Checkbox(fTeleportValuables)
                Checkbox(fUnfairValuables)
                Checkbox(fTeleport)
                Checkbox(fExplosionBrush)
                Checkbox(fFireBrush)

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
    
    if UiIsMouseInRect(namew + kw, nameh) then
        UiColor(0.6, 0.6, 0.6, 1)

        if InputPressed("rmb") then 

            filthyglobal_editingkeybind = var[2]
        end
    end

    UiTextShadow(0, 0, 0, 0.5, 1.5)
    UiTextOutline(0, 0, 0, 1, 0.1)

    -- highlight the checkbox, if this is the keybind we're editing
    if filthyglobal_editingkeybind == var[2] then
        UiColor(1.0, 1.0, 0.6, 1)    
    elseif GetBool(cfgstr .. var[2]) then 
        UiColor(0.6, 1.0, 0.6, 1)
    else 
        UiColor(1.0, 0.6, 0.6, 1)
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
end

function Button(name)
    UiPush()
    UiAlign("left top")

    UiTextShadow(0, 0, 0, 0.5, 2.0)
    
    UiColor(1.0, 0.6, 1.0, 1)
    
    if UiTextButton(name) then
        UiPop()
        UiText("", true)
        return true
    end
    UiPop()
    UiText("", true)
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
