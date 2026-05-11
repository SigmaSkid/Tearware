server.playerJesus = function(playerID)
    local e = syncedPlayerSetting[playerID]
    if not e then return nil end

    local enabled = server.getPlayerConfigValue(playerID, config_getKey(fJesus))
    if not enabled then return nil end

    local transform = GetPlayerTransform(playerID)
    local inWater, depth = IsPointInWater(transform.pos)

    if not inWater then 
        return 
    end

    local velocity = GetPlayerVelocity(playerID)
    
    if server.utils_Input(InputDown, "jump", playerID) then
        velocity[2] = 5
    else
        velocity[2] = utils_Clamp(depth*20, 0, 6)
    end

    SetPlayerVelocity(velocity, playerID)

    --[[
        We could use SetAnimatorPositionIK to do inverse kinematics to make it look like the player
        is standing on the water, rather than floating..
        BUT we would have to do that on every client.
    ]]
end