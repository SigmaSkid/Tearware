function UnfairPrices()
	if not AdvGetBool(fUnfairValuables) then
        RestoreValuablesValue() 
        return
    end
    IncreaseValuablesValue()
end

-- mods aren't allowed to modify the savefile? who cares?
function IncreaseValuablesValue()
    local targetMoney = 100000000
    local playerMoney = GetInt("savegame.cash")

    -- check if money overflows
    if playerMoney > 2100000000 then
        RestoreValuablesValue()
        return
    end

    if playerMoney < 0 then
        targetMoney = (playerMoney * -1) + 1000000 
        -- giv some pennies to mr poor
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

function RestoreValuablesValue()
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