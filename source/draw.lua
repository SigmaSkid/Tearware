-- tearware on top

#include "menu/resetconfirm.lua" -- DrawResetConfigConfirmation
#include "menu/menu.lua" -- DrawMenu
#include "menu/registry.lua" -- DrawRegistry
#include "features/visuals/visuals.lua" -- DrawVisuals

menu_UiDraw = function(dt)
    if openMenu == nil then
        filthyglobal_editingkeybind = " "
        active_sub_menu = nil
        editingRegistrySearchString = false
        registryCache = {}
        registrySelectedKey.key = "nil"
        lockInputs = false
        inputStringCursorPos = nil
        return
    end
    lockInputs = true

    UiPush()
        UiMakeInteractive()
        SetBool("game.disablepause", true)

        if InputPressed("pause") then
            openMenu = nil
        end

        if openMenu == "tearware" then
            menu_DrawMenu()
        elseif openMenu == "registry" then
            registry_DrawRegistry()
        elseif openMenu == "reset" then
            menu_DrawResetConfigConfirmation(dt)
        end
    UiPop()
end

-- called on each draw, dt isn't documented :D
function draw(dt)
    visuals_DrawVisuals()
    menu_UiDraw(dt)
end