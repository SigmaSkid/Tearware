server.toolsExplosionBrush = function(playerID)
    local e = syncedPlayerSetting[playerID]
    if not e then 
        return 
    end

    local enabled = server.getPlayerConfigValue(playerID, config_getKey(fExplosionBrush))
    if not enabled then 
        return
    end

    local Size = server.getPlayerConfigValue(playerID, config_getSubKey(fExplosionBrush, fSubSize))
    local TargetPos = utils_GetPosWeAreLookingAt(playerID)
    if TargetPos ~= nil then 
        
        Explosion(TargetPos, Size)
    end
end