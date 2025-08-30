world_CacheValuables = function()
    if #cachedValuablesPositions == 0 then
        local v = FindBodies("valuable", true)
        for i = 1, #v do
            local body = v[i]
            if IsHandleValid(body) and not IsBodyBroken(body) then
                local transform = GetBodyTransform(body)
                local isActive = IsBodyActive(body)
                table.insert(cachedValuablesPositions,
                             {body, transform, isActive})
            end
        end
    end
end

world_RestoreValuablesPosition = function()
    if #cachedValuablesPositions > 0 then
        for i = 1, #cachedValuablesPositions do
            local v = cachedValuablesPositions[i]
            if IsHandleValid(v[1]) then
                SetBodyTransform(v[1], v[2])
                SetBodyActive(v[1], v[3])
                -- can't be bothered with restoring joints.
            end
        end
        cachedValuablesPositions = {}
    end
end

world_CollectValuables = function() 
    if not config_AdvGetBool(fTeleportValuables) then
        world_RestoreValuablesPosition() 
        return
    end

    world_CacheValuables()

    local camera = GetCameraTransform()
    local v = FindBodies("valuable", true)

    if #v == 0 then
        return
    end

    -- get angle delta between objects 
    local angled = (2 * math.pi) / #v
    -- offset objects away from /circleCenter/ 
    local radius = 2 / angled

    -- get the spinning valuables close to our camera by offseting the circle 
    local parentpoint = TransformToParentPoint(camera, Vec(0, 0, 1))
    local direction = VecNormalize(VecSub(camera.pos, parentpoint))
    local vector = VecScale(direction, (-radius) + 2)

    -- offset circle down, so it looks nicer
    vector[2] = -0.3
    local circleCenter = VecAdd(camera.pos, vector)

    -- spin the circle around using time
    local spinAngle = GetTime() / 10

    for i = 1, #v do
        local body = v[i]
        if IsHandleValid(body) and not IsBodyBroken(body) then

            if IsBodyJointedToStatic(body) then
                local shapes = GetBodyShapes(body)
                for i = 1, #shapes do
                    local shape = shapes[i]
                    local joints = GetShapeJoints(shape)
                    for i = 1, #joints do
                        local joint = joints[i]
                        DetachJointFromShape(joint, shape)
                    end
                end
            end

            local angle = (i - 1 + spinAngle) * angled
            local x = radius * math.cos(angle)
            local z = radius * math.sin(angle)

            local funny = {}
            funny.pos = VecCopy(circleCenter)
            funny.pos = VecAdd(funny.pos, {x, 0, z})

            funny.rot = GetBodyTransform(body).rot
            SetBodyTransform(body, funny)
            SetBodyActive(body, false)
        end
    end
end