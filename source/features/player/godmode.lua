client_playerGodmode = function()

    local cfgVar = fGodmode
    local enabled = config_AdvGetBool(cfgVar)

    if enabled == clientGetSyncedSetting(cfgVar) then 
        return
    end

    clientScreamParamToggle("godmode", enabled)
    clientSetSyncedSetting(cfgVar, enabled)
end