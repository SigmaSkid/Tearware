player_Godmode = function()
    local currentGodmodeState = config_AdvGetBool(fGodmode) 
    if currentGodmodeState == GetPlayerParam("godmode") then 
        return 
    end
    
    ServerCall("server.GodmodeToggle", GetLocalPlayer(), localUUID, currentGodmodeState)
end

server.GodmodeToggle = function(id, UUID, value)

    if not serverVerify(id, UUID) then return end

    SetPlayerParam("godmode", value, id)
    DebugPrint("Set godmode " .. utils_boolStr(value) .. " for " .. id .. "-" .. GetPlayerName(id))
end