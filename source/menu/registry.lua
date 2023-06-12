-- tearware on top
-- TODO:
-- fix text formatting/overlap when a key or value is long or contains \n
-- -right click opens a popup menu
-- popup menu:
--  ~ key (copy, paste, delete)
--  ~ value (copy, paste, delete)
--      -- should they have the same or separate copy/paste buffer? no clue, prolly separate.
--  ~ insert (menu of special characters that can't be inputted normally |\?/~` etc.)
--  ~ new - create a new key and assign value
--

registry = {}

registry.ListChildren = function(var)

    local Children = ListKeys(var)
    for i=1, #Children do
        local me = var .. "." .. Children[i]

        local d = GetString(me)
        if d == "" then 
            d = "nil"
        end
        
        local object = {}
        -- +1 so it starts at 1, like all lua bs
        object.id = #registryCache+1
        object.name = me 
        object.value = d
        object.writeAccess = utils.DirtyWriteAccessCheck(me)

        registryCache[#registryCache+1] = object
        registry.ListChildren(me)
    end
end

registry.CreateRegistry = function()
    if #registryCache > 1 then 
        return
    end

    for i=1, #registryEntryPoints do
        registry.ListChildren(registryEntryPoints[i])
    end

    registryVisibleCache = registryCache
    registrySearchString = ""
end

registry.DisplayOrEditKey = function(thisObject, id, offsetAfterInt)
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

        if UiIsMouseInRect(UiWidth()-10, 26) then
            if InputPressed("rmb") then
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
            registrySelectedKey.value, __, inputStringCursorPos = utils.ModifyString(registrySelectedKey.value, inputStringCursorPos)
            UiText(registrySelectedKey.value)
            utils.DrawInputStringCursor(registrySelectedKey.value, inputStringCursorPos)
        
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

registry.UpdateSearchVisibility = function()
    if editingRegistrySearchString then
        registrySearchString, modifiedregistrySearchString, inputStringCursorPos = utils.ModifyString(registrySearchString, inputStringCursorPos)
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


-- called on each draw
registry.DrawRegistry = function()
    registry.CreateRegistry()

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

    registry.UpdateSearchVisibility()
    
    local name = InputLastPressedKey()

    if name ~= "" and name ~= nil then lastRegistryInput = name end

    registryScrollPos = utils.Clamp(registryScrollPos - (InputValue("mousewheel")*scrollspeed), 1, #registryVisibleCache - VisibleEntries)

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
                displayText =  "Last Input: " .. lastRegistryInput 
                UiTranslate(displayOffsetX, -displayOffsetY + 28)
                UiText(displayText)
            UiPop()

            UiPush()
                UiTranslate(displayOffsetX + 240, -displayOffsetY + 28)
                if InputPressed("f5") or UiTextButton("Refresh") then
                    registryCache = {}
                    registry.CreateRegistry()
                end
                UiTranslate(120, 0)
                if UiTextButton("Search: " .. registrySearchString) then 
                    editingRegistrySearchString = true
                    registrySelectedKey.key = "nil"
                end
                if editingRegistrySearchString then 
                    UiPush()
                        local searchx, __ = UiGetTextSize("Search: ")
                        UiTranslate(searchx-2, 0)
                        utils.DrawInputStringCursor(registrySearchString, inputStringCursorPos)
                    UiPop()
                end
            UiPop()

            UiPush()
                local offsetAfterInt, h = UiGetTextSize(registryCache[#registryCache].id .. "n")

                for i=math.floor(registryScrollPos), registryScrollPos + VisibleEntries do
                    local thisObject = registryVisibleCache[i]
                    if thisObject then
                        registry.DisplayOrEditKey(thisObject, i, offsetAfterInt)
                    end
                end
            UiPop()

            UiPush()
                UiColor(0.7, 0.7, 0.7, 0.7)
                UiTranslate(offsetAfterInt - 5, 25)
                UiRect(1, UiHeight())
                UiTranslate(UiMiddle()*1.5, 0)
                UiRect(1, UiHeight())
            UiPop()
        UiPop()

        -- scroll bar yey
        UiPush()
            UiTranslate(UiWidth()-5, 0)
            UiColor(0.6, 0.6, 0.6, 1)
            UiRect(5, UiHeight())

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

                            registryScrollPos = utils.Clamp( (y*#registryVisibleCache / UiHeight()) - VisibleEntries/2, 1, #registryVisibleCache - VisibleEntries)
                            --DebugPrint(y .. " " .. registryScrollPos)
                        UiPop()
                    end
                elseif InputPressed("mmb") then 
                    isScrollingRegistry = true 
                    local x, y = UiGetMousePos()
                    registryScrollingBaseOffset = 0
                end

                if isScrollingRegistry then 
                    if InputDown("lmb") or InputDown("mmb") then 
                        local x, y = UiGetMousePos()

                        local delta = (y - registryScrollingBaseOffset)

                        if math.abs(delta) > 1 then 
                            registryScrollPos = utils.Clamp(registryScrollPos + delta, 1, #registryVisibleCache - VisibleEntries)
                        end
                    else
                        isScrollingRegistry = false 
                    end
                end

            UiPop()
        UiPop()
    UiPop()


end
