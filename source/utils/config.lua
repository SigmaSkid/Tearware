#include "local.lua"

configTypeRegistry = {}

config_getKey = function(var)
    return cfgstr .. var.configString
end

config_getKeyInput = function(var)
    return cfgstr.. var.configString .. ".key"
end

config_getSubKey = function(var, sub)
    return cfgstr .. var.configString .. "." .. sub.configString
end

--- CONFIG SYSTEM V2
config_DefineFeature = function(var, default)
    featurelist[#featurelist+1] = var

    local key = config_getKey(var)
    if not HasKey(key) then
        SetBool(key, default)
    end

    local keyInput = config_getKeyInput(var)
    if not HasKey(keyInput) then
        SetString(keyInput, "null")
    end

    configTypeRegistry[key] = SetBool
    configTypeRegistry[keyInput] = SetString

end

config_DefineVar = function(SetType, var, default)
    local key = config_getKey(var)
    configTypeRegistry[key] = SetType

    if HasKey(key) then
        return
    end
    SetType(key, default)
end

config_GetVar = function(GetType, var)
    return GetType(config_getKey(var))
end

config_DefineSubVar = function(SetType, var, sub, default)
    local key = config_getSubKey(var, sub)
    configTypeRegistry[key] = SetType
    if HasKey(key) then 
        return
    end
    SetType(key, default)
end

config_GetSubVar = function(GetType, var, sub)
    return GetType(config_getSubKey(var, sub))
end

config_SetVar = function(SetType, var, val) 
    local key = config_getKey(var)

    -- forward change to server 
    client.ScreamAtServerPolitely(key, val)

    SetType(key, val)
end

config_SetSubVar = function(SetType, var, sub, val)
    local key = config_getSubKey(var, sub)

    -- forward change to server 
    client.ScreamAtServerPolitely(key, val)

    return SetType(key, val)
end

config_ToggleFeature = function(var)
    local key = config_getKey(var)
    local val = not GetBool(key)
    SetBool(key, val)

    -- featurelistForceCacheUpdate = true
    featureListToggleSingle(var, val)

    -- forward change to server 
    client.ScreamAtServerPolitely(key, val)
end

config_GetLocalFeatureState = function(var)
    return GetBool(config_getKey(var))
end

config_DefineColor = function(var, default) 
    local pre = config_getKey(var)

    for i = 1, #colorSuffix-1 do
        if (not HasKey(pre .. colorSuffix[i])) then
            SetFloat(pre .. colorSuffix[i], default[i])
        end    
        SetFloat(pre .. colorSuffix[i] .. ".default" , default[i])
    end

    if (not HasKey(pre .. colorSuffix[#colorSuffix])) then
        SetBool(pre .. colorSuffix[#colorSuffix], default[#colorSuffix])
    end
    SetBool(pre .. colorSuffix[#colorSuffix] .. ".default" , default[#colorSuffix])
end

config_ResetColorToDefault = function(var)
    local pre = config_getKey(var)

    for i = 1, #colorSuffix-1 do
        local default_val = GetFloat(pre .. colorSuffix[i] .. ".default")
        SetFloat(pre .. colorSuffix[i], default_val)
    end

    local default_rainbow = GetBool(pre .. colorSuffix[#colorSuffix] .. ".default")
    SetBool(pre .. colorSuffix[#colorSuffix], default_rainbow)
end

config_GetColor = function(var, seed)
    local pre = config_getKey(var)

    seed=seed or GetTime()

    local color = {}
    color.rainbow = GetBool(pre .. colorSuffix[5])
    if color.rainbow then 
        color.red = math.sin(seed + 0) * 0.5 + 0.5;
        color.green = math.sin(seed + 2) * 0.5 + 0.5;
        color.blue = math.sin(seed + 4) * 0.5 + 0.5;
    else
        color.red = GetFloat(pre .. colorSuffix[1])
        color.green = GetFloat(pre .. colorSuffix[2])
        color.blue = GetFloat(pre .. colorSuffix[3])
    end
    color.alpha = GetFloat(pre .. colorSuffix[4])

    return color
end


-- we don't need to forward this to the server. 
-- all features that use colors are clientside, 
-- and the one exception (fog) is host only and networked by the game.
config_SetColor = function(var, color)
    local pre = config_getKey(var)
    DebugPrint(pre .. colorSuffix[5])
    SetBool(pre .. colorSuffix[5], color.rainbow)
    SetFloat(pre .. colorSuffix[4], color.alpha)
    if color.rainbow then 
        return 
    end
    SetFloat(pre .. colorSuffix[1], color.red)
    SetFloat(pre .. colorSuffix[2], color.green)
    SetFloat(pre .. colorSuffix[3], color.blue)
end

config_UpdateFeatureState = function(var)
    local str = config_getKeyInput(var)
    if not HasKey(config_getKeyInput(var)) then 
        return false
    end

    local key = GetString(str)
    if key == "null" or key == "" or key == nil then 
        return false
    end

    if InputPressed(key) then 
        config_ToggleFeature(var)
        return true
    end

    return false
end

-- has to be done this way, because InputPressed
-- is for some reason unreliable in update function
config_UpdateAllFeatureStates = function()
    local lockInputs = config_GetVar(GetBool, fInputLock)
    if lockInputs then return end

    local didSomethingUpdate = false
    for i = 1, #featurelist do 
        local updateState = config_UpdateFeatureState(featurelist[i])
        if updateState then didSomethingUpdate = true end
    end

    if didSomethingUpdate then 
        -- featurelistForceCacheUpdate = true
    end

end

config_GenerateConfig = function()
    featurelist = {}

    -- 
    config_DefineVar(SetFloat, fMenuX, 0.5)
    config_DefineVar(SetFloat, fMenuY, 0.5)
    config_DefineVar(SetBool, fInputLock, 0.5)

    -- visuals
    config_DefineFeature(fWatermark, true)
        config_DefineColor(fWatermark, {1, 1, 1, 1, true} )
        config_DefineSubVar(SetInt, fWatermark, fAlignmentLR, 0)
    config_DefineFeature(fFeatureList, false)
        config_DefineColor(fFeatureList, {1, 1, 1, 1, true} )
        config_DefineSubVar(SetInt, fFeatureList, fAlignmentLR, 0)
    config_DefineFeature(fObjectiveEsp, false)
        config_DefineColor(fObjectiveEsp, {0.7, 0.3, 0.3, 0.7, false} )
    config_DefineFeature(fOptionalEsp, false)
        config_DefineColor(fOptionalEsp, {0.3, 0.3, 0.7, 0.7, false} )
    config_DefineFeature(fValuableEsp, false)
        config_DefineColor(fValuableEsp, {0.3, 0.7, 0.3, 0.7, false} )
    config_DefineFeature(fToolEsp, false)
        config_DefineColor(fToolEsp, {0.7, 0.7, 0.3, 0.7, false} )
    config_DefineFeature(fWeaponGlow, false)
        config_DefineColor(fWeaponGlow, {1, 1, 1, 1, true} )
    config_DefineFeature(fPlayerGlow, false)
        config_DefineColor(fPlayerGlow, {1, 1, 1, 1, true} )
    config_DefineFeature(fActiveGlow, false)
        config_DefineColor(fActiveGlow, {1, 1, 1, 1, true} )
    config_DefineFeature(fRainbowFog, false)
        config_DefineColor(fRainbowFog, {1, 1, 1, 1, true} )
    config_DefineFeature(fPostProcess, false)
        config_DefineColor(fPostProcess, {0.5, 0.5, 0.5, 0.5, false} )

    -- player
    config_DefineFeature(fSpeed, false)
        config_DefineSubVar(SetFloat, fSpeed, fSubSpeed, 14)
        config_DefineSubVar(SetFloat, fSpeed, fSubBoost, 28)
    config_DefineFeature(fSpider, false)
    config_DefineFeature(fFly, false)
    config_DefineFeature(fFloorStrafe, false)
    config_DefineFeature(fBunnyhop, false)
    config_DefineFeature(fJetpack, false)
    config_DefineFeature(fJesus, false)
    config_DefineFeature(fQuickstop, false)
    config_DefineFeature(fInfiniteAmmo, false)
    config_DefineFeature(fSuperStrength, false)
    config_DefineFeature(fGodmode, false)

    -- antiaim
    config_DefineFeature(fResolver, false)
    config_DefineFeature(fAntiAim, false)
        config_DefineSubVar(SetInt, fAntiAim, fAntiAimYawModes, 0)
        config_DefineSubVar(SetFloat, fAntiAim, fSubYawOffset, 1)
        config_DefineSubVar(SetFloat, fAntiAim, fSubYawSpeed, 360)
        config_DefineSubVar(SetFloat, fAntiAim, fSubYawAmp, 45)

        config_DefineSubVar(SetInt, fAntiAim, fAntiAimPitchModes, 0)
        config_DefineSubVar(SetFloat, fAntiAim, fSubPitchOffset, 1)
        config_DefineSubVar(SetFloat, fAntiAim, fSubPitchSpeed, 180)
        config_DefineSubVar(SetFloat, fAntiAim, fSubPitchAmp, 20)

    -- world
    config_DefineFeature(fDisableRobots, false)
    config_DefineFeature(fBulletTime, false)
        config_DefineSubVar(SetFloat, fBulletTime, fSubScale, 10)
    config_DefineFeature(fSkipObjective, false)
    config_DefineFeature(fDisableAlarm, false)
    config_DefineFeature(fDisablePhysics, false)
    config_DefineFeature(fForceUpdatePhysics, false)
    config_DefineFeature(fTeleportValuables, false)
    config_DefineFeature(fUnfairValuables, false)

    -- tools
    config_DefineFeature(fStructureRestorer, false)
    config_DefineFeature(fRubberband, false)
        config_DefineColor(fRubberband, {1.0, 0.3, 1.0, 1.0, false} )
    config_DefineFeature(fTeleport, false)
        config_DefineSubVar(SetFloat, fTeleport, fSubDelay, 150)
    config_DefineFeature(fExplosionBrush, false)
        config_DefineSubVar(SetFloat, fExplosionBrush, fSubSize, 1)
    config_DefineFeature(fFireBrush, false)

    visuals_sortFeatureList()
end

utils_GrabAllSubKeys = function(root, out)
    out = out or {}
    
    local keys = ListKeys(root)
    for i = 1, #keys do
        local fullKey = root .. "." .. keys[i]

        out[#out+1] = fullKey

        -- recurse only if this node has children
        if HasKey(fullKey) then
            local sub = ListKeys(fullKey)
            if sub and #sub > 0 then
                utils_GrabAllSubKeys(fullKey, out)
            end
        end
    end

    return out
end


config_screamEverySecretAtTheServer = function()
    local keys = utils_GrabAllSubKeys("savegame.mod")
    -- DebugWatch("Subkeys", #keys)
    if not keys then return end
    DebugPrint("Telling the server our deepest secrets :3 All " .. #keys .. " of them.")

    for i = 1, #keys do
        local key = keys[i]

        if HasKey(key) then
            local setter = configTypeRegistry[key]

            local val = nil
            local valStr = ""

            if setter == SetBool then
                val = GetBool(key)
                valStr = utils_boolStr(val)
            elseif setter == SetFloat then
                val = GetFloat(key)
                valStr = val
            elseif setter == SetInt then
                val = GetInt(key)
                valStr = val
            elseif setter == SetString then
                val = GetString(key)
                valStr = val
            end

            if val ~= nil then
                -- DebugPrint("EEEEEE " .. key .. " " .. valStr)
                client.ScreamAtServerPolitely(key, val)
            end
        else
            DebugPrint("config_screamEverySecretAtTheServer tried to iterate over invalid key. " .. key)
        end
    end
end

config_ResetAllModData = function()
    ClearKey("savegame.mod")
    config_GenerateConfig()
    config_screamEverySecretAtTheServer()
end