#include "legacymenu.lua"

menu_RGBBlur = function(rgb)
    -- funny rgb blur background
    UiPush()
        UiAlign("center middle")

        UiColor(rgb.R, rgb.G, rgb.B, 0.0420)
        
        UiTranslate(UiCenter(), UiMiddle())
        UiRect(UiWidth(), UiHeight())
        
        UiBlur(0.3)
    UiPop()
end

menu_DrawMenu = function()
    local rgb = utils_seedToRGB(GetTime())
    menu_RGBBlur(rgb)

    legacyMenu_DrawLegacyMenu(rgb)
end