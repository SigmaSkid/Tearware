-- parts of this are placeholders,
-- some of this should be a part of the config system!
playerDropdown = {}
playerDropdown.name = "Player"
playerDropdown.func = "MenuDrawPlayer"
playerDropdown.queue = 1
playerDropdown.position = {}
playerDropdown.position.x = 200
playerDropdown.position.y = 200
playerDropdown.size = {}
playerDropdown.size.x = 150
playerDropdown.size.y = 200
playerDropdown.dropdown = false

worldDropdown = {}
worldDropdown.name = "World"
worldDropdown.func = "MenuDrawWorld"
worldDropdown.queue = 2
worldDropdown.position = {}
worldDropdown.position.x = 400
worldDropdown.position.y = 200
worldDropdown.size = {}
worldDropdown.size.x = 150
worldDropdown.size.y = 200
worldDropdown.dropdown = false

visualsDropdown = {}
visualsDropdown.name = "Visuals"
visualsDropdown.func = "MenuDrawVisuals"
visualsDropdown.queue = 3
visualsDropdown.position = {}
visualsDropdown.position.x = 600
visualsDropdown.position.y = 200
visualsDropdown.size = {}
visualsDropdown.size.x = 150
visualsDropdown.size.y = 200
visualsDropdown.dropdown = false

toolsDropdown = {}
toolsDropdown.name = "Tools"
toolsDropdown.func = "MenuDrawTools"
toolsDropdown.queue = 4
toolsDropdown.position = {}
toolsDropdown.position.x = 800
toolsDropdown.position.y = 200
toolsDropdown.size = {}
toolsDropdown.size.x = 150
toolsDropdown.size.y = 200
toolsDropdown.dropdown = false

miscDropdown = {}
miscDropdown.name = "Misc"
miscDropdown.func = "MenuDrawMisc"
miscDropdown.queue = 5
miscDropdown.position = {}
miscDropdown.position.x = 1000
miscDropdown.position.y = 200
miscDropdown.size = {}
miscDropdown.size.x = 150
miscDropdown.size.y = 200
miscDropdown.dropdown = false

tileWeAreChangingPosOf = 'none'
offsetsOffset = {}
offsetsOffset.x = 0
offsetsOffset.y = 0

resizeOffset = 0

local drawOrder = {
    playerDropdown,
    worldDropdown,
    visualsDropdown,
    toolsDropdown,
    miscDropdown
}

shouldUpdateOrder = false

-- TODO:
-- find vertical size of each window
-- start moving some values into the cfg system (position, dropdown)
-- 
--

dropdownMenu = {}

dropdownMenu.UpdateDrawOrder = function()
    if not shouldUpdateOrder then return end

    local newDrawOrder = {}
    for _, entry in ipairs(drawOrder) do
        newDrawOrder[entry.queue] = entry
    end
    drawOrder = newDrawOrder
end

dropdownMenu.GetInteractable = function()
    local output = nil
    for i = 1, #drawOrder do
        if output == nil then
            local object = drawOrder[i] 
            UiPush()
                UiTranslate(object.position.x, object.position.y)

                UiColor(1, 0, 0, 0.7)
                if UiIsMouseInRect(object.size.x, object.size.y) then 
                    UiColor(0, 1, 0, 0.7)
                    if InputPressed('lmb') then 
                        dropdownMenu.moveObjectToForeground(object)
                    end

                    output = object.queue 
                end

                UiRect(object.size.x + 50, object.size.y)

            UiPop()
        end
    end

    return output
end

dropdownMenu.moveObjectToForeground = function(object)
    if object.queue ~= 1 then 
        shouldUpdateOrder = true
        local oldpos = object.queue 
        object.queue = 1
        
        for i=1, oldpos-1 do
            drawOrder[i].queue = drawOrder[i].queue + 1
        end
    end
end

dropdownMenu.InteractRect = function(x, z, canInteract)
    if canInteract and 
    InputPressed("lmb") and
    UiIsMouseInRect(x, z) then 
        return true 
    end

    return false
