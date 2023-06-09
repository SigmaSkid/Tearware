player.Fly = function()
    if not config.AdvGetBool(fFly) then 
        return 
    end

    SetPlayerVelocity(Vec(0, 0, 0))

    local TargetVel = config.GetSubFloat(fFly, fSubSpeed)
    if utils.TWInputDown("shift") then 
        TargetVel = config.GetSubFloat(fFly, fSubBoost)
    end

    if not utils.IsDirectionalInputDown() then

        local ohno = 0
        if utils.TWInputDown("jump") then 
            ohno = TargetVel
        end 
        
        if utils.TWInputDown("crouch") then 
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

        
    local ohno = 0
    if utils.TWInputDown("jump") then 
        ohno = TargetVel
    end 
    
    if utils.TWInputDown("crouch") then 
        ohno = ohno - TargetVel
    end

    velocity[2] = ohno

    SetPlayerVelocity(velocity)
end