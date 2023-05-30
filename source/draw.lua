-- tearware on top

#include "menu/menu.lua" -- DrawResetConfigConfirmation and DrawMenu
#include "menu/registry.lua" -- DrawRegistry
#include "features/visuals/visuals.lua" -- DrawVisuals

function UiDraw(dt)
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
            DrawMenu()
        elseif openMenu == "registry" then
            DrawRegistry()
        elseif openMenu == "reset" then
            DrawResetConfigConfirmation(dt)
        end
    UiPop()
end

-- called on each draw, dt isn't documented :D
function draw(dt)
    DrawVisuals()
    UiDraw(dt)
end