end

-- main
dropdownMenu.DrawDropdownMenu = function()
    if not InputDown('lmb') then 
        tileWeAreChangingPosOf = 'none'
    end

    shouldUpdateOrder = false

    -- get which object we can interact with.
    -- also move relevant object to foreground
    local interactTarget = dropdownMenu.GetInteractable()

    -- just update the array.
    dropdownMenu.UpdateDrawOrder()

    -- Iterate over the table and call each function
    -- do it in the opposite direction, cuz first element is on top, last on bottom
    for i = #drawOrder, 1, -1 do
        local entry = drawOrder[i]
        resizeOffset = 0
        dropdownMenu[entry.func](interactTarget == entry.queue)
        dropdownMenu.UpdateSize(entry)
        --DebugWatch(entry.name, entry.queue)
    end

    -- update keybind input
    dropdownMenu.KeybindUIUpdateInput()
end

dropdownMenu.UpdateSize = function(entry)
    entry.size.x = 150
    entry.size.y = resizeOffset
end

-- player, world, visuals, tools, misc
dropdownMenu.DrawHeader = function(item, canInteract)
    UiPush()
        UiTranslate(item.position.x, item.position.y)

        UiPush()
            local x, y = UiGetMousePos()

            if dropdownMenu.InteractRect(150, 50, canInteract)
            and tileWeAreChangingPosOf ~= item.name then
                tileWeAreChangingPosOf = item.name
                offsetsOffset.x = x
                offsetsOffset.y = y
            end
            
            if InputDown('lmb') and tileWeAreChangingPosOf == item.name then 
                -- hardcoded for 1080p cuz the game forces scaling from/to that anyway
                item.position.x = utils.Clamp(item.position.x + x - offsetsOffset.x, 0, 1920-150)
                item.position.y = utils.Clamp(item.position.y + y - offsetsOffset.y, 0, 1080-50)
            end

        UiPop()

        if item.dropdown then 
            UiPush()
                UiTranslate(150/2, 50/2)
                UiAlign("center middle")

                UiPush()
                    UiTranslate(0, -2)
                    UiColor(0.23, 0.23, 0.23, 0.3)
                    UiRect(156, 53)
                UiPop()

                UiColor(0.13, 0.13, 0.13, 0.9)
                UiRect(150, 50)
            UiPop()
        else    
            UiPush()
                UiTranslate(150/2, 50/2)
                UiAlign("center middle")

                UiColor(0.23, 0.23, 0.23, 0.3)
                UiRect(156, 56)
                
                UiColor(0.13, 0.13, 0.13, 0.9)
                UiRect(150, 50)
            UiPop()
        end

        UiPush()
            UiTranslate(10, 10)
            UiColor(1,1,1,1)
            UiFont("regular.ttf", 35)
            UiTextShadow(0, 0, 0, 0.7, 1.5)
            UiTextOutline(0, 0, 0, 0.7, 0.1)
            UiAlign("left bottom")

            -- haha dirty hack
            local w, h = UiGetTextSize(item.name)
            UiTranslate(0, h)
            --

            UiText(item.name)
        UiPop()

        UiPush()
            UiTranslate(130, 50/2)
            UiColor(1,1,1,1)
            UiFont("regular.ttf", 28)
            UiTextShadow(0, 0, 0, 0.7, 1.5)
            UiTextOutline(0, 0, 0, 0.7, 0.1)
            UiAlign("center middle")
            
            if dropdownMenu.InteractRect(20, 20, canInteract) then 
                item.dropdown = not item.dropdown
            end

            if item.dropdown then 
                UiRotate(180)
            end

            UiText("v")
        UiPop()
    
    if not item.dropdown then 
        UiPop()
    else
        UiTranslate(0, 50)
    end

    resizeOffset = resizeOffset + 50
    return item.dropdown
end

