world.DisablePhysics = function()
    if not config.AdvGetBool(fDisablePhysics) then
        return 
    end

	local bodies = FindBodies(nil,true)
    for i=1,#bodies do
        SetBodyActive(bodies[i], false)
    end
end