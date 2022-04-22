-- I hate lua, let's switch to c++ 

-- dirty global variable that we all hate.
-- shame on you global variable!
isMenuOpen = false

cfgstr = "savegame.mod.tearware_"

function DefineBool(var, default) 
    if HasKey(cfgstr .. var) then 
        return 
    end
    SetBool(cfgstr .. var, default)
end

function DefineInt(var, default) 
    if HasKey(cfgstr .. var) then 
        return 
    end
    SetInt(cfgstr .. var, default)
end

-- dll main, but more gay
function init()
    -- weapons/aim/triggerbot idk?
    DefineBool("infiniteammo", false)
    
    -- visuals
    DefineBool("visuals", true)
    DefineBool("watermark", true)
    DefineBool("objectiveesp", false)
    DefineBool("valueesp", false)
    
    -- movement
    DefineBool("speedhack", false)
    DefineBool("fly", false)
    DefineBool("floorstrafe", false)
    DefineBool("jetpack", false)

    -- misc
    DefineBool("godmode", false)
    DefineBool("rubberband", false)
    
    -- *misc
    DefineBool("disablealarm", false)

    DefineInt("activetab", 0)
end

function Rubberband() 
    
    if not GetBool(cfgstr .. "rubberband") then
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
	if not GetBool(cfgstr .. "disablealarm") then
        return
    end
    SetFloat("level.alarmtimer", 817)
    SetBool("level.alarm", false)
    SetBool("level.alarmdisabled", true) 
end

function InfiniteAmmo() 
    if not GetBool(cfgstr .. "infiniteammo") then 
        return 
    end

    SetInt("game.tool."..GetString("game.player.tool")..".ammo", 420)
end

function Godmode() 
    if not GetBool(cfgstr .. "godmode") then
        return 
    end
	
    if GetPlayerHealth() then
        SetPlayerHealth(1)
    end
end

function Fly()
    if not GetBool(cfgstr .. "fly") then 
        return 
    end

    if GetPlayerVehicle() ~= 0 then
        return
    end

    SetPlayerVelocity(Vec(0, 0, 0))

    local TargetVel = 20
    if InputDown("shift") then 
        TargetVel = 40 
    end

    if not InputDown("left") and not InputDown("right") and not InputDown("up") and not InputDown("down") then

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
    local x, y, z = GetQuatEuler(rot)

    local K = InputDown("up") 
    local L = InputDown("down")

    if K then
        if InputDown("left")  then
            y = y + 45
            if y > 180 then
                y = y - 360
            end
        elseif InputDown("right")  then
            y = y - 45
            if y < -180 then
                y = y + 360
            end
        end
    elseif L then 
        y = y + 180
        if y > 180 then
            y = y - 360
        end

        if InputDown("left")  then
            y = y - 45
            if y > 180 then
                y = y - 360
            end
        elseif InputDown("right")  then
            y = y + 45
            if y < -180 then
                y = y + 360
            end
        end
    else
        if InputDown("left")  then
            y = y + 90
            if y > 180 then
                y = y - 360
            end
        elseif InputDown("right")  then
            y = y - 90
            if y < -180 then
                y = y + 360
            end
        end
    end

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
    if not GetBool(cfgstr .. "speedhack") then 
        return 
    end

    if GetPlayerVehicle() ~= 0 then
        return
    end

    if not InputDown("left") and not InputDown("right") and  not InputDown("up") and  not InputDown("down") then
        return 
    end 

    local velocity = GetPlayerVelocity()

    local TargetVel = 20

    -- scary math below, run.

    -- get scary quat
    local rot = GetCameraTransform().rot
    -- convert to cool angles
    local x, y, z = GetQuatEuler(rot)

    local K = InputDown("up") 
    local L = InputDown("down")

    if K then
        if InputDown("left")  then
            y = y + 45
            if y > 180 then
                y = y - 360
            end
        elseif InputDown("right")  then
            y = y - 45
            if y < -180 then
                y = y + 360
            end
        end
    elseif L then 
        y = y + 180
        if y > 180 then
            y = y - 360
        end

        if InputDown("left")  then
            y = y - 45
            if y > 180 then
                y = y - 360
            end
        elseif InputDown("right")  then
            y = y + 45
            if y < -180 then
                y = y + 360
            end
        end
    else
        if InputDown("left")  then
            y = y + 90
            if y > 180 then
                y = y - 360
            end
        elseif InputDown("right")  then
            y = y - 90
            if y < -180 then
                y = y + 360
            end
        end
    end

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
    if not GetBool(cfgstr .. "floorstrafe") then 
        return 
    end

    if GetPlayerVehicle() ~= 0 then
        return
    end

    local velocity = GetPlayerVelocity()

    velocity[2] = 1

    SetPlayerGroundVelocity(velocity)

end

function Jetpack() 
    if not GetBool(cfgstr .. "jetpack") then 
        return 
    end

    if GetPlayerVehicle() ~= 0 then
        return
    end

    if InputDown("jump") then 
        local velocity = GetPlayerVelocity()

        velocity[2] = velocity[2] + 0.5
        if velocity[2] > 7 then 
            velocity[2] = 7 
        end

        SetPlayerVelocity(velocity) 
    end

end

-- Called once every fixed tick, 60tps
function update(dt)
    InfiniteAmmo()

    Disablealarm()

    Godmode()

    Rubberband()
end

-- called once per frame
function tick(dt) 
    if InputPressed("insert") then
        isMenuOpen = not isMenuOpen
    end
    if isMenuOpen then
        UiMakeInteractive()
    end

    Speedhack()
    Fly()
    Floorstrafe()
    Jetpack()
end

