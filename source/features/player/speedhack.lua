server.playerSpeedhack = function(playerID)
    local e = syncedPlayerSetting[playerID]
    if not e then return nil end

    local enabled = server.getPlayerConfigValue(playerID, config_getKey(fSpeed))
    if not enabled then return nil end

    local targetSpeed = server.getPlayerConfigValue(playerID, config_getSubKey(fSpeed, fSubSpeed))
    
    if server.utils_Input(InputDown, "shift", playerID) then
        targetSpeed = server.getPlayerConfigValue(playerID, config_getSubKey(fSpeed, fSubBoost))
    end

    if targetSpeed == nil then 
        DebugPrint("[Server] Trying to set player speed to nil. " .. playerID)
        return 
    end

    SetPlayerParam("walkingSpeed", targetSpeed, playerID)
end

-- high speed values are harder to control
-- compared to how we did this before.
-- try increasing friction while using speed
-- or having a sub setting