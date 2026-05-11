server.playerInfiniteAmmo = function(playerID)
    local e = syncedPlayerSetting[playerID]
    if not e then 
        return 
    end

    local enabled = server.getPlayerConfigValue(playerID, config_getKey(fInfiniteAmmo))
    if not enabled then 
        return
    end

    local tool = GetPlayerTool(playerID)
    local curAmmo = GetToolAmmo(tool, playerID)

    if curAmmo < 9999 then 
        SetToolAmmo(tool, 9999, playerID)
    end
end