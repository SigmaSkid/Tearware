visuals.ObjectiveEsp = function() 
    if not config.AdvGetBool(fObjectiveEsp) then 
        return 
    end

    local drawOptional = config.AdvGetBool(fOptionalEsp)
    local objectiveColor = config.GetColor(fObjectiveEsp, GetTime())
    local optionalColor = config.GetColor(fOptionalEsp, GetTime())

    local targets = FindBodies("target", true)
	for i=1,#targets do
        local body = targets[i]
		if GetTagValue(body, "target") ~= "cleared" and GetTagValue(body, "target") ~= "disabled" then
			local targetpos = utils.GetBodyCenter(body)
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

visuals.ValueableEsp = function() 
    if not config.AdvGetBool(fValuableEsp) then 
        return 
    end
    local color = config.GetColor(fValuableEsp, GetTime())

    local v = FindBodies("valuable", true)
    for i=1,#v do
        local body = v[i]
        if not IsBodyBroken(body) then 
            local value = GetTagValue(body, "value")
            local targetpos = utils.GetBodyCenter(body)
            local x, y, dist = UiWorldToPixel(targetpos)
            if dist > 1 then 
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

visuals.ToolEsp = function() 
    if not config.AdvGetBool(fToolEsp) then 
        return 
    end

    local color = config.GetColor(fToolEsp, GetTime())

    local interactables = FindBodies("interact", true)
    for i=1,#interactables do
        local body = interactables[i]
        if not IsBodyBroken(body) then 
            local interactType = GetTagValue(body, "interact")
            local isTool = interactType == "Pick up" 
            
            local targetpos = utils.GetBodyCenter(body)
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

visuals.DrawEsp = function()
    visuals.ValueableEsp()
    visuals.ObjectiveEsp()
    visuals.ToolEsp()
end