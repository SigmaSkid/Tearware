-- server
server.playerFloorstrafe = function(playerID)
    return
    --[[
    local entry = serverGetPlayerConfigValues(playerID, fFloorStrafe)

    if entry ~= true then return end

    local velocity = GetPlayerVelocity(playerID)
    velocity[2] = -100
    SetPlayerGroundVelocity(velocity, playerID)
    --]]
end
