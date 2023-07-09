world_Timer = function()
    if not config_AdvGetBool(fBulletTime) then 
        if #activeBodyCache > 0 then
			activeBodyCache = {}
		end
        return 
    end

    local scale = config_GetSubFloat(fBulletTime, fBulletTimeScale)/100
    SetTimeScale(scale)

    local patch = config_GetSubBool(fBulletTime, fBulletTimePatch)
    if not patch then 
        return 
    end

    -- prevent the engine from freezing the objects.
	local bodies = FindBodies(nil,true)
	for i=1,#bodies do
		local body = bodies[i]
		if IsBodyActive(body) then
            local exists = false
            for i=1, #activeBodyCache do
                local item = activeBodyCache[i]
                if body == item then
                    exists = true
                end
            end
            if not exists then
                table.insert(activeBodyCache,body)
            end
		end
	end

	if #activeBodyCache > 0 then
        for i=1, #activeBodyCache do
            local body = activeBodyCache[i]
            if not IsHandleValid(body) then 
                -- DebugPrint("trying to update a broken body! cleaning up")
                table.remove(activeBodyCache, i)
            else 
                local velLength = VecLength(GetBodyVelocity(body))
                local angLength = VecLength(GetBodyAngularVelocity(body))
                
                -- completely arbitrary numbers!
                if velLength > 0.01 or angLength > 0.01 then 
                    -- DrawBodyOutline(body, 1, 0, 0, 1)

                    SetBodyActive(body, true)
                else 
                    -- DebugPrint("removing a body that is already inactive.")
                    -- DrawBodyOutline(body, 0, 1, 0, 1)

                    SetBodyActive(body, false)
                    table.remove(activeBodyCache, i)
                end
            end
        end
	end

    -- DebugPrint(#activeBodyCache)
end