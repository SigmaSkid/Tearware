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

-- speedhack etc.
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

            local w, h = UiGetTextSize(var[1])
            UiTranslate(0, h)
            -- haha, precompiled values? NO! Waste compute reasources! Heck yeah!
            while (w > 100) do 
                fontsize = fontsize - 2
                UiFont("regular.ttf", fontsize)

                -- if local then infinite loop, funny lua things
                w, h = UiGetTextSize(var[1])
            end


            local feature_state = config.AdvGetBool(var)
            if feature_state then 
                UiColor(1,1,1,1)            
            else
                UiColor(0.5,0.5,0.5,1)    
            end

            UiText(var[1])
        UiPop()
  
        -- interaction
        UiPush()
            UiColor(1,1,1,1)    
            if dropdownMenu.InteractRect(100, 40, canInteract) then 
                config.FlipBool(cfgstr .. var[2])
            end
            --UiRect(100, 40)
        UiPop()

        -- V
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
                    config.FlipBool(cfgstr .. var[2] .. "_dropdown")
                end
                --UiRect(20,20)
                local dropdown_state = GetBool(cfgstr .. var[2] .. "_dropdown")

                if dropdown_state then 
                    UiRotate(180)
                end

                UiText("v")
            UiPop()
        end 

    UiPop()

    UiTranslate(0, 40)
    resizeOffset = resizeOffset + 40
    return dropdown_state
end

dropdownMenu.ComboBox = function()
    -- well, doing this will be 'fun'
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

            if dropdownMenu.DrawFeature(fWatermark, canInteract) then end
            if dropdownMenu.DrawFeature(fFeatureList, canInteract) then end
            if dropdownMenu.DrawFeature(fObjectiveEsp, canInteract) then end
            if dropdownMenu.DrawFeature(fOptionalEsp, canInteract) then end
            if dropdownMenu.DrawFeature(fValuableEsp, canInteract) then end
            if dropdownMenu.DrawFeature(fToolEsp, canInteract) then end
            if dropdownMenu.DrawFeature(fWeaponGlow, canInteract) then end
            if dropdownMenu.DrawFeature(fActiveGlow, canInteract) then end
            if dropdownMenu.DrawFeature(fRainbowFog, canInteract) then end
            if dropdownMenu.DrawFeature(fPostProcess, canInteract) then end
            if dropdownMenu.DrawFeature(fSpinnyTool, canInteract) then end

        dropdownMenu.DrawBottomGradient()
        end
    UiPop()
end

dropdownMenu.MenuDrawPlayer = function(canInteract)
    UiPush()
        if dropdownMenu.DrawHeader(playerDropdown, canInteract) then 

            if dropdownMenu.DrawFeature(fSpeed, canInteract) then
            -- draw hotkey
            -- draw slider if applicable
            -- draw combo box if applicable 
            end
            if dropdownMenu.DrawFeature(fFly, canInteract) then end
            if dropdownMenu.DrawFeature(fNoclip, canInteract) then end
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

            if dropdownMenu.DrawFeature(fBulletTime, canInteract) then end
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
            if dropdownMenu.DrawFeature(fExplosionBrush, canInteract) then end
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

        if dropdownMenu.BaseButton("Legacy", canInteract) then
            config.SetInt(fMenuStyle, 0)
        end 

        dropdownMenu.DrawBottomGradient()
        end
    UiPop()
end
