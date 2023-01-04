-- tearware on top

#include "source/local.lua"

function DefineBool(var, default) 
    featurelist[#featurelist+1] = var

    if HasKey(cfgstr .. var[2]) and HasKey(cfgstr .. var[2] .. "_key") then 
        return 
    end

    SetBool(cfgstr .. var[2], default)
    SetString(cfgstr .. var[2] .. "_key", "null")
end

function DefineTool(var) 
    if HasKey(cfgstr .. var[2]) and HasKey(cfgstr .. var[2] .. "_key") then 
        return 
    end
    SetBool(cfgstr .. var[2], false)
    SetString(cfgstr .. var[2] .. "_key", "null")
end

function DefineInt(var, default) 
    if HasKey(cfgstr .. var) then 
        return 
    end
    SetInt(cfgstr .. var, default)
end

function AdvGetBool(var)
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
    
    return GetBool(cfgstr .. var[2]) 
end

-- dll main, but more gay
function init()
    -- weapons/aim/triggerbot idk?
    DefineBool(fInfiniteAmmo, false)
    
    -- visuals
    DefineBool(fVisuals, true)
    DefineBool(fWatermark, true)
    DefineBool(fFeatureList, false)
    DefineBool(fObjectiveEsp, false)
    DefineBool(fValuableEsp, false)
    DefineBool(fToolEsp, false)
    DefineBool(fWeaponGlow, false)
    DefineBool(fActiveGlow, false)
    
    -- movement
    DefineBool(fSpeed, false)
    DefineBool(fSpider, false)
    DefineBool(fFly, false)
    DefineBool(fNoclip, false)
    DefineBool(fFloorStrafe, false)
    DefineBool(fJetpack, false)
    DefineBool(fJesus, false)
    DefineBool(fQuickstop, false)
    
    -- misc
    DefineBool(fGodmode, false)
    DefineBool(fBulletTime, false)
    DefineBool(fSkipObjective, false)
    DefineBool(fDisableAlarm, false)
    DefineBool(fDisablePhysics, false)
    DefineBool(fForceUpdatePhysics, false)

    -- tools
    DefineBool(fRubberband, false)
    DefineBool(fTeleportValuables, false)
    DefineBool(fUnfairValuables, false)
    DefineTool(fTeleport)
    DefineBool(fExplosionBrush, false)
    DefineBool(fFireBrush, false)
    
    -- sort for feature list.
    UiPush()
        UiFont("bold.ttf", 12)
        table.sort(featurelist, function (left, right)
            return UiGetTextSize(left[1]) > UiGetTextSize(right[1])
        end)
    UiPop()
end
