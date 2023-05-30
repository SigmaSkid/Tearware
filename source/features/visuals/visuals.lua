#include "watermark.lua"
#include "featurelist.lua"
#include "esp.lua"
#include "glow.lua"

function DrawVisuals()
    if not AdvGetBool(fVisuals) then 
        return 
    end

    UiPush()
        Watermark()
        FeatureList()
        DrawEsp()
        DrawGlow()
    UiPop()
end
