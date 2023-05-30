
-- the game.. might have problems trying to clear this up after us..
-- don't restart with anything in this cache lol
function RecordAllObjectsState()
    local allBodies = {}

    local bodies = FindBodies(nil,true)
	for i=1,#bodies do 
        local thisBody = bodies[i]
        if IsBodyDynamic(thisBody) then 
            local data = {}
            data.trans = GetBodyTransform(thisBody)
            data.handle = thisBody
            allBodies[#allBodies+1] = data
        end
    end

    insaneObjectCache[#insaneObjectCache+1] = allBodies
end

function RewindAllObjectsState()
    if #insaneObjectCache == 0 then 
        return 
    end

    local thisTick = insaneObjectCache[#insaneObjectCache]
    for i=1, #thisTick do 
        local thisBody = thisTick[i]
        if IsHandleValid(thisBody.handle) then 
            SetBodyTransform(thisBody.handle, thisBody.trans)
            -- performance > quality
            -- breaks wheels of cars, ropes, and other joints
            -- but at least we have more than 5 fps, because we don't simulate 5k objects
            SetBodyActive(thisBody.handle, false)
        end
    end

    insaneObjectCache[#insaneObjectCache] = nil
end

function StructureRestorer()
    if not AdvGetBool(fStructureRestorer) then
        RewindAllObjectsState()
        return
    end
    RecordAllObjectsState()
end