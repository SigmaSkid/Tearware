#include "menu/menu.lua" -- DrawMenu
#include "menu/registry.lua" -- DrawRegistry
#include "menu/resetconfirm.lua" -- DrawResetConfigConfirmation
#include "features/visuals/visuals.lua" -- DrawVisuals


menu_UiDraw = function(dt)
    if openMenu == nil then
        filthyglobal_editingkeybind = " "
        active_sub_menu = nil
        editingRegistrySearchString = false
        registryCache = {}
        registrySelectedKey.key = "nil"

        config_SetVar(SetBool, fInputLock, false)
        inputStringCursorPos = nil
        openMenu = 0
        return
    elseif openMenu == 0 then
        --[[
            we set to nil to reset the values.
            I should probably at some point replace the string comparisons with an enum. 
            But I'm assuming we're comparing string pointers, so it shouldn't be that bad.
        ]]
        return
    end
    
    if not config_GetVar(GetBool, fInputLock) then 
        config_SetVar(SetBool, fInputLock, true)
    end

    UiPush()
        UiMakeInteractive()
        SetBool("game.disablepause", true)

        if InputPressed("pause") then
            openMenu = nil
        end

        if openMenu == "tearware" then
            menu_DrawMenu(dt)
        elseif openMenu == "registry" then
            registry_DrawRegistry()
        elseif openMenu == "reset" then
            menu_DrawResetConfigConfirmation(dt)
        end
    UiPop()
end

-- called on each draw, dt isn't documented :D
function client.draw(dt)
    visuals_DrawVisuals()
    menu_UiDraw(dt)
end