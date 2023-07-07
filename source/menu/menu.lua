#include "legacymenu.lua"
#include "dropdownmenu.lua"

menu.RGBBlur = function(rgb)
    -- funny rgb blur background
    UiPush()
        UiAlign("center middle")

        UiColor(rgb.R, rgb.G, rgb.B, 0.0420)
        
        UiTranslate(UiCenter(), UiMiddle())
        UiRect(UiWidth(), UiHeight())
        
        UiBlur(0.3)
    UiPop()
end

menu.DrawMenu = function()
    local rgb = utils.seedToRGB(GetTime())
    menu.RGBBlur(rgb)
    
    local menuStyle = config.GetInt(fMenuStyle)

    if menuStyle == 1 then
        dropdownMenu.DrawDropdownMenu(rgb)
    else
       legacyMenu.DrawLegacyMenu(rgb)
    end
end