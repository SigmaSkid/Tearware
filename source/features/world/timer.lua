world_Timer = function()
    if not config_GetLocalFeatureState(fBulletTime) then 
        if #activeBodyCache > 0 then
			activeBodyCache = {}
		end
        return 
    end

    local scale = config_GetSubVar(GetFloat,fBulletTime, fSubScale)/100
    SetTimeScale(scale)
end