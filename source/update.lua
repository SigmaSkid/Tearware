-- tearware on top

-- player
#include "features/player/infiniteammo.lua"
#include "features/player/rubberband.lua"
#include "features/player/godmode.lua"

-- world
#include "features/world/destroyeconomy.lua"
#include "features/world/disablerobots.lua"
#include "features/world/teleportvaluables.lua"
#include "features/world/disablealarm.lua"
#include "features/world/skipobjective.lua"
#include "features/world/structurerestorer.lua"


-- Called once every fixed tick, 60tps (dt is a constant)
function update(dt)
    -- player
    InfiniteAmmo()
    Rubberband()
    Godmode()
    --

    -- world
    UnfairPrices()
    DisableRobots()
    CollectValuables()
    DisableAlarm()
    SkipObjective()
    StructureRestorer()
    --
end