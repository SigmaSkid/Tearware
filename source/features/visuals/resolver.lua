-- yes, we're just pretending. The server just sends us config data.

-- client
resolverData = {}
justEnabledResolver = true

client_applyResolver = function()
    -- no need to resolve for host. host knows the facts.
    if isLocalPlayerTheHost then return end
    
    if not config_GetLocalFeatureState(fResolver) then 
        justEnabledResolver = true
        return 
    end

    local players = GetAllPlayers()
    for id=1, #players do
        if IsPlayerValid(id) then 
            shared_applyAntiAim(id, resolverData[id])
        end
    end

    -- ask for up to date resolver data.
    if justEnabledResolver and GetTime() > 10 then 
        justEnabledResolver = false
        for id=1, #players do
            if IsPlayerValid(id) then 
                ServerCall("server.forwardResolverData", i)
            end
        end
    end
end

-- server
client.receiveResolverData = function(playerID, data)
    resolverData[playerID] = data
end

server.forwardResolverData = function(playerID)
    local data = 
    {
        yaw_mode    = server.getPlayerConfigValue(playerID, config_getSubKey(fAntiAim, fAntiAimYawModes)),
        yaw_offset   = server.getPlayerConfigValue(playerID, config_getSubKey(fAntiAim, fSubYawOffset)),
        yaw_speed    = server.getPlayerConfigValue(playerID, config_getSubKey(fAntiAim, fSubYawSpeed)),
        yaw_amp      = server.getPlayerConfigValue(playerID, config_getSubKey(fAntiAim, fSubYawAmp)),

        pitch_mode   = server.getPlayerConfigValue(playerID, config_getSubKey(fAntiAim, fAntiAimPitchModes)),
        pitch_offset = server.getPlayerConfigValue(playerID, config_getSubKey(fAntiAim, fSubPitchOffset)),
        pitch_speed  = server.getPlayerConfigValue(playerID, config_getSubKey(fAntiAim, fSubPitchSpeed)),
        pitch_amp    = server.getPlayerConfigValue(playerID, config_getSubKey(fAntiAim, fSubPitchAmp))
    }

    DebugPrint("[server] forwardResolverData: " .. playerID)

    -- sent current AA settings to everyone.
    local players = GetAllPlayers()
    for id=1, #players do
        ClientCall(id, "client.receiveResolverData", playerID, data)
    end
end