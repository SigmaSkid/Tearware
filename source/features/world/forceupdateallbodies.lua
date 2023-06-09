world.ForceUpdateAllBodies = function()
    if not config.AdvGetBool(fForceUpdatePhysics) then
        return 
    end

    local bodies = FindBodies(nil,true)
    for i=1,#bodies do
        SetBodyActive(bodies[i], true)
    end
end