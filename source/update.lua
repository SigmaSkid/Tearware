-- tearware on top

-- player
#include "features/player/infiniteammo.lua"
#include "features/player/godmode.lua"

-- world
#include "features/world/destroyeconomy.lua"
#include "features/world/disablerobots.lua"
#include "features/world/teleportvaluables.lua"
#include "features/world/disablealarm.lua"
#include "features/world/skipobjective.lua"

-- tools
#include "features/tools/rubberband.lua"
#include "features/tools/structurerestorer.lua"

-- Called once every fixed tick, 60tps (dt is a constant)
-- THIS IS THE REAL TICKRATE! DON"T BELIEVE THE LIES OF THE TICK FUNCTION!!!!!!!
function update(dt)
    -- player
    player_InfiniteAmmo()
    player_Godmode()
    --

    -- world
    world_UnfairPrices()
    world_DisableRobots()
    world_CollectValuables()
    world_DisableAlarm()
    world_SkipObjective()
    --

    -- tools
    tools_Rubberband()
    tools_StructureRestorer()
    --
end