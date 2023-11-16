world_Timer = function()
    if not config_AdvGetBool(fBulletTime) then 
        if #activeBodyCache > 0 then
			activeBodyCache = {}
		end
        return 
    end

    local scale = config_GetSubFloat(fBulletTime, fSubScale)/100
    SetTimeScale(scale)
end