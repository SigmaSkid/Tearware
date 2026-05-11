world_DisableAlarm = function()
    if not isSessionCampagin then return end
    
	if not config_GetLocalFeatureState(fDisableAlarm) then
        return
    end

    local onlyModifyTimer = false

    if GetString("game.levelid") == "carib_alarm" or GetFireCount() >= 100 then
        onlyModifyTimer = true
    end

    if GetFloat("level.alarmtimer") < 817 and GetBool("level.alarm") then
        SetFloat("level.alarmtimer", 817, true)
        if not onlyModifyTimer then
            SetBool("level.alarm", false, true)
        end
    end

    if not onlyModifyTimer then
        SetBool("level.alarmdisabled", true, true)
    end
end