-- client
client_playerNofall = function()

    local cfgVar = fNoFall
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
server.playerNofall = function(playerID)
    local entry = serverGetPlayerConfigValues(playerID, fNoFall)

    if entry ~= true then return end

    local velocity = GetPlayerVelocity(playerID)
    velocity[2] = -100

    -- yes, it's just the same code as floor strafe while not on floor :)
    if not IsPlayerGrounded(playerID) then  
        SetPlayerGroundVelocity(velocity, playerID)
    end
end