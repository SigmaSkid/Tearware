
function DrawDropdownMenu()
    MenuDrawPlayer()
    MenuDrawWorld()
    MenuDrawVisuals()
    MenuDrawTools()
    MenuDrawMisc()
end

-- player, world, visuals, tools, misc
function DrawHeader(name)
    UiPush()
        UiPush()

            UiColor(0.23, 0.23, 0.23, 1)
            UiRect(110, 60)

            -- uicolor
            -- font
            -- align
            -- uitext name
        UiPop()
    UiPop()
end

-- speedhack etc.
function DrawFeature(var)
    UiPush()
        -- draw background of it
        UiPush()
            -- noooooooooooooooooooooooooo
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
        DrawHeader("Player")

        local offset = 0

        if DrawFeature( - feature var - ) then 
            -- somehow draw the background and then update the offset
            -- should probably just hardcode it
            -- draw hotkey
            -- draw slider if applicable
            -- draw combo box if applicable
        end
        
        -- UiTranslate(offset, 0)
        -- repeat DrawFeature for all player features


    UiPop()
end

