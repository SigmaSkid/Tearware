-- tearware on top

#include "local.lua"


-- haha local keyword funny
local config = {}

config.DefineBool = function(var, default) 
    featurelist[#featurelist+1] = var

    if HasKey(cfgstr .. var[2]) and HasKey(cfgstr .. var[2] .. "_key") then
        if not overrideConfigValues then 
            return
        end
    end

    SetBool(cfgstr .. var[2], default)
    SetString(cfgstr .. var[2] .. "_key", "null")
end

config.DefineInt = function(var, default) 
    if HasKey(cfgstr .. var[2]) then
        if not overrideConfigValues then 
            return
        end
    end

    SetInt(cfgstr .. var[2], default)
end

config.GetCfgInt = function(var)
    return GetInt(cfgstr .. var[2])
end

config.DefineColor = function(var, default) 
    for i = 1, #colorSuffix-1 do
        if (not HasKey(cfgstr .. var[2] .. colorSuffix[i])) or overrideConfigValues then
            SetFloat(cfgstr .. var[2] .. colorSuffix[i], default[i])
        end    
        SetFloat(cfgstr .. var[2] .. colorSuffix[i] .. "_default" , default[i])
    end

    if (not HasKey(cfgstr .. var[2] .. colorSuffix[#colorSuffix])) or overrideConfigValues then
        SetBool(cfgstr .. var[2] .. colorSuffix[#colorSuffix], default[#colorSuffix])
    end
    SetBool(cfgstr .. var[2] .. colorSuffix[#colorSuffix] .. "_default" , default[#colorSuffix])
end

config.ResetColorToDefault = function(var)
    local base = var[2]
    for i = 1, #colorSuffix-1 do
        local default_val = GetFloat(cfgstr .. base .. colorSuffix[i] .. "_default")
        SetFloat(cfgstr .. base .. colorSuffix[i], default_val)
    end

    local default_rainbow = GetBool(cfgstr .. base .. colorSuffix[#colorSuffix] .. "_default")
    SetBool(cfgstr .. base .. colorSuffix[#colorSuffix], default_rainbow)
end

config.DefineSubFloat = function(var, sub, default) 
    if HasKey(cfgstr .. var[2] .. sub[2]) then 
        if not overrideConfigValues then 
            return
        end
    end
    SetFloat(cfgstr .. var[2] .. sub[2], default)
end

config.GetSubFloat = function(var, sub)
    return GetFloat(cfgstr .. var[2] .. sub[2])
end

config.SetSubFloat = function(var, sub, value)
    return SetFloat(cfgstr .. var[2] .. sub[2], value)
end

config.DefineSubBool = function(var, sub, default) 
    if HasKey(cfgstr .. var[2] .. sub[2]) then 
        if not overrideConfigValues then 
            return
        end
    end
    SetBool(cfgstr .. var[2] .. sub[2], default)
end

config.GetSubBool = function(var, sub)
    return GetBool(cfgstr .. var[2] .. sub[2])
end

config.SetSubBool = function(var, sub, value)
    return SetBool(cfgstr .. var[2] .. sub[2], value)
end

config.GetColor = function(var, seed)
    -- nil check, just in case
    seed=seed or GetTime()

    local color = {}
    color.rainbow = GetBool(cfgstr .. var[2] .. colorSuffix[5])
    if color.rainbow then 
        color.red = math.sin(seed + 0) * 0.5 + 0.5;
        color.green = math.sin(seed + 2) * 0.5 + 0.5;
        color.blue = math.sin(seed + 4) * 0.5 + 0.5;
    else
        color.red = GetFloat(cfgstr .. var[2] .. colorSuffix[1])
        color.green = GetFloat(cfgstr .. var[2] .. colorSuffix[2])
        color.blue = GetFloat(cfgstr .. var[2] .. colorSuffix[3])
    end
    color.alpha = GetFloat(cfgstr .. var[2] .. colorSuffix[4])

    return color
end

config.FlipBool = function(var)
    SetBool(var, not GetBool(var))
end

config.SetColor = function(var, color)
    SetBool(cfgstr .. var[2] .. colorSuffix[5], color.rainbow)
    SetFloat(cfgstr .. var[2] .. colorSuffix[4], color.alpha)
    if color.rainbow then 
        return 
    end
    SetFloat(cfgstr .. var[2] .. colorSuffix[1], color.red)
    SetFloat(cfgstr .. var[2] .. colorSuffix[2], color.green)
    SetFloat(cfgstr .. var[2] .. colorSuffix[3], color.blue)
end

config.AdvGetBool = function(var)
    return GetBool(cfgstr .. var[2])
end

config.UpdateFeatureState = function(var)
    if not HasKey(cfgstr .. var[2] .. "_key") then 
        return GetBool(cfgstr .. var[2])
    end

    local key = GetString(cfgstr .. var[2] .. "_key")
    if key == "null" or key == "" or key == nil then 
        return GetBool(cfgstr .. var[2])
    end

    if InputPressed(key) then 
        SetBool(cfgstr .. var[2], not GetBool(cfgstr .. var[2]))
    end
end

-- has to be done this way, because InputPressed
-- is for some reason unreliable in update function
config.UpdateAllFeatureStates = function()
    if lockInputs then return end

    for i = 1, #featurelist do 
        UpdateFeatureState(featurelist[i])
    end
end


config.ResetConfig = function()
    featurelist = {}

    -- visuals
    DefineBool(fVisuals, true)
    DefineBool(fWatermark, true)
      DefineColor(fWatermark, {1, 1, 1, 1, true} )
    DefineBool(fFeatureList, false)
      DefineColor(fFeatureList, {1, 1, 1, 1, true} )
    DefineBool(fObjectiveEsp, false)
      DefineColor(fObjectiveEsp, {0.7, 0.3, 0.3, 0.7, false} )
    DefineBool(fOptionalEsp, false)
      DefineColor(fOptionalEsp, {0.3, 0.3, 0.7, 0.7, false} )
    DefineBool(fValuableEsp, false)
      DefineColor(fValuableEsp, {0.3, 0.7, 0.3, 0.7, false} )
    DefineBool(fToolEsp, false)
      DefineColor(fToolEsp, {0.7, 0.7, 0.3, 0.7, false} )
    DefineBool(fWeaponGlow, false)
      DefineColor(fWeaponGlow, {1, 1, 1, 1, true} )
    DefineBool(fActiveGlow, false)
      DefineColor(fActiveGlow, {1, 1, 1, 1, true} )
    DefineBool(fRainbowFog, false)
      DefineColor(fRainbowFog, {1, 1, 1, 1, true} )
    DefineBool(fPostProcess, false)
      DefineColor(fPostProcess, {0.5, 0.5, 0.5, 0.5, false} )
    DefineBool(fSpinnyTool, false)
    
    -- movement
    DefineBool(fSpeed, false)
      DefineSubFloat(fSpeed, fSubSpeed, 14)
      DefineSubFloat(fSpeed, fSubBoost, 28)
    DefineBool(fSpider, false)
    DefineBool(fFly, false)
      DefineSubFloat(fFly, fSubSpeed, 20)
      DefineSubFloat(fFly, fSubBoost, 40)
    DefineBool(fNoclip, false)
      DefineSubFloat(fNoclip, fSubSpeed, 1)
      DefineSubFloat(fNoclip, fSubBoost, 9)
    DefineBool(fFloorStrafe, false)
    DefineBool(fJetpack, false)
    DefineBool(fJesus, false)
    DefineBool(fQuickstop, false)
    
    -- misc
    DefineBool(fInfiniteAmmo, false)
    DefineBool(fSuperStrength, false)
    DefineBool(fGodmode, false)
    DefineBool(fBulletTime, false)
      DefineSubFloat(fBulletTime, fBulletTimeScale, 10)
      DefineSubBool(fBulletTime, fBulletTimePatch, true)
    DefineBool(fSkipObjective, false)
    DefineBool(fDisableAlarm, false)
    DefineBool(fDisablePhysics, false)
    DefineBool(fForceUpdatePhysics, false)

    -- tools
    DefineBool(fRubberband, false)
      DefineColor(fRubberband, {1.0, 0.3, 1.0, false} )
    DefineBool(fTeleportValuables, false)
    DefineBool(fUnfairValuables, false)
    DefineBool(fTeleport, false)
    DefineBool(fExplosionBrush, false)
      DefineSubFloat(fExplosionBrush, fExplosionBrushSize, 1)
    DefineBool(fFireBrush, false)
    DefineBool(fStructureRestorer, false)
    
    -- menu stuff
    DefineInt(fMenuStyle, 0)



    -- debug & config
    

    -- sort for feature list.
    UiPush()
        UiFont("bold.ttf", 12)
        table.sort(featurelist, function (left, right)
            return UiGetTextSize(left[1]) > UiGetTextSize(right[1])
        end)
    UiPop()
end
