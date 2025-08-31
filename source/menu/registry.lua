-- TODO (probably never):
-- fix text formatting/overlap when a key or value is long or contains \n
-- -right click opens a popup menu
-- popup menu:
--  ~ key (copy, paste, delete)
--  ~ value (copy, paste, delete)
--      -- should they have the same or separate copy/paste buffer? no clue, prolly separate.
--  ~ insert (menu of special characters that can't be inputted normally |\?/~` etc.)
--  ~ new - create a new key and assign value

registryPopUp = {}
registryPopUp.targetObject = nil
registryPopUp.location = {}
registryPopUp.location.x = nil
registryPopUp.location.y = nil
registryPopUp.copyCache = nil
registryPopUp.buttons = 2

registry_ListChildren = function(var)

    local Children = ListKeys(var)
    for i=1, #Children do
        local me = var .. "." .. Children[i]

        local d = GetString(me)
        if d == "" then 
            d = "nil"
        end
        
        local object = {}
        
        object.id = #registryCache+1
        object.name = me 
        object.value = d
        object.writeAccess = utils_DirtyWriteAccessCheck(me)

        registryCache[#registryCache+1] = object
        registry_ListChildren(me)
    end
end

registry_CreateRegistry = function()
    if #registryCache > 1 then 
        return
    end

    for i=1, #registryEntryPoints do
        registry_ListChildren(registryEntryPoints[i])
    end

    registryVisibleCache = registryCache
    registrySearchString = ""
end

registry_DisplayOrEditKey = function(thisObject, id, offsetAfterInt)
    UiTranslate(0, 25)
    UiPush()
        if registrySelectedKey.key == thisObject.id then
            UiColor(0.3, 0.7, 0.3, 0.4)
        else
            if id%2==0 then
                UiColor(0.1, 0.1, 0.1, 0.2)
            else
                UiColor(0.5, 0.5, 0.5, 0.2)
            end
        end
        UiRect(UiWidth(), 26)

        if registryPopUp.targetObject == nil then 
            if UiIsMouseInRect(UiWidth()-10, 26) then
                if InputPressed("lmb") then
                    if thisObject.writeAccess then
                        if registrySelectedKey.key == thisObject.id then
                            registrySelectedKey.key = "nil"
                        else
                            registrySelectedKey.key = thisObject.id
                            registrySelectedKey.value = thisObject.value
                        end
                    else
                        registrySelectedKey.key = "nil"
                    end
                    editingRegistrySearchString = false
                    inputStringCursorPos = nil
                end

                if InputPressed("rmb") then 
                    registryPopUp.targetObject = thisObject
                    registrySelectedKey.key = "nil"
                end
            end
        end
    UiPop()

    UiPush()
        if thisObject.writeAccess then
            UiColor(0.6, 1.0, 0.6, 1)
        else
            UiColor(1.0, 0.6, 0.6, 1)
        end

        UiText(thisObject.id)

        UiTranslate(offsetAfterInt, 0)
        UiText(thisObject.name)

        UiTranslate(UiMiddle()*1.5, 0)
        if registrySelectedKey.key == thisObject.id then
            registrySelectedKey.value, __, inputStringCursorPos = utils_ModifyString(registrySelectedKey.value, inputStringCursorPos)
            UiText(registrySelectedKey.value)
            utils_DrawInputStringCursor(registrySelectedKey.value, inputStringCursorPos)
        
            if InputDown("return") and thisObject.writeAccess then
                SetString(thisObject.name, registrySelectedKey.value)
                thisObject.value = registrySelectedKey.value
                registryCache[id].value = registrySelectedKey.value
                registrySelectedKey.key = "nil"
            end
        else
            UiText(thisObject.value)
        end

    UiPop()
end

registry_UpdateSearchVisibility = function()
    if editingRegistrySearchString then
        registrySearchString, modifiedregistrySearchString, inputStringCursorPos = utils_ModifyString(registrySearchString, inputStringCursorPos)
    end

    if #registryCache == 0 then
        return
    end

    if not modifiedregistrySearchString then
        return
    end

    registryVisibleCache = {}

    for i=1, #registryCache do
        local this = registryCache[i]

        if #registrySearchString == 0 then
            registryVisibleCache[#registryVisibleCache + 1] = this
            -- dots "." are used as placeholders for any character
            -- so you can search for "something" with a search query like s...th..g
        elseif string.find(this.name, registrySearchString) ~= nil then
            registryVisibleCache[#registryVisibleCache + 1] = this
        end
    end
end 

registry_DrawPopUp = function()

    local pressedR = InputPressed("rmb")
    local pressedL = InputPressed("lmb")

    if registryPopUp.targetObject == nil then 
        registryPopUp.location.x = nil
        registryPopUp.location.y = nil
    end

    local justAppeared = registryPopUp.location.x == nil or registryPopUp.location.y == nil

    UiPush()
        local x, y = UiGetMousePos()
        UiTranslate(0, 25)
        local in_rect = UiIsMouseInRect(1915,1055)

        -- just log location of the right click to get a nice popup location.
        if justAppeared and in_rect and pressedR then 
            registryPopUp.location.x = x
            registryPopUp.location.y = y
        end
    UiPop()

    if registryPopUp.targetObject ~= nil then   
        UiPush()
            UiTranslate(registryPopUp.location.x, registryPopUp.location.y)

            local popupW = 75
            local popupH = 25 * registryPopUp.buttons

            if registryPopUp.location.x + popupW >= 1914 then 
                local offset = 1914 - (registryPopUp.location.x + popupW)
                UiTranslate(offset, 0)
            end

            if registryPopUp.location.y + popupH >= 1080 then 
                local offset = 1080 - (registryPopUp.location.y + popupH)
                UiTranslate(0, offset)
            end

            local in_rect = UiIsMouseInRect(popupW, popupH)

            -- if clicked outside of the popup, close it.
            if not justAppeared and not in_rect and (pressedL or pressedR) then 
                registryPopUp.targetObject = nil
                UiPop()
                return
            end

            registryPopUp.buttons = 0

            -- draw background
            UiPush()
                UiColor(0.3,0.3,0.3,1)
                UiTranslate(-1, -1)
                UiRect(popupW + 2, popupH + 2)

                UiColor(0.5,0.5,0.5,1)
                UiTranslate(1, 1)
                UiRect(popupW, popupH)

            UiPop()


            UiPush()
                if UiIsMouseInRect(popupW, 24) then 
                    if pressedL then 
                        registryPopUp.copyCache =  registryPopUp.targetObject.value
                        UiColor(0.3, 0.3, 0.3, 0.7)
                    else 
                        UiColor(0.7, 0.7, 0.7, 0.8)
                    end
                else
                    UiColor(0.6, 0.6, 0.6, 0.9)
                end
                UiRect(popupW, 24)
                UiText("copy")
                registryPopUp.buttons = registryPopUp.buttons + 1
            UiPop()


            if registryPopUp.targetObject.writeAccess then 

                if registryPopUp.copyCache ~= nil then 
                    UiTranslate(0, 24)
                    UiColor(0,0,0,1)
                    UiRect(popupW, 1)
                    UiTranslate(0, 1)

                    UiPush()
                        if UiIsMouseInRect(popupW, 24) then 
                            if pressedL then 
                                SetString(registryPopUp.targetObject.name, registryPopUp.copyCache)
                                registryPopUp.targetObject.value = registryPopUp.copyCache
                                UiColor(0.3, 0.3, 0.3, 0.7)
                            else 
                                UiColor(0.7, 0.7, 0.7, 0.8)
                            end
                        else
                            UiColor(0.6, 0.6, 0.6, 0.9)
                        end

                        UiRect(popupW, 24)
                        UiText("paste")
                        registryPopUp.buttons = registryPopUp.buttons + 1
                    UiPop()
                end

                UiTranslate(0, 24)
                UiColor(0,0,0,1)
                UiRect(popupW, 1)
                UiTranslate(0, 1)

                UiPush()
                    if UiIsMouseInRect(popupW, 24) then 
                        if pressedL then 
                            ClearKey(registryPopUp.targetObject.name)
                            registryCache = {}
                            registryVisibleCache = {}
                            registryPopUp.targetObject = nil
                            
                            UiColor(0.3, 0.3, 0.3, 0.7)
                        else 
                            UiColor(0.7, 0.7, 0.7, 0.8)
                        end
                    else
                        UiColor(0.6, 0.6, 0.6, 0.9)
                    end
                    UiRect(popupW, 24)
                    UiText("delete")
                    registryPopUp.buttons = registryPopUp.buttons + 1
                UiPop()

                -- UiTranslate(0, 24)
                -- UiColor(0,0,0,1)
                -- UiRect(popupW, 1)
                -- UiTranslate(0, 1)

                --UiPush()
                --    if UiIsMouseInRect(popupW, 25) and pressedL then 
                --        -- open menu = stirng editor
                --        -- stringeditor.editedstring = targetobject.value
                --    end
                --    UiColor(0, 0, 1, 0.6)
                --    UiRect(popupW, 25)
                --    UiText("open") -- open in the funny text editor that's still not existent.
                --    registryPopUp.buttons = registryPopUp.buttons + 1
                --UiPop()

            end
        UiPop()
    end
    
end

-- called on each draw
registry_DrawRegistry = function()
    registry_CreateRegistry()

    local VisibleEntries = 41
    local scrollspeed = 1 
    
    if InputDown("shift") then 
        scrollspeed = 10
    elseif InputDown("home") then 
        registryScrollPos = 0
        registrySelectedKey.key = "nil"
        editingRegistrySearchString = false
        inputStringCursorPos = nil
    elseif InputDown("end") then 
        registryScrollPos = #registryCache - VisibleEntries
        registrySelectedKey.key = "nil"
        editingRegistrySearchString = false
        inputStringCursorPos = nil
    elseif InputDown("return") then
        editingRegistrySearchString = false
        inputStringCursorPos = nil
    end

    registry_UpdateSearchVisibility()
    
    local name = InputLastPressedKey()

    if name ~= "" and name ~= nil then lastRegistryInput = name end

    registryScrollPos = utils_Clamp(registryScrollPos - (InputValue("mousewheel")*scrollspeed), 1, #registryVisibleCache - VisibleEntries)

    UiMakeInteractive()

    UiPush()
        UiColor(0.3, 0.3, 0.3, 0.8)
        UiRect(UiWidth(), UiHeight())
    UiPop()

    UiPush()
        UiFont("bold.ttf", 25)
        UiAlign("top left")
        UiColor(1.0, 1.0, 1.0, 1)
        UiTextShadow(0, 0, 0, 0.5, 1.5)
        UiTextOutline(0, 0, 0, 0.7, 0.07)

        UiPush()
            local displayText = fProjectName .. " found " .. #registryCache .. " keys. Game version: " .. gameVersion
            UiText(displayText)
            
            UiPush()
                local displayOffsetX, displayOffsetY = UiGetTextSize(displayText)
                displayText =  " Last Input: " .. lastRegistryInput 
                UiTranslate(displayOffsetX, -displayOffsetY + 28)
                UiText(displayText)
            UiPop()

            -- handle search
            UiPush()
                UiTranslate(displayOffsetX + 240, -displayOffsetY + 28)
                if InputPressed("f5") or UiTextButton("Refresh") then
                    registryCache = {}
                end
                UiTranslate(120, 0)
                if UiTextButton("Search: " .. registrySearchString) then 
                    editingRegistrySearchString = true
                    registrySelectedKey.key = "nil"
                end
                if editingRegistrySearchString then 
                    UiPush()
                        local searchx, __ = UiGetTextSize("Search: ")
                        UiTranslate(searchx+3, 0)
                        utils_DrawInputStringCursor(registrySearchString, inputStringCursorPos)
                    UiPop()
                end
            UiPop()

            -- prevent error spam from refresh
            if #registryCache > 0 then  
                -- draw all the visible keys
                UiPush()
                    local offsetAfterInt, h = UiGetTextSize(registryCache[#registryCache].id .. "n")

                    for i=math.floor(registryScrollPos), registryScrollPos + VisibleEntries do
                        local thisObject = registryVisibleCache[i]
                        if thisObject then
                            registry_DisplayOrEditKey(thisObject, i, offsetAfterInt)
                        end
                    end
                UiPop()

                -- draw the seperators
                UiPush()
                    UiColor(0.7, 0.7, 0.7, 0.7)
                    UiTranslate(offsetAfterInt - 5, 25)
                    UiRect(1, UiHeight())
                    UiTranslate(UiMiddle()*1.5, 0)
                    UiRect(1, UiHeight())
                UiPop()
            end
            -- draw the popup
            registry_DrawPopUp()
        UiPop()

        -- scroll bar yey
        UiPush()
            UiTranslate(UiWidth()-5, 0)
            UiColor(0.6, 0.6, 0.6, 1)
            UiRect(5, UiHeight())
            UiColor(0.1, 0.1, 0.1, 1)
            UiRect(1, UiHeight())

            local clickedOnBar = false
            if UiIsMouseInRect(5, UiHeight()) then
                if InputPressed("lmb") then 
                    clickedOnBar = true
                end
            end
            
            UiPush()
                local scrollPercent = registryScrollPos / #registryVisibleCache
                local scrollOffset = scrollPercent * UiHeight()

                local scrollSizePercent = VisibleEntries / #registryVisibleCache
                local scrollSize = scrollSizePercent * UiHeight()
                
                --DebugWatch(scrollOffset, #registryVisibleCache)

                UiColor(0.9, 0.9, 0.9, 1)
                
                UiTranslate(0, scrollOffset)
                UiRect(5, scrollSize)

                if clickedOnBar then 
                    if UiIsMouseInRect(5, scrollSize) then
                        isScrollingRegistry = true 
                        local x, y = UiGetMousePos()
                        registryScrollingBaseOffset = y
                    else 
                        UiPush()
                            -- UiGetMousePos is relative to current cursor. 
                            -- That's why we need to move our cursor back
                            UiTranslate(0, -scrollOffset)
                            local x, y = UiGetMousePos()

                            registryScrollPos = utils_Clamp( (y*#registryVisibleCache / UiHeight()) - VisibleEntries/2, 1, #registryVisibleCache - VisibleEntries)
                            --DebugPrint(y .. " " .. registryScrollPos)
                        UiPop()
                    end
                elseif InputPressed("mmb") then 
                    isScrollingRegistry = true 
                    local x, y = UiGetMousePos()
                    registryScrollingBaseOffset = scrollSize/2
                end

                if isScrollingRegistry then 
                    if InputDown("lmb") or InputDown("mmb") then 
                        local x, y = UiGetMousePos()

                        local delta = (y - registryScrollingBaseOffset)/2

                        if math.abs(delta) > 1 then 
                            registryScrollPos = utils_Clamp(registryScrollPos + delta, 1, #registryVisibleCache - VisibleEntries)
                        end
                    else
                        isScrollingRegistry = false 
                    end
                end

            UiPop()
        UiPop()
    UiPop()


end