-- updates the registry/config key responsible for the input.
dropdownMenu.KeybindUIUpdateInput = function()
    -- todo, make this filthy global a value in dropdownMenu table
    if filthyglobal_editingkeybind ~= " " and filthyglobal_editingkeybind ~= nil then 
        local lastKey = utils.GetLastInputBetter() -- allows for like 4 keys more, lol very cool
        if lastKey ~= nil and lastKey ~= "" then 
            if lastKey == "return" or lastKey == "esc" or lastKey == "insert" then 
                -- remove keybind
                SetString(cfgstr .. filthyglobal_editingkeybind .. "_key", "null") 
                currentkey = ""  
            else
                SetString(cfgstr .. filthyglobal_editingkeybind .. "_key", lastKey)
                currentkey = lastKey
            end
            -- we're no longer editing a keybind.
            filthyglobal_editingkeybind = " " 
        end
    end
end


-- 
dropdownMenu.DrawKeybindUI = function(var, canInteract)
    local currentkey = GetString(cfgstr .. var.configString .. "_key")
    local kw, kh = UiGetTextSize(" - " .. currentkey)

    UiPush()
        -- background
        UiPush()
            UiTranslate(150/2, 28/2)
            UiAlign("center middle")

            UiColor(0.18, 0.18, 0.18, 0.3)
            UiRect(156, 28)

            UiColor(0.05, 0.05, 0.05, 0.9)
            UiRect(150, 28)

            UiColor(0.28, 0.28, 0.28, 0.9)
            UiRect(146, 26)
        UiPop()
    
        -- select from a list, how feature should behave
        -- ALWAYS | TOGGLE | HOLD | OFF HOLD | NEVER
        -- why would you want to have something be ENABLED but NEVER done? Idfk, maybe you do
        -- if there was no keybind and added a keybind change to toggle
        -- (has to implement this into keybind system first)
        UiPush()
            UiTranslate(10, 4)
            UiColor(1,1,1,1)
            UiFont("regular.ttf", 22)
            UiTextShadow(0, 0, 0, 0.7, 1.5)
            UiTextOutline(0, 0, 0, 0.7, 0.1)
            UiAlign("left bottom")

            local name = "TOGGLE"

            local w, h = UiGetTextSize(name)
            UiTranslate(0, h)

            UiText(name)
        UiPop()
        
        -- Key background + interactivity.
        UiPush()
            UiTranslate(150-24, 28/2)
            UiAlign("center middle")

            -- UiColor(1,1,1,1)
            -- UiRect(40, 24)

            UiColor(0.2, 0.2, 0.2, 0.3)
            UiRect(40, 24)

            -- todo: 
            -- different color depending on whether there is a keybind set to the feature.
            if filthyglobal_editingkeybind == var.configString then 
                UiColor(0.35, 0.65, 0.35, 0.9)
            else 
                UiColor(0.35, 0.35, 0.35, 0.9)
            end

            UiRect(38, 22)

            if dropdownMenu.InteractRect(40, 24, canInteract) then 
                filthyglobal_editingkeybind = var.configString
            end
        UiPop()

        -- Display key icon thing.
        UiPush()
            UiTranslate(150-24, 28/2)
            UiAlign("center middle")
            UiFont("regular.ttf", 22)
            UiTextShadow(0, 0, 0, 0.7, 1.5)
            UiTextOutline(0, 0, 0, 0.7, 0.1)

            local key = GetString(cfgstr .. var.configString .. "_key")

            UiText(utils.ShortenKeyString(key))
        UiPop()

    UiPop()

    UiTranslate(0, 28)
    resizeOffset = resizeOffset + 28
end

