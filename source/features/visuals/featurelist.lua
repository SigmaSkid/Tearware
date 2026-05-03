local featureListCache = {}
featureListCacheTime = -2137

function rebuildFeatureCache(max_features)
    featureListCache = {}
    local count = 0
    for i = 1, #featurelist do
        if count >= max_features then break end
        if config_GetLocalFeatureState(featurelist[i]) then
            local passHost     = not featurelist[i].hostOnly     or isLocalPlayerTheHost
            local passClient   = not featurelist[i].clientOnly   or not isLocalPlayerTheHost
            local passMp       = not featurelist[i].mpOnly       or isSessionMultiplayer
            local passCampaign = not featurelist[i].campaignOnly or isSessionCampaign

            if passHost and passClient and passMp and passCampaign then
                count = count + 1
                featureListCache[count] = featurelist[i].legacyName
            end
        end
    end
end

visuals_FeatureList = function()
    if not config_GetLocalFeatureState(fFeatureList) then 
        return 
    end

    local alignment = config_GetSubVar(GetInt,fFeatureList, fAlignmentLR)
    local watermark_above = config_GetLocalFeatureState(fWatermark) and config_GetSubVar(GetInt,fWatermark, fAlignmentLR) == alignment

    local now = GetTime()

    if now - featureListCacheTime >= 5.0 then
        local features_available_space = 1080 - 6
        if watermark_above then 
            features_available_space = features_available_space - 28
        end

        local max_features_to_display = math.floor(features_available_space / 14)

        rebuildFeatureCache(max_features_to_display)
        featureListCacheTime = now
    end

    UiPush()
        if alignment == 0 then 
            UiAlign("top left")    
            UiTranslate(5, 3)
        else 
            UiAlign("top right")
            UiTranslate(1920, 0)
            UiTranslate(-5, 3)
        end

        if watermark_above then
            UiTranslate(0, 25)
        end

        local color = config_GetColor(fFeatureList, now)

        UiFont(fonts.orbitron_sbold, 14)
        UiTextShadow(0, 0, 0, color.alpha * 0.2, 1.5)
        UiTextOutline(0, 0, 0, color.alpha * 0.7, 0.07)

        for i = 1, #featureListCache do
            local visibleFeatures = i * 0.05
            local col = config_GetColor(fFeatureList, now + visibleFeatures)
            UiColor(col.red, col.green, col.blue, col.alpha)
            UiText(featureListCache[i], false)
            UiTranslate(0, 14)
        end

    UiPop()
end


visuals_sortFeatureList = function() 
    -- sort for feature list.
    UiPush()
        UiFont(fonts.orbitron_sbold, 14)
        table.sort(featurelist, function (left, right)
            return UiGetTextSize(left.legacyName) > UiGetTextSize(right.legacyName)
        end)
    UiPop()
end
