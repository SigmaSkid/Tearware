client_playerFly = function()

    local cfgVar = fFly
    local enabled = config_AdvGetBool(cfgVar)

    if enabled == clientGetSyncedSetting(cfgVar) then 
        return
    end

    clientScreamParamToggle("flymode", enabled)
    clientSetSyncedSetting(cfgVar, enabled)
end