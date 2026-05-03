world_DisableRobots = function()
    if not config_GetLocalFeatureState(fDisableRobots) then
        return
    end

    local robots = FindBodies("body", true)

    for i = 1, #robots do 
        SetTag(robots[i], "inactive")
    end

end