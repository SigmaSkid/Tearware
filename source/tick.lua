-- tearware on top

-- player
#include "features/player/spider.lua"
#include "features/player/speedhack.lua"
#include "features/player/jesus.lua"
#include "features/player/floorstrafe.lua"
#include "features/player/jetpack.lua"
#include "features/player/fly.lua"
#include "features/player/noclip.lua"
#include "features/player/quickstop.lua"
#include "features/player/superstrength.lua"

-- world
#include "features/world/timer.lua"
#include "features/world/forceupdateallbodies.lua"
#include "features/world/disablephysics.lua"

-- visuals
#include "features/visuals/coloredfog.lua"
#include "features/visuals/postprocessing.lua"
#include "features/visuals/spinningtool.lua"

-- tools
#include "features/tools/explosionbrush.lua"
#include "features/tools/firebrush.lua"
#include "features/tools/teleport.lua"

-- called once per frame (dt is a dynamic float value between 0 and .0(3), 60fps = 0.1(6) )
function tick(dt) 
    if PauseMenuButton(fProjectName) then
		openMenu = "tearware"
    end

    if InputPressed("insert") then
        if openMenu ~= nil then 
            openMenu = nil 
        else 
            openMenu = "tearware"
        end
    end

    -- input system stuff
    UpdateAllFeatureStates() -- utils/config.lua

    -- delta time scaled, .5 = 120fps, 1 = 60fps, 2 = 30fps
    local dts = dt / fixed_update_rate

    -- universal features
    -- world 
    Timer()
    ForceUpdateAllBodies()
    DisablePhysics()
    --

    -- visuals
    ColoredFog()
    PostProcessing()
    --

    if GetPlayerVehicle() ~= 0 then
        -- in vehicle
        return
    end

    -- player
    Spider() 
    Speedhack()
    Jesus()
    Floorstrafe()
    Jetpack(dts)
    Fly()
    NoClip(dts)
    Quickstop()
    -- 

    -- tools
    Teleport()
    ExplosionBrush()
    FireBrush()
    -- 

    -- player
    SuperStrength()
    -- 

    -- visuals
    SpinningTool()
    --
end