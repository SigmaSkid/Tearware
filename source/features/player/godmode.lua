player_Godmode = function() 
    if not config_AdvGetBool(fGodmode) then
        return 
    end

    if GetPlayerHealth() then
        SetPlayerHealth(1)
    end
end

-- @UnlegitSenpaii
-- BigBook wanted this. so here.
player_visuals_Godmode = function()
    if not config_AdvGetBool(fGodmode) then
        return 
    end

    SetFloat("game.player.health", 1)
end