function Checkbox(name, var)
    UiPush()
    UiAlign("left top")

    UiTextShadow(0, 0, 0, 0.5, 2.0)
    if GetBool(cfgstr .. var) then 
        UiColor(0.6, 1.0, 0.6, 1)
    else 
        UiColor(1.0, 0.6, 0.6, 1)
    end

    if UiTextButton(name) then
        if GetBool(cfgstr .. var) then 
            SetBool(cfgstr .. var, false)
        else 
            SetBool(cfgstr .. var, true)
        end
    end
    UiPop()
    UiText("", true)
end

function Button(name)
    UiPush()
    UiAlign("left top")

    UiTextShadow(0, 0, 0, 0.5, 2.0)
    
    UiColor(1.0, 1.0, 0.6, 1)
    
    if UiTextButton(name) then
        UiPop()
        UiText("", true)
        return true
    end
    UiPop()
    UiText("", true)
    return false
end

function RGB_rainbow_clamp(X) 
    if X > 0.5 then
        X = 1 - X 
    else 
        X = X
    end

    return 0.2 + (X * 1.6)
end

function NavButton(name, tabid)
    UiPush()
        UiTranslate(50 + (tabid * 100), -20)
        UiFont("bold.ttf", 120)

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
    if not GetBool(cfgstr .. "watermark") then 
        return 
    end

    UiPush()

        local R = RGB_rainbow_clamp( GetTime()%5 / 5 )
        local B = RGB_rainbow_clamp( GetTime()%3 / 3 )
        local G = RGB_rainbow_clamp( 1 - GetTime()%1 )
        UiColor(R, G, B, 1)
        UiTranslate(0, 0)
        UiAlign("left top")
        UiFont("bold.ttf", 25)
        UiTextShadow(0, 0, 0, 0.5, 2.0)
        UiText("Tearware")
        
    UiPop()
end

function ObjectiveEsp() 
    if not GetBool(cfgstr .. "objectiveesp") then 
        return 
    end

    local targets = FindBodies("target", true)
	for i=1,#targets do		 
		if GetTagValue(targets[i], "target") ~= "cleared" and GetTagValue(targets[i], "target") ~= "disabled" then
			local targetpos = GetBodyTransform(targets[i]).pos
            local optional = HasTag(targets[i], "optional")
            local x, y, dist = UiWorldToPixel(targetpos)
            if dist > 2 then
                UiPush()
                    UiFont("bold.ttf", 25)
                    UiAlign("center middle")
                    UiTranslate(x, y)
                    if optional then 
                        UiColor(0.3, 0.3, 0.7, 0.7)
                        UiText("Optional", true)
                    else 
                        UiColor(0.3, 0.7, 0.3, 0.7)
                        UiText("Target", true)
                    end
                    UiText(math.floor(dist) .. "m")
                UiPop() 
            end
        end
	end
end

function ValueableEsp() 
    if not GetBool(cfgstr .. "valueesp") then 
        return 
    end

    local v = FindBodies("valuable", true)
    for i=1,#v do
        local isValuable = HasTag(v[i], "valuable")
        local value = GetTagValue(v[i], "value")
        local targetpos = GetBodyTransform(v[i]).pos
        local x, y, dist = UiWorldToPixel(targetpos)
        if dist > 2 and isValuable then 
            UiPush()
                UiFont("bold.ttf", 25)
                UiAlign("center middle")
                UiTranslate(x, y)
                UiColor(0.7, 0.7, 0.3, 0.7)
                UiText(math.floor(value) .. "$", true)
                UiText(math.floor(dist) .. "m")
            UiPop() 
        end
    end
end

function VisualsDraw()
    if not GetBool(cfgstr .. "visuals") then 
        return 
    end

    Watermark()
    ValueableEsp()
    ObjectiveEsp()
end

-- called on each draw
function draw() 

    VisualsDraw()

    if not isMenuOpen then
        return
    end

    -- funny rgb blur background
    UiPush()
        UiAlign("center middle")

        local R = RGB_rainbow_clamp( 1 - GetTime()%1 )
        local G = RGB_rainbow_clamp( GetTime()%3 / 3 )
        local B = RGB_rainbow_clamp( GetTime()%5 / 5 )
        UiColor(R, G, B, 0.0420)
        
        UiTranslate(UiCenter(), UiMiddle())
        UiRect(UiWidth(), UiHeight())
        
        UiBlur(0.1)
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
        UiBlur(0.06)

        UiColor(0.53, 0.53, 0.53, 0.6)
        UiRect(500, 600)

        -- gradient bar, very important for every cheat
        UiPush()
            -- worst rgb function you have ever seen!
            local R = RGB_rainbow_clamp( GetTime()%5 / 5 )
            local B = RGB_rainbow_clamp( GetTime()%3 / 3 )
            local G = RGB_rainbow_clamp( 1 - GetTime()%1 )
            UiColor(R, G, B, 1)
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
                    Checkbox("Objective ESP", "objectiveesp")
                    Checkbox("Valuable ESP", "valueesp")
                    
                end

            elseif GetInt(cfgstr .. "activetab") == 2 then 
                -- movement

                Checkbox("Speed", "speedhack")
                Checkbox("Fly", "fly")
                Checkbox("Floor Strafe", "floorstrafe")
                Checkbox("Jetpack", "jetpack")

            elseif GetInt(cfgstr .. "activetab") == 3 then 
                -- misc
                Checkbox("Godmode", "godmode")
                Checkbox("Rubberband", "rubberband")
            
            elseif GetInt(cfgstr .. "activetab") == 4 then 

                -- *misc
                Checkbox("Disable Alarm", "disablealarm")


            end
        UiPop()

    UiPop() 
end
