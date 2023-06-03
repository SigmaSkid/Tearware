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

    local menuStyle = GetCfgInt(fMenuStyle) 
    if menuStyle == 1 then
        DrawDropdownMenu(rgb)
    elseif menuStyle == 2 then
        -- DrawModernMenu(rgb)
    else
        DrawLegacyMenu(rgb)
    end
end