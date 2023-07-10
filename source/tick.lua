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

-- called once per frame (dt is a dynamic float value between 0 and .0(3), 60fps = 0.01(6) )
-- you know, cuz TICKRATE isn't fixed. It's the UPDATERATE that's fixed.
-- Imagine having a static TICKRATE LIKE ANY SOURCE GAME. NO IT"S FIXED UPDATE RATE WITH DYNAMIC TICKS
-- DARN INDIE DEVS I SWEAR
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
    config_UpdateAllFeatureStates() -- utils/config.lua

    -- delta time scaled, .5 = 120fps, 1 = 60fps, 2 = 30fps
    -- seems not to be fully accurate. 20fps gave me a dts of 2
    local dts = dt / fixed_update_rate

    -- universal features
    -- world 
    world_Timer()
    world_ForceUpdateAllBodies()
    world_DisablePhysics()
    --

    -- visuals
    visuals_ColoredFog()
    visuals_PostProcessing()
    --

    if GetPlayerVehicle() ~= 0 then
        -- in vehicle
        return
    end

    -- player
    player_Spider() 
    player_Speedhack()
    player_Jesus()
    player_Floorstrafe()
    player_Jetpack(dts)
    player_Fly(dt)
    player_NoClip(dts)
    player_Quickstop()
    -- 

    -- tools
    tools_Teleport()
    tools_ExplosionBrush()
    tools_FireBrush()
    -- 

    -- player
    player_SuperStrength()
    -- 

    -- visuals
    visuals_SpinningTool()
    --
end