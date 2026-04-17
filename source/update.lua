-- player
#include "features/player/infiniteammo.lua"
#include "features/player/godmode.lua"
#include "features/player/floorstrafe.lua"
#include "features/player/bunnyhop.lua"

-- world
#include "features/world/destroyeconomy.lua"
#include "features/world/disablerobots.lua"
#include "features/world/teleportvaluables.lua"
#include "features/world/disablealarm.lua"
#include "features/world/skipobjective.lua"

-- tools
#include "features/tools/rubberband.lua"
#include "features/tools/structurerestorer.lua"


-- In teardown update is called at 60tps
function client.update(dt)
    -- player
    client_playerInfiniteAmmo()
    client_playerGodmode()
    --

    -- tools
    client_ToolsRubberband()
    --
end

-- physics begone!
function playerServerPostUpdate(playerID, dt)
    if syncedPlayerSetting[playerID] == nil then
        return 
    end

    server_playerAntiAim(playerID, dt)
    server_ToolsTeleport(playerID, dt)
    server_ToolsRubberband(playerID)
    server_playerFloorstrafe(playerID)
    server_playerBunnyhop(playerID, dt)
end

-- physics?
function playerServerUpdate(playerID, dt)
    if syncedPlayerSetting[playerID] == nil then
        return 
    end

end


function server.postUpdate(dt)
    local players = GetAllPlayers()
    for id=1, #players do
        if IsPlayerValid(id) then 
            playerServerPostUpdate(id, dt)
        end
    end
end

function server.update(dt)

    local players = GetAllPlayers()
    for id=1, #players do
        if IsPlayerValid(id) then 
            playerServerPostUpdate(id, dt)
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