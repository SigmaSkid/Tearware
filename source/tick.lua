-- world
#include "features/world/timer.lua"
#include "features/world/forceupdateallbodies.lua"
#include "features/world/disablephysics.lua"

-- visuals
#include "features/visuals/coloredfog.lua"
#include "features/visuals/postprocessing.lua"

-- tools
#include "features/tools/teleport.lua"
#include "features/tools/rubberband.lua"

-- player
#include "features/player/superstrength.lua"

-- In teardown tick is called per frame.
function client.tick(dt) 
    if PauseMenuButton(fProjectName) then
		openMenu = "tearware"
    end

    if InputPressed("insert") then
        if openMenu ~= nil and openMenu ~= 0 then 
            openMenu = nil 
        else 
            openMenu = "tearware"
        end
    end

    -- input system stuff
    config_UpdateAllFeatureStates() -- utils/config.lua

    -- visuals
    visuals_PostProcessing()
    --

    if GetPlayerVehicle() ~= 0 then
        -- in vehicle
        return
    end

    -- player
    client.playerSuperStrength()
    --

    -- tools
    client_ToolsTeleport()
    client_ToolsRubberband()
    -- 
end

function server.tick(dt)

    -- host features, they read host registry, no need for fancy workarounds.
    visuals_ColoredFog()
    world_Timer()
    world_ForceUpdateAllBodies()
    world_DisablePhysics()
end
