-- client
client_playerFloorstrafe = function()

    local cfgVar = fFloorStrafe
    local enabled = config_GetLocalFeatureState(cfgVar)
    local currentSettings = nil 

    if enabled then 
        currentSettings = true
    end

    if utils_tableCompare(currentSettings, clientGetSyncedSetting(cfgVar)) then 
        return
    end

    clientScreamAtServerPolitely(cfgVar, currentSettings)
    clientSetSyncedSetting(cfgVar, currentSettings)
end

-- server
server_playerFloorstrafe = function(playerID)
    local entry = serverGetPlayerConfigValues(playerID, fFloorStrafe)

    if entry ~= true then return end

    local velocity = GetPlayerVelocity(playerID)
    velocity[2] = -100
    SetPlayerGroundVelocity(velocity, playerID)
end