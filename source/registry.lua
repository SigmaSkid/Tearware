-- tearware on top

function ListChildren(var)

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
        object.writeAccess = DirtyWriteAccessCheck(me)

        registryCache[#registryCache+1] = object
        ListChildren(me)
    end
end

function CreateRegistry()
    if #registryCache > 1 then 
        return
    end

    for i=1, #registryEntryPoints do
        ListChildren(registryEntryPoints[i])
    end
end

function DisplayOrEditKey(thisObject, id, offsetAfterInt)
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
            registrySelectedKey.value = ModifyString(registrySelectedKey.value)
            UiText(registrySelectedKey.value)
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

-- called on each draw
function DrawRegistry()
    CreateRegistry()

    local VisibleEntries = 41
    local scrollspeed = 1 
    
    if InputDown("shift") then 
        scrollspeed = 10
    elseif InputDown("home") then 
        registryScrollPos = 0
        registrySelectedKey.key = "nil"
    elseif InputDown("end") then 
        registryScrollPos = #registryCache - VisibleEntries
        registrySelectedKey.key = "nil"
    end
    
    local name = InputLastPressedKey()

    if name ~= "" and name ~= nil then lastRegistryInput = name end

    registryScrollPos = Clamp(registryScrollPos - (InputValue("mousewheel")*scrollspeed), 1, #registryCache - VisibleEntries)

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
            local displayText = fProjectName .. " found " .. #registryCache .. " keys. Game version: " .. gameVersion .. " Last Input: " .. lastRegistryInput 
            UiText(displayText)
            UiPush()
                local displayOffsetX, displayOffsetY = UiGetTextSize(displayText)
                UiTranslate(displayOffsetX, -displayOffsetY +3)
                if UiTextButton("Refresh") or InputPressed("f5") then
                    registryCache = {}
                    CreateRegistry()
                    -- DebugPrint("REFRESHED")
                end
            UiPop()

            UiPush()
                local offsetAfterInt, h = UiGetTextSize(registryCache[#registryCache].id .. "n")

                for i=math.floor(registryScrollPos), registryScrollPos + VisibleEntries do
                    local thisObject = registryCache[i]
                    UiTranslate(0, 25)
                    DisplayOrEditKey(thisObject, i, offsetAfterInt)
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
                local scrollPercent = registryScrollPos / #registryCache 
                local scrollOffset = scrollPercent * UiHeight()
                local scrollSizePercent = VisibleEntries / #registryCache 
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

                            registryScrollPos = Clamp( (y*#registryCache / UiHeight()) - VisibleEntries/2, 1, #registryCache - VisibleEntries)
                            --DebugPrint(y .. " " .. registryScrollPos)
                        UiPop()
                    end
                end

                if isScrollingRegistry then 
                    if InputDown("lmb") then 
                        local x, y = UiGetMousePos()

                        local delta = (y - registryScrollingBaseOffset)

                        if math.abs(delta) > 1 then 
                            registryScrollPos = Clamp(registryScrollPos + delta, 1, #registryCache - VisibleEntries)
                        end
                    else
                        isScrollingRegistry = false 
                    end
                end

            UiPop()
        UiPop()
    UiPop()


end
