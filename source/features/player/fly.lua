player.Fly = function(dt)
    if not config.AdvGetBool(fFly) then 
        return 
    end

    SetPlayerVelocity(Vec(0, 0, 0))

    local TargetVel = config.GetSubFloat(fFly, fSubSpeed)
    if utils.TWInputDown("shift") then 
        TargetVel = config.GetSubFloat(fFly, fSubBoost)
    end

    local velocity = Vec(0,0,0)
    if utils.IsDirectionalInputDown() then
        velocity = GetPlayerVelocity()

        -- scary math below, run.

        -- get scary quat
        local rot = GetCameraTransform().rot
        -- convert to cool angles
        local x, backupy, z = GetQuatEuler(rot)
        local y = utils.TransformYawByInput(backupy)

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
    end
    
    -- counteract gravity, gravity is evil
    -- this breaks at higher fps.
    local ohno = 864 * dt * dt
    
    if utils.TWInputDown("jump") then 
        ohno = TargetVel
    end 
    
    if utils.TWInputDown("crouch") then 
        ohno = ohno - TargetVel
    end

    velocity[2] = ohno

    SetPlayerVelocity(velocity)
end