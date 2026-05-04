local featureListCache = {} -- {str, width}
featurelistForceCacheUpdate = true -- basically just do it once.

function featurelistFilter(feature)
    local passHost     = not feature.hostOnly     or isLocalPlayerTheHost
    local passClient   = not feature.clientOnly   or not isLocalPlayerTheHost
    local passMp       = not feature.mpOnly       or isSessionMultiplayer
    local passCampaign = not feature.campaignOnly or isSessionCampaign

    return passHost and passClient and passMp and passCampaign
end

function rebuildFeatureCache(max_features)
    featureListCache = {}
    local count = 0
    for i = 1, #featurelist do
        if count >= max_features then break end
        local legionnaire = featurelist[i]
        if config_GetLocalFeatureState(legionnaire) then
            if featurelistFilter(legionnaire) then
                count = count + 1
                featureListCache[count] = {str = legionnaire.legacyName, width = legionnaire.visibleWidth}
            end
        end
    end
end

function insertSorted(feature)
    local e = {str = feature.legacyName, width = feature.visibleWidth}
    for i = 1, #featureListCache do
        if e.width > featureListCache[i].width then
            table.insert(featureListCache, i, e)
            return
        end
    end

    DebugPrint("Feature couldn't be sorted on insert? " .. feature.legacyName)
    table.insert(featureListCache, feature.legacyName)
end

function removeFeatureFromCache(feature)
    for i = 1, #featureListCache do
        if featureListCache[i].str == feature.legacyName then
            table.remove(featureListCache, i)
            return
        end
    end
end

function featureListToggleSingle(feature, enabled)
    if enabled then 
        insertSorted(feature)
    else
        removeFeatureFromCache(feature)
    end
end

visuals_FeatureList = function()
    if not config_GetLocalFeatureState(fFeatureList) then 
        return 
    end

    local alignment = config_GetSubVar(GetInt,fFeatureList, fAlignmentLR)
    local watermark_above = config_GetLocalFeatureState(fWatermark) and config_GetSubVar(GetInt,fWatermark, fAlignmentLR) == alignment
    local now = GetTime()
    local features_available_space = 76 -- magic value (1080[1920x1080 vertical height] - 6 [padding])/14[font size]

    if featurelistForceCacheUpdate then
        rebuildFeatureCache(features_available_space)
        featurelistForceCacheUpdate = false
    end

    local maxFeaturesToDraw = features_available_space
    if watermark_above then 
        maxFeaturesToDraw = maxFeaturesToDraw - 2
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

        local drawMax = math.min(#featureListCache, maxFeaturesToDraw)
        for i = 1, drawMax do
            local visibleFeatures = i * 0.05
            local col = config_GetColor(fFeatureList, now + visibleFeatures)
            UiColor(col.red, col.green, col.blue, col.alpha)
            UiText(featureListCache[i].str, false)
            UiTranslate(0, 14)
        end

    UiPop()
end

featureListMeasureWidthOfFeaturesOnce = true
visuals_sortFeatureList = function() 
    if featureListMeasureWidthOfFeaturesOnce then 
        UiPush()
            UiFont(fonts.orbitron_sbold, 14)
            for i = 1, #featurelist do 
                featurelist[i].visibleWidth = UiGetTextSize(featurelist[i].legacyName)
            end
        UiPop()
        featureListMeasureWidthOfFeaturesOnce = false
    end

    -- sort.
    table.sort(featurelist, function (left, right)
        return left.visibleWidth > right.visibleWidth
    end)
end
