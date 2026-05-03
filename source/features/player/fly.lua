client_playerFly = function()

    local cfgVar = fFly
    local enabled = config_GetLocalFeatureState(cfgVar)

    if enabled == clientGetSyncedSetting(cfgVar) then 
        return
    end

    clientScreamParamToggle("flymode", enabled)
    clientSetSyncedSetting(cfgVar, enabled)
end