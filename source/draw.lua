-- tearware on top

#include "menu.lua"

function Watermark()
    if not AdvGetBool(cfgstr .. "watermark") then 
        return 
    end

    UiPush()
        local rgb = seedToRGB(GetTime())
        UiColor(rgb.R, rgb.G, rgb.B, 1)
        UiTranslate(0, 0)
        UiAlign("left top")
        UiFont("bold.ttf", 25)
        UiTextShadow(0, 0, 0, 0.5, 1.5)
        UiTextOutline(0, 0, 0, 0.7, 0.07)
        UiText("Tearware")
    UiPop()
end

function FeatureList()
    if not AdvGetBool(cfgstr .. "featurelist") then 
        return 
    end

    local visibleFeatures = 0.01

    UiPush()
        UiTranslate(0, 0)
        UiAlign("top left")

        if AdvGetBool(cfgstr .. "watermark") then 
            UiTranslate(0, 25)
        end

        UiFont("bold.ttf", 12)
        UiTextShadow(0, 0, 0, 0.2, 1.5)
        UiTextOutline(0, 0, 0, 0.7, 0.07)

        for i=1, #featurelist do
            if GetBool(cfgstr .. featurelist[i].var) then 
                visibleFeatures = visibleFeatures + 0.01
                local rgb = seedToRGB(GetTime() + visibleFeatures)
                UiColor(rgb.R, rgb.G, rgb.B, 1)

                UiText(featurelist[i].name, true)
            end
        end

    UiPop()
end

function WeaponGlow() 
    if not AdvGetBool(cfgstr .. "weaponglow") then 
        return 
    end

    local toolBody = GetToolBody()
    if toolBody~=0 then

        local rgb = seedToRGB(GetTime())
        DrawBodyOutline(toolBody, rgb.R, rgb.G, rgb.B, 1)
    end
end

function ActiveGlow() 
    if not AdvGetBool(cfgstr .. "activeglow") then 
        return 
    end
    local bodies = FindBodies(nil,true)
	for i=1,#bodies do
		local body = bodies[i]
		if IsBodyActive(body) then
            local rgb = seedToRGB(GetTime() + (i / 10))
            
            DrawBodyOutline(body, rgb.R, rgb.G, rgb.B, 1)
        end
    end
end

function ObjectiveEsp() 
    if not AdvGetBool(cfgstr .. "objectiveesp") then 
        return 
    end

    local targets = FindBodies("target", true)
	for i=1,#targets do
        local body = targets[i]
		if GetTagValue(body, "target") ~= "cleared" and GetTagValue(body, "target") ~= "disabled" then
			local targetpos = GetBodyCenter(body)
            local optional = HasTag(body, "optional")
            local x, y, dist = UiWorldToPixel(targetpos)
            if dist > 2 then
                UiPush()
                    UiFont("bold.ttf", 16)
                    UiAlign("center middle")
                    UiTextShadow(0, 0, 0, 0.5, 1.5)
                    UiTextOutline(0, 0, 0, 0.7, 0.1)
                    
                    UiTranslate(x, y)
                    if optional then 
                        UiColor(0.3, 0.3, 0.7, 0.7)
                        UiText("Optional", true)
                    else 
                        UiColor(0.7, 0.3, 0.3, 0.7)
                        UiText("Target", true)
                    end
                    UiText(math.floor(dist) .. "m")
                UiPop() 
            end

            if optional then 
                DrawBodyOutline(body, 0.3, 0.3, 0.7, 0.3)
            else 
                DrawBodyOutline(body, 0.7, 0.3, 0.3, 0.3)
            end
        end
	end
end

function ValueableEsp() 
    if not AdvGetBool(cfgstr .. "valueesp") then 
        return 
    end

    local v = FindBodies("valuable", true)
    for i=1,#v do
        local body = v[i]
        if not IsBodyBroken(body) then 
            local value = GetTagValue(body, "value")
            local targetpos = GetBodyCenter(body)
            local x, y, dist = UiWorldToPixel(targetpos)
            if dist > 2 then 
                 UiPush()
                    UiFont("bold.ttf", 16)
                    UiAlign("center middle")
                    UiTextShadow(0, 0, 0, 0.5, 1.5)
                    UiTextOutline(0, 0, 0, 0.7, 0.1)
                    UiTranslate(x, y)
                    UiColor(0.3, 0.7, 0.3, 0.7)
                    -- UiText(GetDescription(body), true)
                    UiText("$" .. math.floor(value), true)
                    UiText(math.floor(dist) .. "m")
                UiPop() 
            end
            DrawBodyOutline(body, 0.3, 0.7, 0.3, 0.3)
        end
    end
end

function ToolEsp() 
    if not AdvGetBool(cfgstr .. "toolesp") then 
        return 
    end

    local interactables = FindBodies("interact", true)
    for i=1,#interactables do
        local body = interactables[i]
        if not IsBodyBroken(body) then 
            local interactType = GetTagValue(body, "interact")
            local isTool = interactType == "Pick up" 
            
            local targetpos = GetBodyCenter(body)
            local x, y, dist = UiWorldToPixel(targetpos)
            if isTool then 
                if dist > 2 then 
                    UiPush()
                        UiFont("bold.ttf", 16)
                        UiAlign("center middle")
                        UiTextShadow(0, 0, 0, 0.5, 1.5)
                        UiTextOutline(0, 0, 0, 0.7, 0.1)
                        UiTranslate(x, y)
                        UiColor(0.7, 0.7, 0.3, 0.7)
                        UiText(GetDescription(body), true)
                        UiText(math.floor(dist) .. "m")
                    UiPop() 
                end
                DrawBodyOutline(body, 0.7, 0.7, 0.3, 0.3)
            end
        end
    end
end

function VisualsDraw()
    if not AdvGetBool(cfgstr .. "visuals") then 
        return 
    end

    Watermark()
    FeatureList()
    ValueableEsp()
    ObjectiveEsp()
    ToolEsp()
    WeaponGlow()
    ActiveGlow()
end

-- called on each draw
function draw() 

    VisualsDraw()

    if not isMenuOpen then
        filthyglobal_editingkeybind = " "
        return
    end

    UiMakeInteractive()
    SetBool("game.disablepause", true)
    if InputPressed("pause") then
        isMenuOpen = false
    end

    DrawMenu()
end