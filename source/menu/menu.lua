#include "legacymenu.lua"

menu_RGBBlur = function(rgb, dt)
    -- funny rgb blur background
    UiPush()
        UiAlign("center middle")
        UiColor(rgb.R, rgb.G, rgb.B, 0.0420)
        UiTranslate(UiCenter(), UiMiddle())
        UiRect(UiWidth(), UiHeight())
        UiBlur(0.3)
    UiPop()
    
    -- render some particles using CPU >:)
    UiPush()
        UiAlign("center middle")
        menu_DrawBackgroundParticles(rgb, dt)
    UiPop()
end

-- create the particle buffer
bgDots = {}
for i = 1, 23 do
    bgDots[i] = {
        x = math.random(160, 1760),
        y = math.random(140, 940),
        speedX = (math.random() - 0.5) * 200,
        speedY = (math.random() - 0.5) * 200,
        radius = math.random(40, 100),
        alpha = math.random(20, 80) / 100,
        rotation = math.random(0, 360),
        speedRotation = math.random(10, 100),
        speedRadius = math.random(10, 25)
    }
end

function menu_DrawBackgroundParticles(rgb, dt)
    for i, dot in ipairs(bgDots) do
        dot.x = dot.x + dot.speedX * dt
        dot.y = dot.y + dot.speedY * dt
        
        -- Wrap around screen edges
        if dot.x < -dot.radius then dot.x = 1920 + dot.radius end
        if dot.x > 1920 + dot.radius then dot.x = -dot.radius end
        if dot.y < -dot.radius then dot.y = 1080 + dot.radius end
        if dot.y > 1080 + dot.radius then dot.y = -dot.radius end
        
        dot.rotation = dot.rotation + dot.speedRotation * dt

        -- pulse
        dot.radius = dot.radius + dot.speedRadius * dt
        if dot.radius > 100 then
            dot.speedRadius = -math.abs(dot.speedRadius)
        elseif dot.radius < 40 then 
            dot.speedRadius = math.abs(dot.speedRadius)
        end

        UiPush()
            UiTranslate(dot.x, dot.y)
            UiRotate(dot.rotation)
            UiColor(rgb.R, rgb.G, rgb.B, dot.alpha * 0.25)
            UiRect(dot.radius, dot.radius)
        UiPop()
    end
end

menu_DrawMenu = function(dt)
    local rgb = utils_seedToRGB(GetTime())
    menu_RGBBlur(rgb, dt)

    legacyMenu_DrawLegacyMenu(rgb)
end