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
playerDropdown.size.x = 200
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
worldDropdown.size.x = 200
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
visualsDropdown.size.x = 200
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
toolsDropdown.size.x = 200
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
miscDropdown.size.x = 200
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
-- Make it so you can't interact with obscured objects!
--
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

function DrawDropdownMenu()
    if not InputDown('lmb') then 
        tileWeAreChangingPosOf = 'none'
    end

    shouldUpdateOrder = false

    -- Iterate over the table and call each function
    -- do it in the opposite direction, cuz first element is on top, last on bottom
    for i = #drawOrder, 1, -1 do
        local entry = drawOrder[i]
        _G[entry.func]()
        --DebugWatch(entry.name, entry.queue)
    end

    -- just update the array.
    UpdateDrawOrder()
end

-- player, world, visuals, tools, misc
function DrawHeader(item)
    UiPush()
        UiTranslate(item.position.x, item.position.y)
        UiWindow(150, 50)

        UiPush()
                
            local x, y = UiGetMousePos()

            if UiIsMouseInRect(150, 50) and InputPressed("lmb") 
            and tileWeAreChangingPosOf ~= item.name then
                tileWeAreChangingPosOf = item.name
                offsetsOffset.x = x
                offsetsOffset.y = y

                -- move this window to the top.
                if item.queue ~= 1 then 
                    shouldUpdateOrder = true
                    local oldpos = item.queue 
                    item.queue = 1
                    
                    for i=1, oldpos-1 do
                        drawOrder[i].queue = drawOrder[i].queue + 1
                    end
                end
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
            
            if UiIsMouseInRect(20, 20) and InputPressed('lmb') then 
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
function DrawFeature(var)
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

function MenuDrawPlayer()
    UiPush()
        if DrawHeader(playerDropdown) then 

        local offset = 0

        if DrawFeature(var) then 
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

function MenuDrawWorld() 
    UiPush()
        if DrawHeader(worldDropdown) then 

        local offset = 0

        if DrawFeature(var) then 
        end
        UiPop()
        end
    UiPop()
end

function MenuDrawVisuals() 
    UiPush()
        if DrawHeader(visualsDropdown) then 

        local offset = 0

        if DrawFeature(var) then 
        end
        UiPop()
        end
    UiPop()
end

function MenuDrawTools() 
    UiPush()
        if DrawHeader(toolsDropdown) then 

        local offset = 0

        if DrawFeature(var) then 
        end
        UiPop()
        end
    UiPop()
end

function MenuDrawMisc() 
    UiPush()
        if DrawHeader(miscDropdown) then 

        local offset = 0

        if DrawFeature(var) then 
        end
        UiPop()
        end
    UiPop()
end