-- speedhack etc.
-- drawfeature needs to include keybind btw @Sigma
dropdownMenu.DrawFeature = function(var, canInteract, noSubSettings)
    UiPush()
        -- background
        UiPush()
            UiTranslate(150/2, 40/2)
            UiAlign("center middle")

            UiColor(0.18, 0.18, 0.18, 0.3)
            UiRect(156, 40)

            UiColor(0.05, 0.05, 0.05, 0.9)
            UiRect(150, 40)

            UiColor(0.18, 0.18, 0.18, 0.9)
            UiRect(146, 38)
        UiPop()

        -- text
        -- todo: find a way to scale font & wrap text for features
        -- with names that are wayyyy too long.
        UiPush()
            UiTranslate(10, 5)
            local fontsize = 28
            UiFont("regular.ttf", fontsize)
            UiTextShadow(0, 0, 0, 0.7, 1.5)
            UiTextOutline(0, 0, 0, 0.7, 0.1)
            UiAlign("left bottom")

            local w, h = UiGetTextSize(var.dropdownName)
            UiTranslate(0, h)
            -- haha, precompiled values? NO! Waste compute reasources! Heck yeah! Enterprise grade code! Less go
            while (w > 100) do 
                fontsize = fontsize - 4
                UiFont("regular.ttf", fontsize)

                w, h = UiGetTextSize(var.dropdownName)
            end


            local feature_state = config.AdvGetBool(var)
            if feature_state then 
                UiColor(1,1,1,1)            
            else
                UiColor(0.5,0.5,0.5,1)    
            end

            UiText(var.dropdownName)
        UiPop()
  
        -- interaction
        UiPush()
            UiColor(1,1,1,1)    
            if dropdownMenu.InteractRect(100, 40, canInteract) then 
                config.FlipBool(cfgstr .. var.configString)
            end
            --UiRect(100, 40)
        UiPop()

        -- V
        local dropdown_state = false
        if noSubSettings ~= true then 
            UiPush()
                UiTranslate(130, 50/2)
                UiTranslate(0, -5)
                UiColor(1,1,1,1)
                UiFont("regular.ttf", 22)
                UiTextShadow(0, 0, 0, 0.7, 1.5)
                UiTextOutline(0, 0, 0, 0.7, 0.1)
                UiAlign("center middle")
                
                if dropdownMenu.InteractRect(20, 20, canInteract) then 
                    config.FlipBool(cfgstr .. var.configString .. "_dropdown")
                end
                --UiRect(20,20)
                dropdown_state = GetBool(cfgstr .. var.configString .. "_dropdown")

                if dropdown_state then 
                    UiRotate(180)
                end

                UiText("v")
            UiPop()
        end 

    UiPop()

    UiTranslate(0, 40)
    resizeOffset = resizeOffset + 40
    -- 

    -- keybind
    if dropdown_state then 
        dropdownMenu.DrawKeybindUI(var, canInteract)
    end
    --
    return dropdown_state
end

dropdownMenu.ComboBox = function()
    -- well, doing this will be 'fun'
end

dropdownMenu.ColorSelect = function(var, canInteract)
    UiPush()
        -- background
        UiPush()
            UiTranslate(150/2, 28/2)
            UiAlign("center middle")

            UiColor(0.18, 0.18, 0.18, 0.3)
            UiRect(156, 28)

            UiColor(0.05, 0.05, 0.05, 1)
            UiRect(150, 28)
        UiPop()

        UiPush()
            UiTranslate(150/2, 28/2)
            UiAlign("center middle")

            local color = config.GetColor(var, GetTime())

            UiColor(color.red, color.green, color.blue, color.alpha)
            UiRect(146, 26)

            if dropdownMenu.InteractRect(146, 26, canInteract) then 
                -- AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
            end
        UiPop()
    UiPop()


    UiTranslate(0, 28)
    resizeOffset = resizeOffset + 28
end

-- list select sub, taking sub button space
dropdownMenu.ListSubSelect = function(var, canInteract)
    -- luckily nothing uses it yet :)
end

