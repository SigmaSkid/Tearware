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

    local playerlist = GetAllPlayers()
    local thisTick = insaneObjectCache[#insaneObjectCache]
    for i=1, #thisTick do 
        local thisBody = thisTick[i]
        if IsHandleValid(thisBody.handle) then 
            SetBodyTransform(thisBody.handle, thisBody.trans)
            SetBodyActive(thisBody.handle, false) 

            if isSessionMultiplayer then 
                for i=1, #playerlist do 
                    ClientCall(i, "client.structureRestorerReceive", thisBody.handle, thisBody.trans)
                end
            end
        end
    end

    insaneObjectCache[#insaneObjectCache] = nil
end

client.structureRestorerReceive = function(handle, transform)
    SetBodyTransform(handle, transform)
    SetBodyActive(handle, false) 
end

tools_StructureRestorer = function()
    if not config_GetLocalFeatureState(fStructureRestorer) then
        tools_RewindAllObjectsState()
        return
    end
    tools_RecordAllObjectsState()
end