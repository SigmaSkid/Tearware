world_UnfairPrices = function()
	if not config_AdvGetBool(fUnfairValuables) then
        world_RestoreValuablesValue() 
        return
    end
    world_IncreaseValuablesValue()
end

-- mods aren't allowed to modify the savefile/money directly.
world_IncreaseValuablesValue = function()
    local targetMoney = 100000000
    local playerMoney = GetInt("savegame.cash")

    -- check if money overflows
    if playerMoney > 2100000000 then
        world_RestoreValuablesValue()
        return
    end

    if playerMoney < 0 then
        targetMoney = (playerMoney * -1) + 1000000 
    end

    local v = FindBodies("valuable", true)
    for i = 1, #v do
        local body = v[i]
        if IsHandleValid(body) and GetPlayerInteractBody() ~= body and
            not IsBodyBroken(body) then
            local value = tonumber(GetTagValue(body, "value"))
            if value ~= targetMoney then
                table.insert(valuablesBackup, {body, value})
                SetTag(body, "value", targetMoney)
            end
        end
    end
end

world_RestoreValuablesValue = function()
    if #valuablesBackup > 0 then
        -- DebugPrint("restoring value!" .. #valuablesBackup)
        for i = 1, #valuablesBackup do
            local v = valuablesBackup[i]
            if IsHandleValid(v[1]) then
                SetTag(v[1], "value", v[2])
            end
        end
        valuablesBackup = {}
    end
end