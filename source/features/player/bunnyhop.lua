-- client
client_playerBunnyhop = function()

    local cfgVar = fBunnyhop
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
server_playerBunnyhop = function(playerID, dt)
    local entry = serverGetPlayerConfigValues(playerID, fBunnyhop)
    if entry ~= true then return end

    local max_horizontal_velocity = 20
    local approach_factor = 0.1 -- per-jump step toward max, 0-1

    if IsPlayerGrounded(playerID) and InputDown("space", playerID) then  
        local velocity = GetPlayerVelocity(playerID)
        local transform = GetPlayerTransformWithPitch(playerID)

        velocity[2] = 0

        local speed = VecLength(velocity)

        if speed > 0 then
            local normalized = VecNormalize(velocity)
            local new_speed = speed + (max_horizontal_velocity - speed) * approach_factor

            velocity[1] = normalized[1] * new_speed
            velocity[3] = normalized[3] * new_speed
            --DebugWatch("Velocity", new_speed)
        end

        velocity[2] = 5
        transform.pos[2] = transform.pos[2] + 0.05

        SetPlayerTransformWithPitch(transform, playerID)
        SetPlayerVelocity(velocity, playerID)
    end
end