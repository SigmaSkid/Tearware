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

-- In teardown update is called every fixed tick (60tps, dt = const).
-- Refer to the offcial documentation.
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