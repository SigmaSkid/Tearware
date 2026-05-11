server.playerJetpack = function(playerID, dt)
    local e = syncedPlayerSetting[playerID]
    if not e then return nil end

    local enabled = server.getPlayerConfigValue(playerID, config_getKey(fJetpack))
    if not enabled then return nil end

    if server.utils_Input(InputDown, "jump", playerID) then
        local velocity = GetPlayerVelocity(playerID)

        velocity[2] = velocity[2] + (25 * dt)
        if velocity[2] > 7 then 
            velocity[2] = 7 
        end

        SetPlayerVelocity(velocity, playerID) 
    end
end