-- normal list select, taking full button space
dropdownMenu.ListSelect = function(var, canInteract)
    UiPush()
        -- background
        UiPush()
            UiTranslate(150/2, 40/2)
            UiAlign("center middle")

            UiColor(0.18, 0.18, 0.18, 0.3)
            UiRect(156, 40)

            UiColor(0.05, 0.05, 0.05, 0.9)
            UiRect(150, 40)

            UiColor(0.18, 0.18, 0.18, 0.9)
            UiRect(146, 38)
        UiPop()

    UiPop()
    
    UiTranslate(0, 40)
    resizeOffset = resizeOffset + 40
end

dropdownMenu.BaseButton = function(name, canInteract)
    local output = false
    UiPush()
        UiPush()
            UiTranslate(150/2, 40/2)
            UiAlign("center middle")

            UiColor(0.18, 0.18, 0.18, 0.3)
            UiRect(156, 40)

            UiColor(0.05, 0.05, 0.05, 0.9)
            UiRect(150, 40)

            UiColor(0.18, 0.18, 0.18, 0.9)
            UiRect(146, 38)

            if dropdownMenu.InteractRect(150, 40, canInteract) then 
                output = true
            end
        UiPop()
    
        UiPush()
            UiTranslate(10, 5)
            UiColor(1,1,1,1)
            UiFont("regular.ttf", 28)
            UiTextShadow(0, 0, 0, 0.7, 1.5)
            UiTextOutline(0, 0, 0, 0.7, 0.1)
            UiAlign("left bottom")

            local w, h = UiGetTextSize(name)
            UiTranslate(0, h)

            UiText(name)
        UiPop()
    UiPop()
    UiTranslate(0, 40)
    resizeOffset = resizeOffset + 40
    return output
end

dropdownMenu.DrawBottomGradient = function()
    UiPush()
        UiTranslate(150/2, 2)
        UiAlign("center middle")

        UiColor(0.18, 0.18, 0.18, 0.3)
        UiRect(156, 4)

        UiTranslate(0, -2)
        UiColor(0.18, 0.18, 0.18, 0.9)
        UiRect(150, 1)
    UiPop()
    
    UiPop()
end

dropdownMenu.MenuDrawVisuals = function(canInteract) 
    UiPush()
        if dropdownMenu.DrawHeader(visualsDropdown, canInteract) then 

            if dropdownMenu.DrawFeature(fWatermark, canInteract) then 
                dropdownMenu.ColorSelect(fWatermark, canInteract)
            end

            if dropdownMenu.DrawFeature(fFeatureList, canInteract) then 
                dropdownMenu.ColorSelect(fFeatureList, canInteract)
            end
            if dropdownMenu.DrawFeature(fObjectiveEsp, canInteract) then 
                dropdownMenu.ColorSelect(fObjectiveEsp, canInteract)

                -- optional esp checkbox
                dropdownMenu.ColorSelect(fOptionalEsp, canInteract)
            end
            if dropdownMenu.DrawFeature(fValuableEsp, canInteract) then 
                dropdownMenu.ColorSelect(fValuableEsp, canInteract)
            end
            if dropdownMenu.DrawFeature(fToolEsp, canInteract) then 
                dropdownMenu.ColorSelect(fToolEsp, canInteract)
            end
            if dropdownMenu.DrawFeature(fWeaponGlow, canInteract) then 
                dropdownMenu.ColorSelect(fWeaponGlow, canInteract)
            end
            if dropdownMenu.DrawFeature(fActiveGlow, canInteract) then 
                dropdownMenu.ColorSelect(fActiveGlow, canInteract)
            end
            if dropdownMenu.DrawFeature(fRainbowFog, canInteract) then 
                dropdownMenu.ColorSelect(fRainbowFog, canInteract)
            end
            if dropdownMenu.DrawFeature(fPostProcess, canInteract) then 
                dropdownMenu.ColorSelect(fPostProcess, canInteract)
            end
            if dropdownMenu.DrawFeature(fSpinnyTool, canInteract) then 
                dropdownMenu.ColorSelect(fSpinnyTool, canInteract)
            end

        dropdownMenu.DrawBottomGradient()
        end
    UiPop()
