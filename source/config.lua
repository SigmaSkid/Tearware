-- tearware on top

#include "source/local.lua"

function DefineBool(var, default) 
    featurelist[#featurelist+1] = var

    if HasKey(cfgstr .. var[2]) and HasKey(cfgstr .. var[2] .. "_key") then 
        if not overrideConfigValues then 
            return
        end
    end

    SetBool(cfgstr .. var[2], default)
    SetString(cfgstr .. var[2] .. "_key", "null")
end

function DefineTool(var) 
    if HasKey(cfgstr .. var[2]) and HasKey(cfgstr .. var[2] .. "_key") then 
        if not overrideConfigValues then 
            return
        end
    end
    SetBool(cfgstr .. var[2], false)
    SetString(cfgstr .. var[2] .. "_key", "null")
end

colorStuff = {"_red", "_green", "_blue", "_alpha", "_rainbow"}
function DefineColor(var, default) 
    for i = 1, #colorStuff-1 do
        if (not HasKey(cfgstr .. var[2] .. colorStuff[i])) or overrideConfigValues then 
            SetFloat(cfgstr .. var[2] .. colorStuff[i], default[i])
        end    
        SetFloat(cfgstr .. var[2] .. colorStuff[i] .. "_default" , default[i])
    end

    if (not HasKey(cfgstr .. var[2] .. colorStuff[#colorStuff])) or overrideConfigValues then 
        SetBool(cfgstr .. var[2] .. colorStuff[#colorStuff], default[#colorStuff])
    end
    SetBool(cfgstr .. var[2] .. colorStuff[#colorStuff] .. "_default" , default[#colorStuff])
end

function ResetColorToDefault(var)
    local base = var[2]
    for i = 1, #colorStuff-1 do 
        local default_val = GetFloat(cfgstr .. base .. colorStuff[i] .. "_default")
        SetFloat(cfgstr .. base .. colorStuff[i], default_val)
    end

    local default_rainbow = GetBool(cfgstr .. base .. colorStuff[#colorStuff] .. "_default")
    SetBool(cfgstr .. base .. colorStuff[#colorStuff], default_rainbow)
end

function DefineSubFloat(var, sub, default) 
    if HasKey(cfgstr .. var[2] .. sub[2]) then 
        if not overrideConfigValues then 
            return
        end
    end
    SetFloat(cfgstr .. var[2] .. sub[2], default)
end

function GetSubFloat(var, sub)
    return GetFloat(cfgstr .. var[2] .. sub[2])
end

function SetSubFloat(var, sub, value)
    return SetFloat(cfgstr .. var[2] .. sub[2], value)
end

function DefineSubBool(var, sub, default) 
    if HasKey(cfgstr .. var[2] .. sub[2]) then 
        if not overrideConfigValues then 
            return
        end
    end
    SetBool(cfgstr .. var[2] .. sub[2], default)
end

function GetSubBool(var, sub)
    return GetBool(cfgstr .. var[2] .. sub[2])
end

function SetSubBool(var, sub, value)
    return SetBool(cfgstr .. var[2] .. sub[2], value)
end

function GetColor(var, seed)
    local color = {}
    color.rainbow = GetBool(cfgstr .. var[2] .. colorStuff[5])
    if color.rainbow then 
        color.red = math.sin(seed + 0) * 0.5 + 0.5;
        color.green = math.sin(seed + 2) * 0.5 + 0.5;
        color.blue = math.sin(seed + 4) * 0.5 + 0.5;
    else
        color.red = GetFloat(cfgstr .. var[2] .. colorStuff[1])
        color.green = GetFloat(cfgstr .. var[2] .. colorStuff[2])
        color.blue = GetFloat(cfgstr .. var[2] .. colorStuff[3])
    end
    color.alpha = GetFloat(cfgstr .. var[2] .. colorStuff[4])

    return color
end

function SetColor(var, color)
    SetBool(cfgstr .. var[2] .. colorStuff[5], color.rainbow)
    SetFloat(cfgstr .. var[2] .. colorStuff[4], color.alpha)
    if color.rainbow then 
        return 
    end
    SetFloat(cfgstr .. var[2] .. colorStuff[1], color.red)
    SetFloat(cfgstr .. var[2] .. colorStuff[2], color.green)
    SetFloat(cfgstr .. var[2] .. colorStuff[3], color.blue)
end

function AdvGetBool(var)
    return GetBool(cfgstr .. var[2])
end

function UpdateFeatureState(var)
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
function UpdateAllFeatureStates()
    for i = 1, #featurelist do 
        UpdateFeatureState(featurelist[i])
    end
end


function ResetConfig()
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
    DefineTool(fTeleport)
    DefineBool(fExplosionBrush, false)
      DefineSubFloat(fExplosionBrush, fExplosionBrushSize, 1)
    DefineBool(fFireBrush, false)
    DefineBool(fStructureRestorer, false)
    
    -- debug & config
    

    -- sort for feature list.
    UiPush()
        UiFont("bold.ttf", 12)
        table.sort(featurelist, function (left, right)
            return UiGetTextSize(left[1]) > UiGetTextSize(right[1])
        end)
    UiPop()
end

-- dll main, but more gay
function init()
    overrideConfigValues = false
    ResetConfig() 
end
