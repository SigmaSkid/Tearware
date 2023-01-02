-- I hate lua, let's switch to c++ 

-- dirty global variable that we all hate.
-- shame on you global variable!
isMenuOpen = false

cfgstr = "savegame.mod.tearware_"

featurelist = {}

-- universal constants
fixed_update_rate = 1/60 -- 0.01(6)
origin_to_eye_distance = 1.7

function DefineBool(name, var, default) 
    local feature = {}
    feature.name = name 
    feature.var = var
    featurelist[#featurelist+1] = feature

    if HasKey(cfgstr .. var) and HasKey(cfgstr .. var .. "_key") then 
        return 
    end
    SetBool(cfgstr .. var, default)
    SetString(cfgstr .. var .. "_key", "null")
end

function DefineTool(var) 
    if HasKey(cfgstr .. var) and HasKey(cfgstr .. var .. "_key") then 
        return 
    end
    SetBool(cfgstr .. var, false)
    SetString(cfgstr .. var .. "_key", "null")
end

function DefineInt(var, default) 
    if HasKey(cfgstr .. var) then 
        return 
    end
    SetInt(cfgstr .. var, default)
end

function AdvGetBool(var)
    if not HasKey(var .. "_key") then 
        return GetBool(var)
    end

    local key = GetString(var .. "_key")
    if key == "null" or key == "" or key == nil then 
        return GetBool(var)
    end

    if InputPressed(key) then 
        SetBool(var, not GetBool(var))
    end
    
    return GetBool(var) 
end

-- dll main, but more gay
function init()
    -- weapons/aim/triggerbot idk?
    DefineBool("Infinite Ammo", "infiniteammo", false)
    
    -- visuals
    DefineBool("Visuals", "visuals", true)
    DefineBool("Watermark", "watermark", true)
    DefineBool("Feature List", "featurelist", false)
    DefineBool("Objective ESP", "objectiveesp", false)
    DefineBool("Valuable ESP", "valueesp", false)
    DefineBool("Tool ESP", "toolesp", false)
    DefineBool("Weapon Glow", "weaponglow", false)
    DefineBool("Active Glow", "activeglow", false)
    
    -- movement
    DefineBool("Speed", "speedhack", false)
    DefineBool("Spider", "spider", false)
    DefineBool("Fly", "fly", false)
    DefineBool("Noclip", "noclip", false)
    DefineBool("Floor Strafe", "floorstrafe", false)
    DefineBool("Jetpack", "jetpack", false)
    DefineBool("Jesus", "jesus", false)
    DefineBool("Quickstop", "quickstop", false)
    
    -- misc
    DefineBool("Godmode", "godmode", false)
    DefineBool("Bullet Time", "timer", false)
    DefineBool("Skip Objective", "skipobjective", false)
    DefineBool("Disable Alarm", "disablealarm", false)
    DefineBool("Disable Physics", "disablephysics", false)
    DefineBool("Force Update Physics", "forceupdatephysics", false)

    -- tools
    DefineBool("Rubberband", "rubberband", false)
    DefineBool("Teleport Valuables To Player", "autocollect", false)
    DefineBool("Unfair Valuables", "inflationishittinghard", false)
    DefineTool("teleport")
    DefineBool("Explosion Brush", "explosionbrush", false)
    DefineBool("Fire Brush", "firebrush", false)
    
    -- sort for feature list.
    UiPush()
        UiFont("bold.ttf", 12)
        table.sort(featurelist, function (left, right)
            return UiGetTextSize(left.name) > UiGetTextSize(right.name)
        end)
    UiPop()
end

function TransformYawByInput(y)
    local Forward = InputDown("up") 
    local Back = InputDown("down")
    local Left = InputDown("left")
    local Right = InputDown("right")

    -- there must be a better way of doing this...
    if Forward then
        if Left then
            y = y + 45
        elseif Right then
            y = y - 45
        end
    elseif Back then 
        y = y + 180
        if Left  then
            y = y - 45
        elseif Right  then
            y = y + 45
        end
    else
        if Left then
            y = y + 90
        elseif Right then
            y = y - 90
        else 
            return 
        end
    end

    -- clamp
    while y > 180 do
        y = y - 360
    end
    while y < -180 do
        y = y + 360
    end

    return y
end

function IsDirectionalInputDown() 
    return InputDown("up") or InputDown("down") or InputDown("left") or InputDown("right")
end

function SkipObjective()
    if not AdvGetBool(cfgstr .. "skipobjective") then
        return
    end

    if HasKey("temp_" .. cfgstr .. "skipobjective") then 
        return
    end

    SetBool("temp_" .. cfgstr .. "skipobjective", true)

	local targets = FindBodies("target", true)

	for i=1, #targets do
        SetTag(targets[i], "target", "cleared")
	end

    -- SetString("level.state", "win") 
end

--mods aren't allowed to modify the savefile? who cares?

function DoStuffWithValuables()
    local autocollect = AdvGetBool(cfgstr .. "autocollect")
    local inflation = AdvGetBool(cfgstr .. "inflationishittinghard")

    if not autocollect and not inflation then
        return
    end

    local camera = GetCameraTransform()
    local v = FindBodies("valuable", true)
    for i=1,#v do
        local body = v[i]
        if body ~= nil then
            if GetPlayerInteractBody() ~= body then
                SetBodyActive(body, false)
                if not IsBodyBroken(body) then 
                    local isValuable = HasTag(body, "valuable")
                    if isValuable then  
                        if autocollect then
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

                            local newTransform = camera
                            local min, max = GetBodyBounds(body)
                            local vecdistance = VecAdd(VecSub(max, min), Vec(0.1, 0, 0))
                            newTransform.pos = VecAdd(camera.pos, vecdistance)
                            SetBodyDynamic(body, false)
                            SetBodyTransform(body, newTransform)
                            SetBodyVelocity(body, Vec(0,0,0))
                        end

                        if inflation then
                            
                            --check so that the stupid game doesnt do a stupid int overflow
                            --also leave some leeway so it doesnt happen by accident
                            --max: 2.147.483.647
                            
                            local playerMoney = GetInt("savegame.cash")
                            local targetMoney = 1000000
                            if playerMoney > 2100000000 then
                                targetMoney = 0
                                SetString("hud.notification", "[Tearware] Sadly you are too rich. Blame the game.")
                            end

                            if playerMoney < 0 then
                                targetMoney = (playerMoney * -1) + 1000000 -- giv some pennies to mr poor
                                SetString("hud.notification", "[Tearware] Money overflow detected! Pick up a valuable to fix..")
                            end
                            
                            SetTag(body, "value", targetMoney) --cash moneyy
                        end
                    end
                end
            end
        end
    end
end

function Rubberband() 
    
    if not AdvGetBool(cfgstr .. "rubberband") then
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
	if not AdvGetBool(cfgstr .. "disablealarm") then
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

function InfiniteAmmo() 
    if not AdvGetBool(cfgstr .. "infiniteammo") then 
        return 
    end

    -- already has inf ammo / return to prevent visual glitches 
    if GetBool("level.unlimitedammo") then 
        return 
    end
    
    local pTool = GetString("game.player.tool")
    local Ammo = GetInt("savegame.tool."..pTool..".ammo")
    if Ammo == nil or Ammo == 0 then 
        Ammo = 9999
    end
    SetInt("game.tool."..pTool..".ammo", Ammo)
end

function Godmode() 
    if not AdvGetBool(cfgstr .. "godmode") then
        return 
    end
	
    if GetPlayerHealth() then
        SetPlayerHealth(1)
    end
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

function DisablePhysics()
    if not AdvGetBool(cfgstr .. "disablephysics") then
        return 
    end

	local bodies = FindBodies(nil,true)
    for i=1,#bodies do
        SetBodyActive(bodies[i], false)
    end
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

function Floorstrafe() 
    if not AdvGetBool(cfgstr .. "floorstrafe") then 
        return 
    end

    local velocity = GetPlayerVelocity()

    velocity[2] = 1

    SetPlayerGroundVelocity(velocity)

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

function GetPosWeAreLookingAt()
	local camera = GetCameraTransform()

	local parentpoint = TransformToParentPoint(camera, Vec(0, 0, -666))
	
    local direction = VecNormalize(VecSub(parentpoint, camera.pos))
	
    local hit, dist = QueryRaycast(camera.pos, direction, 666)

    if hit then 
        return TransformToParentPoint(camera, Vec(0, 0, -dist))
    end

    return nil 
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

function FireBrush(dt) 
    if not AdvGetBool(cfgstr .. "firebrush") then 
        return 
    end
    
    local TargetPos = GetPosWeAreLookingAt()
    if TargetPos ~= nil then 
        SpawnFire(TargetPos)
        PointLight(TargetPos, 0.7, 0.2, 0.2, 1)
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

-- Called once every fixed tick, 60tps (dt is a constant)
function update(dt)

    InfiniteAmmo()
    DoStuffWithValuables()
    Rubberband()

    Disablealarm()
    Godmode()
    
    SkipObjective()
end

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
    FireBrush(dt)
    Quickstop()
end

filthyglobal_editingkeybind = " "
function Checkbox(name, var)
    UiPush()
    UiAlign("left top")
    
    local currentkey = GetString(cfgstr .. var .. "_key")
    local kw, kh = UiGetTextSize(" - " .. currentkey)

    local namew, nameh = UiGetTextSize(name)
    
    if UiIsMouseInRect(namew + kw, nameh) then
        UiColor(0.6, 0.6, 0.6, 1)

        if InputPressed("rmb") then 
            filthyglobal_editingkeybind = var
        end
    end

    UiTextShadow(0, 0, 0, 0.5, 1.5)
    UiTextOutline(0, 0, 0, 1, 0.1)

    -- highlight the checkbox, if this is the keybind we're editing
    if filthyglobal_editingkeybind == var then
        UiColor(1.0, 1.0, 0.6, 1)    
    elseif GetBool(cfgstr .. var) then 
        UiColor(0.6, 1.0, 0.6, 1)
    else 
        UiColor(1.0, 0.6, 0.6, 1)
    end

    if UiTextButton(name) then
        SetBool(cfgstr .. var, not GetBool(cfgstr .. var))
    end

    -- check if this is the checkbox of the keybind we're editing
    if filthyglobal_editingkeybind == var then
        local lastKey = InputLastPressedKey()
        -- if a button was pressed
        if lastKey ~= "" then 
            if lastKey == "return" or lastKey == "esc" or lastKey == "insert" then 
                -- remove keybind
                SetString(cfgstr .. var .. "_key", "null") 
                currentkey = ""  
            else
                SetString(cfgstr .. var .. "_key", lastKey)
                currentkey = lastKey
            end
            -- we're no longer editing a keybind.
            filthyglobal_editingkeybind = " " 
        end
    end

    if currentkey ~= "" and currentkey ~= "null" then 
        UiPush()
        UiTranslate(namew, 0)
        UiText(" - " .. currentkey, false)
        UiPop()
    end

    UiPop()
    UiText("", true)
end

function Button(name)
    UiPush()
    UiAlign("left top")

    UiTextShadow(0, 0, 0, 0.5, 2.0)
    
    UiColor(1.0, 0.6, 1.0, 1)
    
    if UiTextButton(name) then
        UiPop()
        UiText("", true)
        return true
    end
    UiPop()
    UiText("", true)
    return false
end

function seedToRGB(y)
    local rgb = {} 
    
    rgb.R = math.sin(y + 0) * 0.5 + 0.5;
    rgb.G = math.sin(y + 2) * 0.5 + 0.5;
    rgb.B = math.sin(y + 4) * 0.5 + 0.5;

    return rgb 
end

function NavButton(name, tabid)
    UiPush()
        UiTranslate(50 + (tabid * 100), -20)
        UiFont("bold.ttf", 120)
        UiTextOutline(0, 0, 0, 1, 0.1)

        if tabid == GetInt(cfgstr .. "activetab") then 
            UiColor(0.8, 0.8, 0.8, 1)
            UiTextShadow(0.7, 0.7, 0.7, 0.5, 1.0)
        else
            UiColor(0.5, 0.5, 0.5, 1)
            UiTextShadow(0, 0, 0, 0.5, 1.0)
        end

        if UiTextButton(name) then
            SetInt(cfgstr .. "activetab", tabid)
        end
    UiPop()
end

function NavSep(tabid)
    UiPush()
        UiTranslate(100 + (tabid * 100), -14)
        UiColor(0.23, 0.23, 0.23, 1)
        UiRect(3, UiHeight() * 0.15)
    UiPop()
end

function Watermark()
    if not AdvGetBool(cfgstr .. "watermark") then 
        return 
    end

    UiPush()
        local rgb = seedToRGB(GetTime())
        UiColor(rgb.R, rgb.G, rgb.B, 1)
        UiTranslate(0, 0)
        UiAlign("left top")
        UiFont("bold.ttf", 25)
        UiTextShadow(0, 0, 0, 0.5, 1.5)
        UiTextOutline(0, 0, 0, 0.7, 0.07)
        UiText("Tearware")
    UiPop()
end

function FeatureList()
    if not AdvGetBool(cfgstr .. "featurelist") then 
        return 
    end

    local visibleFeatures = 0.01

    UiPush()
        UiTranslate(0, 0)
        UiAlign("top left")

        if AdvGetBool(cfgstr .. "watermark") then 
            UiTranslate(0, 25)
        end

        UiFont("bold.ttf", 12)
        UiTextShadow(0, 0, 0, 0.2, 1.5)
        UiTextOutline(0, 0, 0, 0.7, 0.07)

        for i=1, #featurelist do
            if GetBool(cfgstr .. featurelist[i].var) then 
                visibleFeatures = visibleFeatures + 0.01
                local rgb = seedToRGB(GetTime() + visibleFeatures)
                UiColor(rgb.R, rgb.G, rgb.B, 1)

                UiText(featurelist[i].name, true)
            end
        end

    UiPop()
end

function WeaponGlow() 
    if not AdvGetBool(cfgstr .. "weaponglow") then 
        return 
    end

    local toolBody = GetToolBody()
    if toolBody~=0 then

        local rgb = seedToRGB(GetTime())
        DrawBodyOutline(toolBody, rgb.R, rgb.G, rgb.B, 1)
    end
end

function ActiveGlow() 
    if not AdvGetBool(cfgstr .. "activeglow") then 
        return 
    end
    local bodies = FindBodies(nil,true)
	for i=1,#bodies do
		local body = bodies[i]
		if IsBodyActive(body) then
            local rgb = seedToRGB(GetTime() + (i / 10))
            
            DrawBodyOutline(body, rgb.R, rgb.G, rgb.B, 1)
        end
    end
end

function GetBodyCenter(body)
    local min, max = GetBodyBounds(body)
    return VecLerp(min, max, 0.5)
end

function ObjectiveEsp() 
    if not AdvGetBool(cfgstr .. "objectiveesp") then 
        return 
    end

    local targets = FindBodies("target", true)
	for i=1,#targets do
        local body = targets[i]
		if GetTagValue(body, "target") ~= "cleared" and GetTagValue(body, "target") ~= "disabled" then
			local targetpos = GetBodyCenter(body)
            local optional = HasTag(body, "optional")
            local x, y, dist = UiWorldToPixel(targetpos)
            if dist > 2 then
                UiPush()
                    UiFont("bold.ttf", 16)
                    UiAlign("center middle")
                    UiTextShadow(0, 0, 0, 0.5, 1.5)
                    UiTextOutline(0, 0, 0, 0.7, 0.1)
                    
                    UiTranslate(x, y)
                    if optional then 
                        UiColor(0.3, 0.3, 0.7, 0.7)
                        UiText("Optional", true)
                    else 
                        UiColor(0.7, 0.3, 0.3, 0.7)
                        UiText("Target", true)
                    end
                    UiText(math.floor(dist) .. "m")
                UiPop() 
            end

            if optional then 
                DrawBodyOutline(body, 0.3, 0.3, 0.7, 0.3)
            else 
                DrawBodyOutline(body, 0.7, 0.3, 0.3, 0.3)
            end
        end
	end
end

function ValueableEsp() 
    if not AdvGetBool(cfgstr .. "valueesp") then 
        return 
    end

    local v = FindBodies("valuable", true)
    for i=1,#v do
        local body = v[i]
        if not IsBodyBroken(body) then 
            local isValuable = HasTag(body, "valuable")
            local value = GetTagValue(body, "value")
            local targetpos = GetBodyCenter(body)
            local x, y, dist = UiWorldToPixel(targetpos)
            if isValuable then 
                if dist > 2 then 
                    UiPush()
                        UiFont("bold.ttf", 16)
                        UiAlign("center middle")
                        UiTextShadow(0, 0, 0, 0.5, 1.5)
                        UiTextOutline(0, 0, 0, 0.7, 0.1)
                        UiTranslate(x, y)
                        UiColor(0.3, 0.7, 0.3, 0.7)
                        -- UiText(GetDescription(body), true)
                        UiText("$" .. math.floor(value), true)
                        UiText(math.floor(dist) .. "m")
                    UiPop() 
                end
                DrawBodyOutline(body, 0.3, 0.7, 0.3, 0.3)
            end
        end
    end
end

function ToolEsp() 
    if not AdvGetBool(cfgstr .. "toolesp") then 
        return 
    end

    local interactables = FindBodies("interact", true)
    for i=1,#interactables do
        local body = interactables[i]
        if not IsBodyBroken(body) then 
            local interactType = GetTagValue(body, "interact")
            local isTool = interactType == "Pick up" 
            
            local targetpos = GetBodyCenter(body)
            local x, y, dist = UiWorldToPixel(targetpos)
            if isTool then 
                if dist > 2 then 
                    UiPush()
                        UiFont("bold.ttf", 16)
                        UiAlign("center middle")
                        UiTextShadow(0, 0, 0, 0.5, 1.5)
                        UiTextOutline(0, 0, 0, 0.7, 0.1)
                        UiTranslate(x, y)
                        UiColor(0.7, 0.7, 0.3, 0.7)
                        UiText(GetDescription(body), true)
                        UiText(math.floor(dist) .. "m")
                    UiPop() 
                end
                DrawBodyOutline(body, 0.7, 0.7, 0.3, 0.3)
            end
        end
    end
end

function VisualsDraw()
    if not AdvGetBool(cfgstr .. "visuals") then 
        return 
    end

    Watermark()
    FeatureList()
    ValueableEsp()
    ObjectiveEsp()
    ToolEsp()
    WeaponGlow()
    ActiveGlow()
end

-- called on each draw
function draw() 

    VisualsDraw()

    if not isMenuOpen then
        filthyglobal_editingkeybind = " "
        return
    end

    UiMakeInteractive()
    SetBool("game.disablepause", true)
    if InputPressed("pause") then
        isMenuOpen = false
    end

    -- funny rgb blur background
    UiPush()
        UiAlign("center middle")

        local rgb = seedToRGB(GetTime())
        UiColor(rgb.R, rgb.G, rgb.B, 0.0420)
        
        UiTranslate(UiCenter(), UiMiddle())
        UiRect(UiWidth(), UiHeight())
        
        UiBlur(0.3)
    UiPop()

    UiPush()
        UiFont("bold.ttf", 25)
        
        -- create context
        UiTranslate(UiCenter(), UiMiddle())
        UiWindow(500, 600)

        -- draw window background
        UiAlign("center middle")
        UiColor(0.23, 0.23, 0.23, 1)
        UiRect(510, 610)

        UiColor(0.53, 0.53, 0.53, 0.6)
        UiRect(500, 600)

        -- gradient bar, very important for every cheat
        UiPush()
            -- rgb defined in the same scope by background blur
            UiColor(rgb.R, rgb.G, rgb.B, 1)
            UiTranslate(0, -UiMiddle() - 2)
            UiRect(UiWidth(), 2)
        UiPop()
        -- navigtor
        UiPush()
            UiAlign("center top")
            UiColor(0.23, 0.23, 0.23, 1)
            UiTranslate(0, -UiMiddle() * 0.7)
            UiRect(UiWidth(), 5)

            UiTranslate(-UiCenter(), (-UiMiddle() * 0.3))

            UiPush()
                UiTranslate(0, 14)
                NavButton("A", 0)
                NavSep(0)
                NavButton("B", 1)
                NavSep(1)
                NavButton("C", 2)
                NavSep(2)
                NavButton("D", 3)
                NavSep(3)
                NavButton("E", 4)
            UiPop()
        UiPop()

        UiTranslate(-UiCenter() + 10, UiMiddle() * -0.64)
        
        UiAlign("left top")
        UiColor(1, 1, 1, 1)
        
        UiPush()
            if GetInt(cfgstr .. "activetab") == 0 then 
                -- weapons/aim/triggerbot idk?

                Checkbox("Infinite Ammo", "infiniteammo")

            elseif GetInt(cfgstr .. "activetab") == 1 then 
                -- visuals

                Checkbox("Visuals", "visuals")
                if GetBool(cfgstr .. "visuals") then 
                
                    Checkbox("Watermark", "watermark")
                    Checkbox("Feature List", "featurelist")
                    Checkbox("Objective ESP", "objectiveesp")
                    Checkbox("Valuable ESP", "valueesp")
                    Checkbox("Tool ESP", "toolesp")
                    Checkbox("Weapon Glow", "weaponglow")
                    Checkbox("Active Glow", "activeglow")

                end

            elseif GetInt(cfgstr .. "activetab") == 2 then 
                -- movement

                Checkbox("Speed", "speedhack")
                Checkbox("Spider", "spider")
                Checkbox("Fly", "fly")
                Checkbox("Noclip", "noclip")
                Checkbox("Floor Strafe", "floorstrafe")
                Checkbox("Jetpack", "jetpack")
                Checkbox("Jesus", "jesus")
                Checkbox("Quickstop", "quickstop")

            elseif GetInt(cfgstr .. "activetab") == 3 then 
                -- misc

                Checkbox("Godmode", "godmode")
                Checkbox("Bullet Time", "timer")
                Checkbox("Skip Objective", "skipobjective")
                Checkbox("Disable Alarm", "disablealarm")
                Checkbox("Disable Physics", "disablephysics")
                Checkbox("Force Update Physics", "forceupdatephysics")
            
            elseif GetInt(cfgstr .. "activetab") == 4 then 
                -- tools

                Checkbox("Rubberband", "rubberband")
                Checkbox("Teleport Valuables To Player", "autocollect")
                Checkbox("Unfair Valuables", "inflationishittinghard")
                Checkbox("Teleport", "teleport")
                Checkbox("Explosion Brush", "explosionbrush")
                Checkbox("Fire Brush", "firebrush")

            end
        UiPop()

    UiPop() 
end
