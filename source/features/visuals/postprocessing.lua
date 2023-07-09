visuals_PostProcessing = function()
    if not config_AdvGetBool(fPostProcess) then 
        if #cached_post_process > 0 then 
            SetPostProcessingProperty("colorbalance", cached_post_process[1], cached_post_process[2], cached_post_process[3])
            SetPostProcessingProperty("saturation", cached_post_process[4])
        end
        return
    end

    -- cache post process
    if #cached_post_process == 0 then 
        cached_post_process[1], cached_post_process[2], cached_post_process[3] = GetPostProcessingProperty("colorbalance")
        cached_post_process[4] = GetPostProcessingProperty("saturation")
    else
        local color = config_GetColor(fPostProcess, GetTime())
        SetPostProcessingProperty("colorbalance", color.red * 2, color.green * 2, color.blue * 2)
        SetPostProcessingProperty("saturation", color.alpha * 2)
    end
end