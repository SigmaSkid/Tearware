-- tearware on top

#include "local.lua"

config_DefineBool = function(var, default) 
    featurelist[#featurelist+1] = var

    if HasKey(cfgstr .. var.configString) and HasKey(cfgstr .. var.configString .. "_key") then
        return
    end

    SetBool(cfgstr .. var.configString, default)
    SetString(cfgstr .. var.configString .. "_key", "null")
end

config_DefineInt = function(var, default) 
    if HasKey(cfgstr .. var.configString) then
        return
    end

    SetInt(cfgstr .. var.configString, default)
end

config_GetInt = function(var)
    return GetInt(cfgstr .. var.configString)
end

config_SetInt = function(var, val) 
    SetInt(cfgstr .. var.configString, val)
end

config_DefineColor = function(var, default) 
    for i = 1, #colorSuffix-1 do
        if (not HasKey(cfgstr .. var.configString .. colorSuffix[i])) then
            SetFloat(cfgstr .. var.configString .. colorSuffix[i], default[i])
        end    
        SetFloat(cfgstr .. var.configString .. colorSuffix[i] .. "_default" , default[i])
    end

    if (not HasKey(cfgstr .. var.configString .. colorSuffix[#colorSuffix])) then
        SetBool(cfgstr .. var.configString .. colorSuffix[#colorSuffix], default[#colorSuffix])
    end
    SetBool(cfgstr .. var.configString .. colorSuffix[#colorSuffix] .. "_default" , default[#colorSuffix])
end

config_ResetColorToDefault = function(var)
    local base = var.configString
    for i = 1, #colorSuffix-1 do
        local default_val = GetFloat(cfgstr .. base .. colorSuffix[i] .. "_default")
        SetFloat(cfgstr .. base .. colorSuffix[i], default_val)
    end

    local default_rainbow = GetBool(cfgstr .. base .. colorSuffix[#colorSuffix] .. "_default")
    SetBool(cfgstr .. base .. colorSuffix[#colorSuffix], default_rainbow)
end

-- this could probably be done for all types with 1 funny dynamic function by passing the SetFloat, SetInt etc. to it instead.
-- but whatever, 70 functions > 1 function
config_DefineSubFloat = function(var, sub, default) 
    if HasKey(cfgstr .. var.configString .. sub.configString) then 
        return
    end
    SetFloat(cfgstr .. var.configString .. sub.configString, default)
end

config_GetSubFloat = function(var, sub)
    return GetFloat(cfgstr .. var.configString .. sub.configString)
end

config_SetSubFloat = function(var, sub, value)
    return SetFloat(cfgstr .. var.configString .. sub.configString, value)
end

config_DefineSubInt = function(var, sub, default) 
    if HasKey(cfgstr .. var.configString .. sub.configString) then 
        return
    end
    SetInt(cfgstr .. var.configString .. sub.configString, default)
end

config_GetSubInt = function(var, sub)
    return GetInt(cfgstr .. var.configString .. sub.configString)
end

config_SetSubInt = function(var, sub, val)
    return SetInt(cfgstr .. var.configString .. sub.configString, val)
end

config_DefineSubBool = function(var, sub, default) 
    if HasKey(cfgstr .. var.configString .. sub.configString) then 
        return
    end
    SetBool(cfgstr .. var.configString .. sub.configString, default)
end

config_GetSubBool = function(var, sub)
    return GetBool(cfgstr .. var.configString .. sub.configString)
end

config_SetSubBool = function(var, sub, value)
    return SetBool(cfgstr .. var.configString .. sub.configString, value)
end

config_GetColor = function(var, seed)
    -- nil check, just in case
    seed=seed or GetTime()

    local color = {}
    color.rainbow = GetBool(cfgstr .. var.configString .. colorSuffix[5])
    if color.rainbow then 
        color.red = math.sin(seed + 0) * 0.5 + 0.5;
        color.green = math.sin(seed + 2) * 0.5 + 0.5;
        color.blue = math.sin(seed + 4) * 0.5 + 0.5;
    else
        color.red = GetFloat(cfgstr .. var.configString .. colorSuffix[1])
        color.green = GetFloat(cfgstr .. var.configString .. colorSuffix[2])
        color.blue = GetFloat(cfgstr .. var.configString .. colorSuffix[3])
    end
    color.alpha = GetFloat(cfgstr .. var.configString .. colorSuffix[4])

    return color
end

config_FlipBool = function(var)
    SetBool(var, not GetBool(var))
end

config_SetColor = function(var, color)
    SetBool(cfgstr .. var.configString .. colorSuffix[5], color.rainbow)
    SetFloat(cfgstr .. var.configString .. colorSuffix[4], color.alpha)
    if color.rainbow then 
        return 
    end
    SetFloat(cfgstr .. var.configString .. colorSuffix[1], color.red)
    SetFloat(cfgstr .. var.configString .. colorSuffix[2], color.green)
    SetFloat(cfgstr .. var.configString .. colorSuffix[3], color.blue)
end

config_AdvGetBool = function(var)
    return GetBool(cfgstr .. var.configString)
end

config_UpdateFeatureState = function(var)
    if not HasKey(cfgstr .. var.configString .. "_key") then 
        return GetBool(cfgstr .. var.configString)
    end

    local key = GetString(cfgstr .. var.configString .. "_key")
    if key == "null" or key == "" or key == nil then 
        return GetBool(cfgstr .. var.configString)
    end

    if InputPressed(key) then 
        SetBool(cfgstr .. var.configString, not GetBool(cfgstr .. var.configString))
    end
end

-- has to be done this way, because InputPressed
-- is for some reason unreliable in update function
config_UpdateAllFeatureStates = function()
    if lockInputs then return end

    for i = 1, #featurelist do 
        config_UpdateFeatureState(featurelist[i])
    end
end


config_GenerateConfig = function()
    featurelist = {}

    -- visuals
    config_DefineBool(fWatermark, true)
        config_DefineColor(fWatermark, {1, 1, 1, 1, true} )
        config_DefineSubInt(fWatermark, fAlignmentLR, 0)
        config_DefineSubInt(fWatermark, fFontSize, 22)
        config_DefineSubInt(fWatermark, fFont, 3)
    config_DefineBool(fFeatureList, false)
        config_DefineColor(fFeatureList, {1, 1, 1, 1, true} )
        config_DefineSubInt(fFeatureList, fAlignmentLR, 0)
        config_DefineSubInt(fFeatureList, fFontSize, 14)
        config_DefineSubInt(fFeatureList, fFont, 3)
    config_DefineBool(fObjectiveEsp, false)
        config_DefineColor(fObjectiveEsp, {0.7, 0.3, 0.3, 0.7, false} )
    config_DefineBool(fOptionalEsp, false)
        config_DefineColor(fOptionalEsp, {0.3, 0.3, 0.7, 0.7, false} )
    config_DefineBool(fValuableEsp, false)
        config_DefineColor(fValuableEsp, {0.3, 0.7, 0.3, 0.7, false} )
    config_DefineBool(fToolEsp, false)
        config_DefineColor(fToolEsp, {0.7, 0.7, 0.3, 0.7, false} )
    config_DefineBool(fWeaponGlow, false)
        config_DefineColor(fWeaponGlow, {1, 1, 1, 1, true} )
    config_DefineBool(fActiveGlow, false)
        config_DefineColor(fActiveGlow, {1, 1, 1, 1, true} )
    config_DefineBool(fRainbowFog, false)
        config_DefineColor(fRainbowFog, {1, 1, 1, 1, true} )
    config_DefineBool(fPostProcess, false)
        config_DefineColor(fPostProcess, {0.5, 0.5, 0.5, 0.5, false} )
    config_DefineBool(fSpinnyTool, false)
        config_DefineSubFloat(fSpinnyTool, fSubSpeed, 1)

    -- player
    config_DefineBool(fSpeed, false)
        config_DefineSubFloat(fSpeed, fSubSpeed, 14)
        config_DefineSubFloat(fSpeed, fSubBoost, 28)
    config_DefineBool(fSpider, false)
    config_DefineBool(fFly, false)
        config_DefineSubFloat(fFly, fSubSpeed, 20)
        config_DefineSubFloat(fFly, fSubBoost, 40)
    config_DefineBool(fNoclip, false)
        config_DefineSubFloat(fNoclip, fSubSpeed, 1)
        config_DefineSubFloat(fNoclip, fSubBoost, 9)
    config_DefineBool(fFloorStrafe, false)
    config_DefineBool(fJetpack, false)
    config_DefineBool(fJesus, false)
    config_DefineBool(fQuickstop, false)
    config_DefineBool(fInfiniteAmmo, false)
    config_DefineBool(fSuperStrength, false)
    config_DefineBool(fGodmode, false)

    -- world
    config_DefineBool(fDisableRobots, false)
    config_DefineBool(fBulletTime, false)
        config_DefineSubFloat(fBulletTime, fBulletTimeScale, 10)
        config_DefineSubBool(fBulletTime, fBulletTimePatch, true)
    config_DefineBool(fSkipObjective, false)
    config_DefineBool(fDisableAlarm, false)
    config_DefineBool(fDisablePhysics, false)
    config_DefineBool(fForceUpdatePhysics, false)
    config_DefineBool(fTeleportValuables, false)
    config_DefineBool(fUnfairValuables, false)

    -- tools
    config_DefineBool(fStructureRestorer, false)
    config_DefineBool(fRubberband, false)
        config_DefineColor(fRubberband, {1.0, 0.3, 1.0, false} )
    config_DefineBool(fTeleport, false)
        config_DefineSubFloat(fTeleport, fSubDelay, 150)
    config_DefineBool(fExplosionBrush, false)
        config_DefineSubFloat(fExplosionBrush, fExplosionBrushSize, 1)
    config_DefineBool(fFireBrush, false)


    config_sortFeatureList()
end

config_sortFeatureList = function() 
    -- sort for feature list.
    UiPush()

        local font_size = config_GetSubInt(fFeatureList, fFontSize)
        local font_id = config_GetSubInt(fFeatureList, fFont) + 1

        UiFont(fonts_array[font_id], font_size)
        table.sort(featurelist, function (left, right)
            return UiGetTextSize(left.legacyName) > UiGetTextSize(right.legacyName)
        end)
    UiPop()
end


config_ResetAllModData = function()
    ClearKey("savegame.mod")
    config_GenerateConfig()
end