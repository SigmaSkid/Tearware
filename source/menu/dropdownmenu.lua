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

function UpdateDrawOrder()
    if not shouldUpdateOrder then return end

    local newDrawOrder = {}
    for _, entry in ipairs(drawOrder) do
        newDrawOrder[entry.queue] = entry
    end
    drawOrder = newDrawOrder
end

function GetInteractable()
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
                        moveObjectToForeground(object)
                    end

                    output = object.queue 
                end

                UiRect(object.size.x, object.size.y)

            UiPop()
        end
    end

    return output
end

function moveObjectToForeground(object)
    if object.queue ~= 1 then 
        shouldUpdateOrder = true
        local oldpos = object.queue 
        object.queue = 1
        
        for i=1, oldpos-1 do
            drawOrder[i].queue = drawOrder[i].queue + 1
        end
    end
end

function InteractRect(x, z, canInteract)
    if canInteract and 
    InputPressed("lmb") and
    UiIsMouseInRect(x, z) then 
        return true 
    end

    return false
end

function DrawDropdownMenu()
    if not InputDown('lmb') then 
        tileWeAreChangingPosOf = 'none'
    end

    shouldUpdateOrder = false

    -- get which object we can interact with.
    -- also move relevant object to foreground
    local interactTarget = GetInteractable()

    -- just update the array.
    UpdateDrawOrder()

    -- Iterate over the table and call each function
    -- do it in the opposite direction, cuz first element is on top, last on bottom
    for i = #drawOrder, 1, -1 do
        local entry = drawOrder[i]
        
        _G[entry.func](interactTarget == entry.queue)

        --DebugWatch(entry.name, entry.queue)
    end
end

-- player, world, visuals, tools, misc
function DrawHeader(item, canInteract)
    UiPush()
        UiTranslate(item.position.x, item.position.y)

        UiPush()
            local x, y = UiGetMousePos()

            if InteractRect(150, 50, canInteract)
            and tileWeAreChangingPosOf ~= item.name then
                tileWeAreChangingPosOf = item.name
                offsetsOffset.x = x
                offsetsOffset.y = y
            end
            
            if InputDown('lmb') and tileWeAreChangingPosOf == item.name then 
                -- hardcoded for 1080p cuz the game forces scaling from/to that anyway
                item.position.x = Clamp(item.position.x + x - offsetsOffset.x, 0, 1920-150)
                item.position.y = Clamp(item.position.y + y - offsetsOffset.y, 0, 1080-50)
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
            
            if InteractRect(20, 20, canInteract) then 
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
        UiTranslate(0, 49)
    end

    return item.dropdown
end

-- speedhack etc.
function DrawFeature(var, canInteract)
    UiPush()
        -- draw background of it
        UiPush()
            UiTranslate(150/2, 50/2)
            UiAlign("center middle")

            UiColor(0.18, 0.18, 0.18, 0.3)
            UiRect(156, 50)
            
            UiColor(0.18, 0.18, 0.18, 0.9)
            UiRect(150, 50)
        UiPop()

        UiPush()
            -- uicolor (feature_state ? vibrant green : muddy red )
            -- font
            -- align
            -- uitext (var name)
            -- if clicked -> toggle feature
        UiPop()

        -- UiTranslate to align to the right 

        UiPush()
            -- arrow on the right side, for revealing the dropdown
            -- could use registry for this by using feature_name.dropdown_state or something
        UiPop()
    UiPop()

    return --dropdown state--
end

function ComboBox()
    -- well, doing this will be 'fun'
end

function MenuDrawPlayer(canInteract)
    UiPush()
        if DrawHeader(playerDropdown, canInteract) then 

        local offset = 0

        if DrawFeature(var, canInteract) then 
            -- somehow draw the background and then update the offset
            -- should probably just hardcode it
            -- draw hotkey
            -- draw slider if applicable
            -- draw combo box if applicable
        end
        
        -- UiTranslate(0, offset)
        -- repeat DrawFeature for all player features
        
        UiPop()
        end
    UiPop()
end

function MenuDrawWorld(canInteract) 
    UiPush()
        if DrawHeader(worldDropdown, canInteract) then 

        local offset = 0

        if DrawFeature(var, canInteract) then 
        end
        UiPop()
        end
    UiPop()
end

function MenuDrawVisuals(canInteract) 
    UiPush()
        if DrawHeader(visualsDropdown, canInteract) then 

        local offset = 0

        if DrawFeature(var, canInteract) then 
        end
        UiPop()
        end
    UiPop()
end

function MenuDrawTools(canInteract) 
    UiPush()
        if DrawHeader(toolsDropdown, canInteract) then 

        local offset = 0

        if DrawFeature(var, canInteract) then 
        end
        UiPop()
        end
    UiPop()
end

function MenuDrawMisc(canInteract) 
    UiPush()
        if DrawHeader(miscDropdown, canInteract) then 

        local offset = 0

        if DrawFeature(var, canInteract) then 
        end
        UiPop()
        end
    UiPop()
end
