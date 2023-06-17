-- tearware on top

#include "local.lua"

config.DefineBool = function(var, default) 
    featurelist[#featurelist+1] = var

    if HasKey(cfgstr .. var.configString) and HasKey(cfgstr .. var.configString .. "_key") then
        if not overrideConfigValues then 
            return
        end
    end

    SetBool(cfgstr .. var.configString, default)
    SetString(cfgstr .. var.configString .. "_key", "null")
end

config.DefineInt = function(var, default) 
    if HasKey(cfgstr .. var.configString) then
        if not overrideConfigValues then 
            return
        end
    end

    SetInt(cfgstr .. var.configString, default)
end

config.GetInt = function(var)
    return GetInt(cfgstr .. var.configString)
end

config.SetInt = function(var, val) 
    SetInt(cfgstr .. var.configString, val)
end

config.DefineColor = function(var, default) 
    for i = 1, #colorSuffix-1 do
        if (not HasKey(cfgstr .. var.configString .. colorSuffix[i])) or overrideConfigValues then
            SetFloat(cfgstr .. var.configString .. colorSuffix[i], default[i])
        end    
        SetFloat(cfgstr .. var.configString .. colorSuffix[i] .. "_default" , default[i])
    end

    if (not HasKey(cfgstr .. var.configString .. colorSuffix[#colorSuffix])) or overrideConfigValues then
        SetBool(cfgstr .. var.configString .. colorSuffix[#colorSuffix], default[#colorSuffix])
    end
    SetBool(cfgstr .. var.configString .. colorSuffix[#colorSuffix] .. "_default" , default[#colorSuffix])
end

config.ResetColorToDefault = function(var)
    local base = var.configString
    for i = 1, #colorSuffix-1 do
        local default_val = GetFloat(cfgstr .. base .. colorSuffix[i] .. "_default")
        SetFloat(cfgstr .. base .. colorSuffix[i], default_val)
    end

    local default_rainbow = GetBool(cfgstr .. base .. colorSuffix[#colorSuffix] .. "_default")
    SetBool(cfgstr .. base .. colorSuffix[#colorSuffix], default_rainbow)
end

config.DefineSubFloat = function(var, sub, default) 
    if HasKey(cfgstr .. var.configString .. sub.configString) then 
        if not overrideConfigValues then 
            return
        end
    end
    SetFloat(cfgstr .. var.configString .. sub.configString, default)
end

config.GetSubFloat = function(var, sub)
    return GetFloat(cfgstr .. var.configString .. sub.configString)
end

config.SetSubFloat = function(var, sub, value)
    return SetFloat(cfgstr .. var.configString .. sub.configString, value)
end

config.DefineSubBool = function(var, sub, default) 
    if HasKey(cfgstr .. var.configString .. sub.configString) then 
        if not overrideConfigValues then 
            return
        end
    end
    SetBool(cfgstr .. var.configString .. sub.configString, default)
end

config.GetSubBool = function(var, sub)
    return GetBool(cfgstr .. var.configString .. sub.configString)
end

config.SetSubBool = function(var, sub, value)
    return SetBool(cfgstr .. var.configString .. sub.configString, value)
end

config.GetColor = function(var, seed)
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

config.FlipBool = function(var)
    SetBool(var, not GetBool(var))
end

config.SetColor = function(var, color)
    SetBool(cfgstr .. var.configString .. colorSuffix[5], color.rainbow)
    SetFloat(cfgstr .. var.configString .. colorSuffix[4], color.alpha)
    if color.rainbow then 
        return 
    end
    SetFloat(cfgstr .. var.configString .. colorSuffix[1], color.red)
    SetFloat(cfgstr .. var.configString .. colorSuffix[2], color.green)
    SetFloat(cfgstr .. var.configString .. colorSuffix[3], color.blue)
end

config.AdvGetBool = function(var)
    return GetBool(cfgstr .. var.configString)
end

config.UpdateFeatureState = function(var)
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
config.UpdateAllFeatureStates = function()
    if lockInputs then return end

    for i = 1, #featurelist do 
        config.UpdateFeatureState(featurelist[i])
    end
end


config.ResetConfig = function()
    featurelist = {}

    -- visuals
    config.DefineBool(fWatermark, true)
        config.DefineColor(fWatermark, {1, 1, 1, 1, true} )
    config.DefineBool(fFeatureList, false)
        config.DefineColor(fFeatureList, {1, 1, 1, 1, true} )
    config.DefineBool(fObjectiveEsp, false)
        config.DefineColor(fObjectiveEsp, {0.7, 0.3, 0.3, 0.7, false} )
    config.DefineBool(fOptionalEsp, false)
        config.DefineColor(fOptionalEsp, {0.3, 0.3, 0.7, 0.7, false} )
    config.DefineBool(fValuableEsp, false)
        config.DefineColor(fValuableEsp, {0.3, 0.7, 0.3, 0.7, false} )
    config.DefineBool(fToolEsp, false)
        config.DefineColor(fToolEsp, {0.7, 0.7, 0.3, 0.7, false} )
    config.DefineBool(fWeaponGlow, false)
        config.DefineColor(fWeaponGlow, {1, 1, 1, 1, true} )
    config.DefineBool(fActiveGlow, false)
        config.DefineColor(fActiveGlow, {1, 1, 1, 1, true} )
    config.DefineBool(fRainbowFog, false)
        config.DefineColor(fRainbowFog, {1, 1, 1, 1, true} )
    config.DefineBool(fPostProcess, false)
        config.DefineColor(fPostProcess, {0.5, 0.5, 0.5, 0.5, false} )
    config.DefineBool(fSpinnyTool, false)

    -- player
    config.DefineBool(fSpeed, false)
        config.DefineSubFloat(fSpeed, fSubSpeed, 14)
        config.DefineSubFloat(fSpeed, fSubBoost, 28)
    config.DefineBool(fSpider, false)
    config.DefineBool(fFly, false)
        config.DefineSubFloat(fFly, fSubSpeed, 20)
        config.DefineSubFloat(fFly, fSubBoost, 40)
    config.DefineBool(fNoclip, false)
        config.DefineSubFloat(fNoclip, fSubSpeed, 1)
        config.DefineSubFloat(fNoclip, fSubBoost, 9)
    config.DefineBool(fFloorStrafe, false)
    config.DefineBool(fAutoBunnyhop, false)
    config.DefineBool(fJetpack, false)
    config.DefineBool(fJesus, false)
    config.DefineBool(fQuickstop, false)
    config.DefineBool(fInfiniteAmmo, false)
    config.DefineBool(fSuperStrength, false)
    config.DefineBool(fGodmode, false)

    -- world
    config.DefineBool(fDisableRobots, false)
    config.DefineBool(fBulletTime, false)
        config.DefineSubFloat(fBulletTime, fBulletTimeScale, 10)
        config.DefineSubBool(fBulletTime, fBulletTimePatch, true)
    config.DefineBool(fSkipObjective, false)
    config.DefineBool(fDisableAlarm, false)
    config.DefineBool(fDisablePhysics, false)
    config.DefineBool(fForceUpdatePhysics, false)
    config.DefineBool(fTeleportValuables, false)
    config.DefineBool(fUnfairValuables, false)

    -- tools
    config.DefineBool(fStructureRestorer, false)
    config.DefineBool(fRubberband, false)
        config.DefineColor(fRubberband, {1.0, 0.3, 1.0, false} )
    config.DefineBool(fTeleport, false)
    config.DefineBool(fExplosionBrush, false)
        config.DefineSubFloat(fExplosionBrush, fExplosionBrushSize, 1)
    config.DefineBool(fFireBrush, false)

    -- menu stuff
    config.DefineInt(fMenuStyle, 0)

    -- sort for feature list.
    UiPush()
        UiFont("bold.ttf", 12)
        table.sort(featurelist, function (left, right)
            return UiGetTextSize(left.legacyName) > UiGetTextSize(right.legacyName)
        end)
    UiPop()
end
