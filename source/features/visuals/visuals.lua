#include "watermark.lua"
#include "featurelist.lua"
#include "esp.lua"
#include "glow.lua"

visuals.DrawVisuals = function()
    if not config.AdvGetBool(fVisuals) then 
        return 
    end

    UiPush()
        visuals.Watermark()
        visuals.FeatureList()
        visuals.DrawEsp()
        visuals.DrawGlow()
    UiPop()
end
