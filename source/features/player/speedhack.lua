client_playerSpeedhack = function()
    local cfgVar = fSpeed
    local enabled = config_GetLocalFeatureState(cfgVar)
    local currentSettings = nil 

    if enabled then 
        currentSettings =
        { 
            baseSpeed = config_GetSubVar(GetFloat,cfgVar, fSubSpeed),
            boostSpeed = config_GetSubVar(GetFloat,cfgVar, fSubBoost)
        }
    end

    if utils_tableCompare(currentSettings, clientGetSyncedSetting(cfgVar)) then 
        return
    end

    clientScreamAtServerPolitely(cfgVar, currentSettings)
    clientSetSyncedSetting(cfgVar, currentSettings)
end

server_playerSpeedhack = function(playerID)
    local entry = serverGetPlayerConfigValues(playerID, fSpeed)

    if entry == null or entry.baseSpeed == null or entry.boostSpeed == null then 
        return 
    end

    local targetSpeed = entry.baseSpeed
    if InputDown("shift", playerID) then
        targetSpeed = entry.boostSpeed
    end

    SetPlayerParam("walkingSpeed", targetSpeed, playerID)
end

-- high speed values are harder to control
-- compared to how we did this before.
-- try increasing friction while using speed
-- or having a sub setting