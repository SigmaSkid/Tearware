-- tearware on top

#include "menu/resetconfirm.lua" -- DrawResetConfigConfirmation
#include "menu/menu.lua" -- DrawMenu
#include "menu/registry.lua" -- DrawRegistry
#include "features/visuals/visuals.lua" -- DrawVisuals
#include "editor/editor.lua" -- DrawEditor

menu.UiDraw = function(dt)
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
            menu.DrawMenu()
        elseif openMenu == "registry" then
            registry.DrawRegistry()
        elseif openMenu == "reset" then
            menu.DrawResetConfigConfirmation(dt)
        elseif openMenu == "editor" then
            editor.DrawEditor()
        end
    UiPop()
end

-- called on each draw, dt isn't documented :D
function draw(dt)
    visuals.DrawVisuals()
    menu.UiDraw(dt)
end