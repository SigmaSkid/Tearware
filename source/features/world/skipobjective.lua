skipped_objective_count = 0
world_SkipObjective = function()
    if not isSessionCampagin then return end

    if not config_GetLocalFeatureState(fSkipObjective) then
        return
    end

    if skipped_objective then    
        if skipped_objective_count and config_GetSubVar(GetBool, fSkipObjective, fSubSkipObjectiveFinish) then 
            SetString("level.state", "win") 
        end
        return
    end

    if GetTime() < 0.1 then 
        return 
    end

    skipped_objective = true

    local targets = FindBodies("target", true)

    for i = 1, #targets do
        SetTag(targets[i], "target", "cleared")
    end

    skipped_objective_count = #targets
end