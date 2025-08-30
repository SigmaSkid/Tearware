-- todo: account for where we grabbed the object (instead of using body center)
player_SuperStrength = function()
    if not config_AdvGetBool(fSuperStrength) then 
        return 
    end

    -- replace engine grab functionality.
    ReleasePlayerGrab()

    if not utils_TWInputDown("rmb") then 
        ss_object.obj = nil
        if ss_last_tool ~= nil then 
            SetString("game.player.tool", ss_last_tool)
            ss_last_tool = nil
        end
        return
    end

    if utils_TWInputPressed("rmb") then 
        local object, dist = utils_GetObjectWeAreLookingAt()
        ss_last_tool = GetString("game.player.tool")

        if ss_object.obj == nil then 
            if object ~= nil then 
                ss_object.obj = object 
                ss_object.dist = dist
            else 
                return 
            end
        end
    end

    if not IsHandleValid(ss_object.obj) then 
        ss_object.obj = nil
        return
    end

    if not IsBodyDynamic(ss_object.obj) then 
        ss_object.obj = nil
        return
    end

    SetString("game.player.tool", "tearware_prop")
    SetInt("game.tool.tearware_prop.ammo", 9999)
    SetBool("game.player_grabbing", true)

    if utils_TWInputDown("lmb") then 
        -- LAUNCH!
        if ss_object.obj ~= nil then 
            local dir = utils_GetForwardDirection()
            local velocity = GetBodyVelocity(ss_object.obj)
            
            velocity = VecAdd(velocity, VecScale(dir, 50))

            SetBodyVelocity(ss_object.obj, velocity)
            ss_object.obj = nil
            SetString("game.player.tool", ss_last_tool)
        end
        return
    end

    local scrollPos = InputValue("mousewheel")
    if scrollPos ~= 0 then 
        if utils_TWInputDown("shift") then 
            scrollPos = scrollPos * 5
        end
        ss_object.dist = ss_object.dist + scrollPos
    end

    DrawBodyOutline(ss_object.obj, 1, 1, 1, 1)

    local direction, camera = utils_GetForwardDirection()
    local targetLocation = VecAdd(camera.pos, VecScale(direction, ss_object.dist))
    
    -- local objTransform = GetBodyTransform(ss_object.obj)
    -- objTransform.pos = targetLocation
    -- SetBodyTransform(ss_object.obj, objTransform)
    -- SetBodyActive(ss_object.obj, false)

    local vel = VecSub(targetLocation, utils_GetBodyCenter(ss_object.obj))
    vel = VecScale(vel, VecLength(vel))
    SetBodyVelocity(ss_object.obj, vel)

    -- angular velocity is cringe
    SetBodyAngularVelocity( {0,0,0} )
end