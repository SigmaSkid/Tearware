server.toolsFireBrush = function(playerID)
    local e = syncedPlayerSetting[playerID]
    if not e then 
        return 
    end

    local enabled = server.getPlayerConfigValue(playerID, config_getKey(fFireBrush))
    if not enabled then 
        return
    end

    local TargetPos = utils_GetPosWeAreLookingAt(playerID)
    if TargetPos ~= nil then 
        SpawnFire(TargetPos)
        PointLight(TargetPos, 0.7, 0.2, 0.2, 1)
    end
end