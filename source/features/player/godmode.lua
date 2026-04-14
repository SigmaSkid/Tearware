player_Godmode = function()
    local currentGodmodeState = config_AdvGetBool(fGodmode) 
    if currentGodmodeState == GetPlayerParam("godmode") then 
        return 
    end
    
    ServerCall("server.GodmodeToggle", GetLocalPlayer(), currentGodmodeState)
end

server.GodmodeToggle = function(id, value)
    SetPlayerParam("godmode", value, id)
    DebugPrint("Set godmode " .. utils_boolStr(value) .. " for " .. id .. "-" .. GetPlayerName(id))
end