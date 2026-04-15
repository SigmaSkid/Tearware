client_playerFly = function()
    local currentFlyState = config_AdvGetBool(fFly) 
    if currentFlyState == GetPlayerParam("flymode") then 
        return 
    end
    
    ServerCall("server.FlyToggle", GetLocalPlayer(), localUUID, currentFlyState)
end

server.FlyToggle = function(id, UUID, value)
    
    if not serverVerify(id, UUID) then return end

    SetPlayerParam("flymode", value, id)
    DebugPrint("Set flymode " .. utils_boolStr(value) .. " for " .. id .. "-" .. GetPlayerName(id))
end