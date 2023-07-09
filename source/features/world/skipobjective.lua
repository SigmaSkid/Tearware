world_SkipObjective = function()
    if not config_AdvGetBool(fSkipObjective) then
        return
    end

    if skipped_objective then
        return
    end

    skipped_objective = true

    local targets = FindBodies("target", true)

    for i = 1, #targets do
        SetTag(targets[i], "target", "cleared")
    end

    -- SetString("level.state", "win") 
end