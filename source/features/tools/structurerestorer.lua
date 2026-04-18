tools_RecordAllObjectsState = function()
    local allBodies = {}

    local bodies = FindBodies(nil,true)
	for i=1,#bodies do 
        local thisBody = bodies[i]
        if IsBodyDynamic(thisBody) and IsBodyActive(thisBody) then 
            local data = {}
            data.trans = GetBodyTransform(thisBody)
            data.handle = thisBody
            data.velocity = GetBodyVelocity(thisBody)
            allBodies[#allBodies+1] = data
        end
    end

    insaneObjectCache[#insaneObjectCache+1] = allBodies
end

tools_RewindAllObjectsState = function()
    if #insaneObjectCache == 0 then 
        return 
    end

    local thisTick = insaneObjectCache[#insaneObjectCache]
    for i=1, #thisTick do 
        local thisBody = thisTick[i]
        if IsHandleValid(thisBody.handle) then 
            SetBodyTransform(thisBody.handle, thisBody.trans)
            SetBodyVelocity(thisBody.handle, VecScale(thisBody.velocity, -1.0))
            SetBodyActive(thisBody.handle, VecLength(thisBody.velocity) > 1.0)
        end
    end

    insaneObjectCache[#insaneObjectCache] = nil
end

tools_StructureRestorer = function()
    if not config_AdvGetBool(fStructureRestorer) then
        tools_RewindAllObjectsState()
        return
    end
    tools_RecordAllObjectsState()
end