local lastgodmodeState = false
player_Godmode = function()
    local godmodeEnabled = config_AdvGetBool(fGodmode) 
    
    if godmodeEnabled == lastgodmodeState then 
        return 
    end

    lastgodmodeState = currentGodmodeState

    ServerCall("server.GodmodeToggle", GetLocalPlayer(), localUUID, currentGodmodeState)
end

server.GodmodeToggle = function(id, UUID, value)

    if not serverVerify(id, UUID) then return end

    SetPlayerParam("godmode", value, id)
    DebugPrint("Set godmode " .. utils_boolStr(value) .. " for " .. id .. "-" .. GetPlayerName(id))
end