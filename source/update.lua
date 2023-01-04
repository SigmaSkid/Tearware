-- tearware on top

-- Called once every fixed tick, 60tps (dt is a constant)
function update(dt)

    InfiniteAmmo()
    UnfairPrices()
    CollectValuables() 
    Rubberband()

    Disablealarm()
    Godmode()
    
    SkipObjective()
end

function InfiniteAmmo() 
    if not AdvGetBool(fInfiniteAmmo) then 
        return 
    end

    -- already has inf ammo / return to prevent visual glitches 
    if GetBool("level.unlimitedammo") then 
        return 
    end
    
    local pTool = GetString("game.player.tool")
    local Ammo = GetInt("savegame.tool."..pTool..".ammo")
    if Ammo == nil or Ammo == 0 then 
        -- seems like the engine really likes 9999
        Ammo = 9999
    end
    SetInt("game.tool."..pTool..".ammo", Ammo)
end

function UnfairPrices()
	if not AdvGetBool(fUnfairValuables) then
        RestoreValuablesValue() 
        return
    end
    IncreaseValuablesValue() 
end

--mods aren't allowed to modify the savefile? who cares?
valuablesBackup = {}
function IncreaseValuablesValue() 
    local targetmoney = 1000000 

    local v = FindBodies("valuable", true)
    for i=1,#v do
        local body = v[i]
        if IsHandleValid(body) and GetPlayerInteractBody() ~= body and not IsBodyBroken(body) then
            local value = tonumber(GetTagValue(body, "value"))
            if value ~= targetmoney then 
                table.insert(valuablesBackup, {body, value})
                SetTag(body, "value", targetmoney)
            end
        end
    end
end

function RestoreValuablesValue() 
    if #valuablesBackup > 0 then 
        --DebugPrint("restoring value!" .. #valuablesBackup)
        for i=1,#valuablesBackup do
            local v = valuablesBackup[i]
            if IsHandleValid(v[1]) then 
                SetTag(v[1], "value", v[2])
            end
        end
        valuablesBackup = {}
    end
end

cachedValuablesPositions = {}
function CacheValuables() 
    if #cachedValuablesPositions == 0 then 
        local v = FindBodies("valuable", true)
        for i=1,#v do
            local body = v[i]
            if IsHandleValid(body) and not IsBodyBroken(body) then
                local transform = GetBodyTransform(body)
                local isActive = IsBodyActive(body)
                table.insert(cachedValuablesPositions, {body, transform, isActive})
            end
        end
    end
end

function RestoreValuablesPosition() 
    if #cachedValuablesPositions > 0 then 
        for i=1,#cachedValuablesPositions do
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

function CollectValuables() 
    if not AdvGetBool(fTeleportValuables) then
        RestoreValuablesPosition() 
        return
    end

    CacheValuables() 

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
    local vector = VecScale(direction, (-radius) + 3)

    -- offset circle down, so it looks nicer
    vector[2] = -0.3
    local circleCenter = VecAdd(camera.pos, vector)

    -- spin the circle around using time
    local spinAngle = GetTime() / 10
    
    for i=1,#v do
        local body = v[i]
        if IsHandleValid(body) and not IsBodyBroken(body) then

            if IsBodyJointedToStatic(body) then
                local shapes = GetBodyShapes(body)
                for i=1,#shapes do
                    local shape = shapes[i]
                    local joints = GetShapeJoints(shape)
                    for i=1, #joints do
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
            funny.pos = VecAdd(funny.pos, {x, 0, z} )

            funny.rot = GetBodyTransform(body).rot
            SetBodyTransform(body, funny)
            SetBodyActive(body, false)
        end
    end
end

function Rubberband() 
    
    if not AdvGetBool(fRubberband) then
        rubberband_pos = nil

        if rubberband_transform == nil then 
            return
        end

        SetPlayerTransform(rubberband_transform, true)
        rubberband_transform = nil 
        return
    end

    if rubberband_transform == nil then 
        rubberband_transform = GetPlayerTransform(true)
        rubberband_pos = GetPlayerPos()
    end 

    ParticleReset()
    ParticleType("plain")
    ParticleColor(1.0, 0.3, 1.0)
    SpawnParticle(rubberband_pos, Vec(0, -2, 0), 0.1)
end

function Disablealarm()
	if not AdvGetBool(fDisableAlarm) then
        return
    end

    local onlyModifyTimer = false 

    if GetString("game.levelid") == "carib_alarm" then 
        onlyModifyTimer = true
    end

    if GetFloat("level.alarmtimer") < 780 and GetBool("level.alarm") then 
        SetFloat("level.alarmtimer", 817)
        if not onlyModifyTimer then 
            SetBool("level.alarm", false) 
        end 
    end

    if not onlyModifyTimer then 
        SetBool("level.alarmdisabled", true)
    end
end

function Godmode() 
    if not AdvGetBool(fGodmode) then
        return 
    end
	
    if GetPlayerHealth() then
        SetPlayerHealth(1)
    end
end

function SkipObjective()
    if not AdvGetBool(fSkipObjective) then
        return
    end

    if skipped_objective then 
        return
    end 

    skipped_objective = true

	local targets = FindBodies("target", true)

	for i=1, #targets do
        SetTag(targets[i], "target", "cleared")
	end

    -- SetString("level.state", "win") 
end