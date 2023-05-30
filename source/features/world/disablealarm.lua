function DisableAlarm()
	if not AdvGetBool(fDisableAlarm) then
        return
    end

    local onlyModifyTimer = false

    if GetString("game.levelid") == "carib_alarm" then
        onlyModifyTimer = true

    end

    if GetFloat("level.alarmtimer") < 780 and GetBool("level.alarm") then
        SetFloat("level.alarmtimer", 817)
        if not onlyModifyTimer then
            SetBool("level.alarm", false)
        end
    end

    if not onlyModifyTimer then
        SetBool("level.alarmdisabled", true)
    end
end