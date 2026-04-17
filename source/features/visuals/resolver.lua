-- yes, we're just pretending. The server just sends us config data.

-- client
resolverData = {}

client_applyResolver = function()
    -- no need to resolve for host. host knows the facts.
    if isLocalPlayerTheHost then return end
    
    if not config_AdvGetBool(fResolver) then return end

    local players = GetAllPlayers()
    for id=1, #players do
        if IsPlayerValid(id) then 
            shared_applyAntiAim(id, resolverData[id])
        end
    end
end

-- server
client.receiveResolverData = function(playerID, data)
    resolverData[playerID] = data
end

server.forwardResolverData = function(playerID, UUID, data)
    if not serverVerify(playerID, UUID) then 
        serverImpolitelyReject(playerID, setting)
        return 
    end

    -- sent current AA settings to everyone.
    local players = GetAllPlayers()
    for id=1, #players do
        ClientCall(id, "client.receiveResolverData", playerID, data)
    end
end