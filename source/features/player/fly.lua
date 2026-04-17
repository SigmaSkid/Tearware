local lastFlyState = false
client_playerFly = function()
    local currentFlyState = config_AdvGetBool(fFly) 
    if currentFlyState == lastFlyState then 
        return 
    end
    
    lastFlyState = currentFlyState

    clientScreamParamToggle("flymode", currentFlyState)
end