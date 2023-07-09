#include "watermark.lua"
#include "featurelist.lua"
#include "esp.lua"
#include "glow.lua"

visuals_DrawVisuals = function()
    UiPush()
        visuals_Watermark()
        visuals_FeatureList()
        visuals_DrawEsp()
        visuals_DrawGlow()
    UiPop()
end
