-- tearware on top

function ListChildren(var, writeAccess) 

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
        object.writeAccess = writeAccess

        registryCache[#registryCache+1] = object
        ListChildren(me, writeAccess)
    end
end

function CreateRegistry()
    if #registryCache > 1 then 
        return
    end

    for i=1, #registryEntryPoints do
        ListChildren(registryEntryPoints[i][1], registryEntryPoints[i][2])
    end
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
    elseif InputDown("end") then 
        registryScrollPos = #registryCache - VisibleEntries
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
        UiText(fProjectName .. " found " .. #registryCache .. " keys. Game version: " .. gameVersion .. " Last Input: " .. lastRegistryInput, true)
        
        UiAlign("bottom left")
        local offsetAfterInt, h = UiGetTextSize(registryCache[#registryCache].id .. "n")

        for i=registryScrollPos, registryScrollPos + VisibleEntries do 
            local thisObject = registryCache[i]
            UiTranslate(0, 25)
            UiPush()
                if i%2==0 then 
                    UiColor(0.1, 0.1, 0.1, 0.2)
                else 
                    UiColor(0.5, 0.5, 0.5, 0.2)
                end
                UiRect(UiWidth(), 26)
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
                UiText(thisObject.value) 
            UiPop()
        end

    UiPop()
end
