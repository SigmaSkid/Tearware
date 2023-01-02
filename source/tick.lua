-- tearware on top

-- called once per frame (dt is a dynamic float value between 0 and .0(3), 60fps = 0.1(6) )
function tick(dt) 
    if PauseMenuButton("Tearware") then
		isMenuOpen = true
	end

    if InputPressed("insert") then
        isMenuOpen = not isMenuOpen
    end

    -- delta time scaled, .5 = 120fps, 1 = 60fps, 2 = 30fps
    local dts = dt / fixed_update_rate

    -- universal features
    Timer()
    ForceUpdateAllBodies()
    DisablePhysics()

    if GetPlayerVehicle() ~= 0 then
        -- in vehicle
        return
    end

    -- strict
    Spider() 
    Speedhack()
    Jesus()
    Floorstrafe()
    Jetpack(dts)
    Fly()
    NoClip(dts)
    Teleport()
    ExplosionBrush()
    FireBrush()
    Quickstop()
end

activeBodyCache = {}
function Timer()
    if not AdvGetBool(cfgstr .. "timer") then 
        if #activeBodyCache > 0 then
			activeBodyCache = {}
		end
        return 
    end
    -- Call every frame from tick function to get steady slow-motion. 
    SetTimeScale(0.1) -- 0.1 is the minimum, cringe

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
                if velLength > 0.3 or angLength > 0.15 then 
                    -- DrawBodyOutline(body, 1, 0, 0, 1)

                    ApplyBodyImpulse(body,GetBodyTransform(body).pos,Vec(0,0,0))
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

function ForceUpdateAllBodies()
    if not AdvGetBool(cfgstr .. "forceupdatephysics") then
        return 
    end

    local bodies = FindBodies(nil,true)
    for i=1,#bodies do
        SetBodyActive(bodies[i], true)
    end
end

function DisablePhysics()
    if not AdvGetBool(cfgstr .. "disablephysics") then
        return 
    end

	local bodies = FindBodies(nil,true)
    for i=1,#bodies do
        SetBodyActive(bodies[i], false)
    end
end

function Spider() 
    if not AdvGetBool(cfgstr .. "spider") then 
        return 
    end

    local hit = QueryRaycast(GetPlayerPos(), Vec(0, -1, 0), 0.1, 0.7)

    if not hit or not InputDown("jump") then 
        return 
    end

    local vel = GetPlayerVelocity()
    vel[2] = 4
    SetPlayerVelocity(vel)
end

function Speedhack()
    if not AdvGetBool(cfgstr .. "speedhack") then 
        return 
    end

    if not IsDirectionalInputDown() then
        return 
    end 

    local velocity = GetPlayerVelocity()

    local TargetVel = 14
    if InputDown("shift") then 
        TargetVel = 28 
    end

    -- scary math below, run.

    -- get scary quat
    local rot = GetCameraTransform().rot
    -- convert to cool angles
    local x, backupy, z = GetQuatEuler(rot)
    local y = TransformYawByInput(backupy)

    -- euler to vector
    local rady = math.rad(y)
	local siny = math.sin(rady)
	local cosy = math.cos(rady)

    -- change our cool math to something the game can use
    local forward = Vec(0,0,0)
    forward[3] = -cosy
    forward[1] = -siny

    -- apply velocity scale
    velocity = VecScale(forward, TargetVel)

    -- make sure we didn't mess up on the axis we don't care about
    velocity[2] = GetPlayerVelocity()[2]

    SetPlayerVelocity(velocity)

end

function Jesus()
	if not AdvGetBool(cfgstr .. "jesus") then
        return
    end
    local transform = GetPlayerTransform()
    local inWater, depth = IsPointInWater(transform.pos)

    if not inWater then 
        return 
    end

    local velocity = GetPlayerVelocity()
    
    if InputDown("jump") then 
        velocity[2] = 5
    elseif depth > 0.1 then 
        velocity[2] = 6
    else
        velocity[2] = depth*20
    end

    SetPlayerVelocity(velocity)
end

function Floorstrafe() 
    if not AdvGetBool(cfgstr .. "floorstrafe") then 
        return 
    end

    local velocity = GetPlayerVelocity()

    velocity[2] = 1

    SetPlayerGroundVelocity(velocity)

end

