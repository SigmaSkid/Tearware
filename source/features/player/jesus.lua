player_Jesus = function()
	if not config_AdvGetBool(fJesus) then
        return
    end
    local transform = GetPlayerTransform()
    local inWater, depth = IsPointInWater(transform.pos)

    if not inWater then 
        return 
    end

    local velocity = GetPlayerVelocity()
    
    if utils_TWInputDown("jump") then 
        velocity[2] = 5
    else
        velocity[2] = utils_Clamp(depth*20, 0, 6)
    end

    SetPlayerVelocity(velocity)
end


-- client
client_playerJesus = function()

    local cfgVar = fJesus
    local enabled = config_AdvGetBool(cfgVar)
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
server_playerJesus = function(playerID)
    local entry = serverGetPlayerConfigValues(playerID, fJesus)

    if entry ~= true then return end

    local velocity = GetPlayerVelocity(playerID)
    
    velocity[2] = utils_Clamp(depth*20, 0, 6)
    
    --[[ 
    borked, need to sync menu open state.
    if utils_TWInputDown("jump") then 
        velocity[2] = 5
    else
    ]]
    
    SetPlayerVelocity(velocity, playerID)
end