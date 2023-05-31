#include "legacymenu.lua"
#include "dropdownmenu.lua"
--#include "modernmenu.lua"

function RGBBlur(rgb)
    -- funny rgb blur background
    UiPush()
        UiAlign("center middle")

        UiColor(rgb.R, rgb.G, rgb.B, 0.0420)
        
        UiTranslate(UiCenter(), UiMiddle())
        UiRect(UiWidth(), UiHeight())
        
        UiBlur(0.3)
    UiPop()
end

function DrawMenu()
    local rgb = seedToRGB(GetTime())
    RGBBlur(rgb)

    -- switch(menu_style)
    -- case legacy:
        DrawLegacyMenu(rgb)
    -- case modern: 
        -- DrawModernMenu(rgb)
    -- case draggable dropdowns:
        -- DrawDropdownMenu(rgb)
end