local lastgodmodeState = false
player_Godmode = function()
    local godmodeEnabled = config_AdvGetBool(fGodmode) 
    
    if godmodeEnabled == lastgodmodeState then 
        return 
    end

    lastgodmodeState = currentGodmodeState
    clientScreamParamToggle("godmode", currentGodmodeState)
end