function Jetpack(dts) 
    if not AdvGetBool(cfgstr .. "jetpack") then 
        return 
    end

    if InputDown("jump") then 
        local velocity = GetPlayerVelocity()

        velocity[2] = velocity[2] + (0.5 * dts)
        if velocity[2] > 7 then 
            velocity[2] = 7 
        end

        SetPlayerVelocity(velocity) 
    end

end

function Fly()
    if not AdvGetBool(cfgstr .. "fly") then 
        return 
    end

    SetPlayerVelocity(Vec(0, 0, 0))

    local TargetVel = 20
    if InputDown("shift") then 
        TargetVel = 40 
    end

    if not IsDirectionalInputDown() then

        local ohno = 0
        if InputDown("jump") then 
            ohno = TargetVel
        end 
        
        if InputDown("crouch") then 
            ohno = ohno -TargetVel
        end
    
        SetPlayerVelocity(Vec(0, ohno, 0))

        return 
    end 

    local velocity = GetPlayerVelocity()

    -- scary math below, run.

    -- get scary quat
    local rot = GetCameraTransform().rot
    -- convert to cool angles
    local x, backupy, z = GetQuatEuler(rot)
    local y = TransformYawByInput(backupy)

    -- euler to vector
    local rady = math.rad(y)
	local siny = math.sin(rady)
	local cosy = math.cos(rady)

    -- change our cool math to something the game can use
    local forward = Vec(0,0,0)
    forward[3] = -cosy
    forward[1] = -siny

    -- apply velocity scale
    velocity = VecScale(forward, TargetVel)

        
    local ohno = 0
    if InputDown("jump") then 
        ohno = TargetVel
    end 
    
    if InputDown("crouch") then 
        ohno = ohno - TargetVel
    end

    velocity[2] = ohno

    SetPlayerVelocity(velocity)
end

function NoClip(dts)
    if not AdvGetBool(cfgstr .. "noclip") then
        noclipbackuppos = nil
        return 
    end

    local trans = GetPlayerTransform(true)

    -- teleport/edge of map/respawn detection
    local delta = VecLength( VecSub(noclipbackuppos, trans.pos) )

    if delta > 1 or noclipbackuppos == nil then 
        noclipbackuppos = trans.pos
    end
    
    trans.pos = noclipbackuppos

    local speed = 0.1
    if InputDown("shift") then 
        speed = 0.9
    end

    -- scale by update rate
    speed = speed * dts

    if IsDirectionalInputDown() then

        local x, y, z = GetQuatEuler(trans.rot) 
        local dir = TransformYawByInput(y)

        trans.rot = QuatEuler(x, dir, z)

        local parentpoint = TransformToParentPoint(trans, Vec(0, 0, -1))

        trans.rot = QuatEuler(x, y, z)
        
        local direction = VecScale(VecNormalize(VecSub(parentpoint, trans.pos)), speed)

        trans.pos[1] = trans.pos[1] + direction[1]
        trans.pos[3] = trans.pos[3] + direction[3]
    end 
    
    if InputDown("jump") then
        trans.pos[2] = trans.pos[2] + speed
    end 

    if InputDown("crouch") then
        trans.pos[2] = trans.pos[2] - speed
    end 

    SetPlayerTransform(trans, true)
end

function Teleport() 
    if not AdvGetBool(cfgstr .. "teleport") then 
        return 
    end
    
    local TargetPos = GetPosWeAreLookingAt()
    if TargetPos ~= nil then 
        local t = Transform(TargetPos, GetCameraTransform().rot)
        
        SetPlayerTransform(t, true)
    end
    SetBool(cfgstr .. "teleport", false)
end

function ExplosionBrush() 
    if not AdvGetBool(cfgstr .. "explosionbrush") then 
        return 
    end
    
    local TargetPos = GetPosWeAreLookingAt()
    if TargetPos ~= nil then 
        Explosion(TargetPos, 1)
    end
end

function FireBrush() 
    if not AdvGetBool(cfgstr .. "firebrush") then 
        return 
    end
    
    local TargetPos = GetPosWeAreLookingAt()
    if TargetPos ~= nil then 
        SpawnFire(TargetPos)
        PointLight(TargetPos, 0.7, 0.2, 0.2, 1)
    end
end

function Quickstop() 
    if not AdvGetBool(cfgstr .. "quickstop") then 
        return 
    end

    if IsDirectionalInputDown() then
        return 
    end

    local velocity = {0, 0, 0}
    velocity[2] = GetPlayerVelocity()[2]
    SetPlayerVelocity(velocity) 
end
