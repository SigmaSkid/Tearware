-- client
client_ToolsTeleport = function()
    if not config_AdvGetBool(fTeleport) then
        return 
    end

    SetBool(cfgstr .. fTeleport.configString, false)
    
    local targetPos = utils_GetPosWeAreLookingAt()
    if targetPos == nil then return end

    local delay = config_GetSubFloat(fTeleport, fSubDelay) / 1000

    ServerCall("server.teleportTarget", GetLocalPlayer(), localUUID, targetPos, delay)
end

-- server. 
playersTeleportTargets = {}

server.teleportTarget = function(playerID, UUID, targetPos, delay)

    if not serverVerify(playerID, UUID) then return end

    DebugPrint("server.teleportTarget " .. playerID .. "-" .. GetPlayerName(playerID) .. " delay: " .. delay)

    playersTeleportTargets[playerID] = { startPos = GetPlayerTransform(playerID).pos, target = targetPos, delay = delay, timer = 0 }

    -- prevent/sanitize teleport delay so people can't mess with it using registry? :3 no.
    -- 10 minute teleport sounds really funny and I will allow it.
end

-- potential issue: do I.. clear the teleport target if someone disconnects..
-- will the next person that joins just teleport there.. can someone even join in the middle of a game?
server_ToolsTeleport = function(playerID, dt)

    local entry = playersTeleportTargets[playerID]
    if entry == nil then return end

    entry.timer = entry.timer + dt
    local prog = math.min(entry.timer / entry.delay, 1)

    -- teleport directly to target.
    if prog >= 1 then 
        local t = GetPlayerTransformWithPitch(playerID)
        t.pos = entry.target
        SetPlayerTransformWithPitch(t, playerID)
        playersTeleportTargets[playerID] = nil
        return
    end

    -- smooth it.
    local cos = (1 - math.cos(prog * math.pi))/2
    local t = GetPlayerTransformWithPitch(playerID)
    
    for i=1, 3 do
        t.pos[i] = entry.startPos[i] + (entry.target[i] - entry.startPos[i]) * cos
    end
    
    SetPlayerTransformWithPitch(t, playerID)
end