-- player
#include "features/player/infiniteammo.lua"
#include "features/player/floorstrafe.lua"
#include "features/player/bunnyhop.lua"
#include "features/player/quickstop.lua"

-- world
#include "features/world/destroyeconomy.lua"
#include "features/world/disablerobots.lua"
#include "features/world/teleportvaluables.lua"
#include "features/world/disablealarm.lua"
#include "features/world/skipobjective.lua"

-- tools
#include "features/tools/rubberband.lua"
#include "features/tools/structurerestorer.lua"

-- visuals
#include "features/visuals/resolver.lua"

function client.postUpdate()
    -- visuals
    client_applyResolver()
    --
end

-- physics begone!
function playerServerPostUpdate(playerID, dt)
    if syncedPlayerSetting[playerID] == nil then
        return 
    end

    server.playerAntiAim(playerID, dt)
    server.ToolsTeleport(playerID, dt)
    server.ToolsRubberband(playerID)
    server.playerFloorstrafe(playerID)
    server.playerBunnyhop(playerID, dt)
    server.playerQuickstop(playerID)
end

-- physics?
function playerServerUpdate(playerID, dt)
    if syncedPlayerSetting[playerID] == nil then
        return 
    end

    server.playerSpeedhack(playerID)
end


function server.postUpdate(dt)
    local players = GetAllPlayers()
    for id=1, #players do
        if IsPlayerValid(id) then 
            playerServerPostUpdate(id, dt)
        end
    end
end

-- In teardown update is called at 60tps
function server.update(dt)

    local players = GetAllPlayers()
    for id=1, #players do
        if IsPlayerValid(id) then 
            playerServerUpdate(id, dt)
        end
    end

    -- host features, they read host registry, no need for fancy workarounds.
    -- I think? I only tested in single player so far.. I hope it works like that.
    
    -- world
    world_UnfairPrices()
    world_DisableRobots()
    world_CollectValuables()
    world_DisableAlarm()
    world_SkipObjective()
    --

    -- tools
    tools_StructureRestorer()
    --
end