end

dropdownMenu.MenuDrawPlayer = function(canInteract)
    UiPush()
        if dropdownMenu.DrawHeader(playerDropdown, canInteract) then 

            if dropdownMenu.DrawFeature(fSpeed, canInteract) then
                -- slider fSubSpeed 10 30
                -- slider fSubBoost 10 40
            end
            
            if dropdownMenu.DrawFeature(fSpider, canInteract) then 
            end
            
            if dropdownMenu.DrawFeature(fFly, canInteract) then 
                -- slider fSubSpeed 10 30
                -- slider fSubBoost 10 40
            end
            if dropdownMenu.DrawFeature(fNoclip, canInteract) then 
                -- slider fSubSpeed 1 5
                -- slider fSubBoost 1 20
            end
            if dropdownMenu.DrawFeature(fFloorStrafe, canInteract) then end
            if dropdownMenu.DrawFeature(fJetpack, canInteract) then end
            if dropdownMenu.DrawFeature(fJesus, canInteract) then end
            if dropdownMenu.DrawFeature(fQuickstop, canInteract) then end
            if dropdownMenu.DrawFeature(fInfiniteAmmo, canInteract) then end
            if dropdownMenu.DrawFeature(fSuperStrength, canInteract) then end
            if dropdownMenu.DrawFeature(fGodmode, canInteract) then end

        dropdownMenu.DrawBottomGradient()
        end
    UiPop()
end

dropdownMenu.MenuDrawWorld = function(canInteract) 
    UiPush()
        if dropdownMenu.DrawHeader(worldDropdown, canInteract) then 

            if dropdownMenu.DrawFeature(fBulletTime, canInteract) then 
                -- slider fBulletTimeScale 10 100
                -- checkbox fBulletTimePatch
            end
            if dropdownMenu.DrawFeature(fSkipObjective, canInteract) then end
            if dropdownMenu.DrawFeature(fDisableAlarm, canInteract) then end
            if dropdownMenu.DrawFeature(fDisableRobots, canInteract) then end
            if dropdownMenu.DrawFeature(fDisablePhysics, canInteract) then end
            if dropdownMenu.DrawFeature(fForceUpdatePhysics, canInteract) then end
            if dropdownMenu.DrawFeature(fTeleportValuables, canInteract) then end
            if dropdownMenu.DrawFeature(fUnfairValuables, canInteract) then end

        dropdownMenu.DrawBottomGradient()
        end
    UiPop()
end

dropdownMenu.MenuDrawTools = function(canInteract) 
    UiPush()
        if dropdownMenu.DrawHeader(toolsDropdown, canInteract) then 

            if dropdownMenu.DrawFeature(fStructureRestorer, canInteract) then end
            if dropdownMenu.DrawFeature(fRubberband, canInteract) then end
            if dropdownMenu.DrawFeature(fTeleport, canInteract) then end
            if dropdownMenu.DrawFeature(fExplosionBrush, canInteract) then
                -- fExplosionBrushSize 0.5 4
            end
            if dropdownMenu.DrawFeature(fFireBrush, canInteract) then end

        dropdownMenu.DrawBottomGradient()
        end
    UiPop()
end

dropdownMenu.MenuDrawMisc = function(canInteract) 
    UiPush()
        if dropdownMenu.DrawHeader(miscDropdown, canInteract) then 

        if dropdownMenu.BaseButton("Finish", canInteract) then
            SetString("level.state", "win") 
        end

        if dropdownMenu.BaseButton("Reset", canInteract) then 
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

        if dropdownMenu.BaseButton("Registry", canInteract) then
            openMenu = "registry"
        end

        -- select from list
        if dropdownMenu.BaseButton("Legacy", canInteract) then
            config.SetInt(fMenuStyle, 0)
        end 

        dropdownMenu.DrawBottomGradient()
        end
    UiPop()
end
