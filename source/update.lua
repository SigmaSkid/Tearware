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

-- In teardown tick is called per frame.
-- Refer to the offcial documentation.
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
    local dts = dt / fixed_update_rate

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