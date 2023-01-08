-- tearware on top

#include "menu.lua"

function Watermark()
    if not AdvGetBool(fWatermark) then 
        return 
    end

    UiPush()
        local color = GetColor(fWatermark, GetTime())
        UiColor(color.red, color.green, color.blue, color.alpha)
        UiTranslate(0, 0)
        UiAlign("left top")
        UiFont("bold.ttf", 25)
        UiTextShadow(0, 0, 0, color.alpha * 0.5, 1.5)
        UiTextOutline(0, 0, 0, color.alpha * 0.7, 0.07)
        UiText(fProjectName)
    UiPop()
end

function FeatureList()
    if not AdvGetBool(fFeatureList) then 
        return 
    end

    local visibleFeatures = 0.05

    UiPush()
        UiTranslate(0, 0)
        UiAlign("top left")

        if AdvGetBool(fWatermark) then 
            UiTranslate(0, 25)
        end

        local color = GetColor(fFeatureList, GetTime())

        UiFont("bold.ttf", 12)
        UiTextShadow(0, 0, 0, color.alpha * 0.2, 1.5)
        UiTextOutline(0, 0, 0, color.alpha * 0.7, 0.07)

        for i=1, #featurelist do
            if GetBool(cfgstr .. featurelist[i][2]) then 
                visibleFeatures = visibleFeatures + 0.05
                local color = GetColor(fFeatureList, GetTime() + visibleFeatures)
                UiColor(color.red, color.green, color.blue, color.alpha)

                UiText(featurelist[i][1], true)
            end
        end

    UiPop()
end

function WeaponGlow() 
    if not AdvGetBool(fWeaponGlow) then 
        return 
    end

    local toolBody = GetToolBody()
    if toolBody~=0 then
        local color = GetColor(fWeaponGlow, GetTime())
        DrawBodyOutline(toolBody, color.red, color.green, color.blue, color.alpha)
    end
end

function ActiveGlow() 
    if not AdvGetBool(fActiveGlow) then 
        return 
    end
    local bodies = FindBodies(nil,true)
    local color = GetColor(fActiveGlow, GetTime())

	for i=1,#bodies do
		local body = bodies[i]
		if IsBodyActive(body) then
            if i % 10 == 0 then 
                color = GetColor(fActiveGlow, GetTime() + i)
            end 
            DrawBodyOutline(body, color.red, color.green, color.blue, color.alpha)
        end
    end
end

function ObjectiveEsp() 
    if not AdvGetBool(fObjectiveEsp) then 
        return 
    end

    local drawOptional = AdvGetBool(fOptionalEsp)
    local objectiveColor = GetColor(fObjectiveEsp, GetTime())
    local optionalColor = GetColor(fOptionalEsp, GetTime())

    local targets = FindBodies("target", true)
	for i=1,#targets do
        local body = targets[i]
		if GetTagValue(body, "target") ~= "cleared" and GetTagValue(body, "target") ~= "disabled" then
			local targetpos = GetBodyCenter(body)
            local optional = HasTag(body, "optional")
            local x, y, dist = UiWorldToPixel(targetpos)
            if dist > 1 then
                UiPush()
                    UiFont("bold.ttf", 16)
                    UiAlign("center middle")
                    UiTranslate(x, y)
                    if optional then 
                        if drawOptional then 
                            UiTextShadow(0, 0, 0, optionalColor.alpha * 0.7, 1.5)
                            UiTextOutline(0, 0, 0, optionalColor.alpha, 0.1)
                            UiColor(optionalColor.red, optionalColor.green, optionalColor.blue, optionalColor.alpha)
                            UiText("Optional", true)
                            UiText(math.floor(dist) .. "m")
                        end
                    else 
                        UiTextShadow(0, 0, 0, objectiveColor.alpha * 0.7, 1.5)
                        UiTextOutline(0, 0, 0, objectiveColor.alpha, 0.1)
                        UiColor(objectiveColor.red, objectiveColor.green, objectiveColor.blue, objectiveColor.alpha)
                        UiText("Target", true)
                        UiText(math.floor(dist) .. "m")
                    end
                UiPop() 
            end

            if optional then 
                if drawOptional then 
                    DrawBodyOutline(body, optionalColor.red, optionalColor.green, optionalColor.blue, optionalColor.alpha)
                end
            else 
                DrawBodyOutline(body, objectiveColor.red, objectiveColor.green, objectiveColor.blue, objectiveColor.alpha)
            end
        end
	end
end

function ValueableEsp() 
    if not AdvGetBool(fValuableEsp) then 
        return 
    end
    local color = GetColor(fValuableEsp)

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
                    UiTextShadow(0, 0, 0, color.alpha * 0.7, 1.5)
                    UiTextOutline(0, 0, 0, color.alpha, 0.1)
                    UiTranslate(x, y)
                    UiColor(color.red, color.green, color.blue, color.alpha)
                    -- UiText(GetDescription(body), true)
                    UiText("$" .. math.floor(value), true)
                    UiText(math.floor(dist) .. "m")
                UiPop() 
            end
            DrawBodyOutline(body, color.red, color.green, color.blue, color.alpha)
        end
    end
end

function ToolEsp() 
    if not AdvGetBool(fToolEsp) then 
        return 
    end

    local color = GetColor(fToolEsp)

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
                        UiTextShadow(0, 0, 0, color.alpha * 0.7, 1.5)
                        UiTextOutline(0, 0, 0, color.alpha, 0.1)
                        UiTranslate(x, y)
                        UiColor(color.red, color.green, color.blue, color.alpha)
                        UiText(GetDescription(body), true)
                        UiText(math.floor(dist) .. "m")
                    UiPop() 
                end
                DrawBodyOutline(body, color.red, color.green, color.blue, color.alpha)
            end
        end
    end
end

function VisualsDraw()
    if not AdvGetBool(fVisuals) then 
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
        active_sub_menu = nil
        return
    end

    UiMakeInteractive()
    SetBool("game.disablepause", true)
    if InputPressed("pause") then
        isMenuOpen = false
    end

    DrawMenu()
end