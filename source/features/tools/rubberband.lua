client_ToolsRubberband = function() 
    if not config_GetLocalFeatureState(fRubberband) then
        rubberband_pos = nil

        if rubberband_transform == nil then
            return
        end

        -- we could re-use teleport, but I want to preserve transform.
        ServerCall("server.rubberbandTarget", GetLocalPlayer(), localUUID, rubberband_transform)
        rubberband_transform = nil
        return
    end

    if rubberband_transform == nil then
        rubberband_transform = GetPlayerTransformWithPitch()
        rubberband_pos = GetPlayerPos()
    end

    local color = config_GetColor(fRubberband, GetTime())

    ParticleReset()
    ParticleType("plain")
    ParticleColor(color.red, color.green, color.blue)
    SpawnParticle(rubberband_pos, Vec(0, -2, 0), 0.1)
end

-- server. 
playersRubberbandTargets = {}

server.rubberbandTarget = function(playerID, UUID, transform)

    if not serverVerify(playerID, UUID) then return end

    DebugPrint("server.rubberbandTarget " .. playerID .. "-" .. GetPlayerName(playerID))

    playersRubberbandTargets[playerID] = { target = transform }
end

server.ToolsRubberband = function(playerID, dt)

    local entry = playersRubberbandTargets[playerID]
    if entry == nil then return end
    
    SetPlayerTransformWithPitch(entry.target, playerID)
    playersRubberbandTargets[playerID] = nil
end

