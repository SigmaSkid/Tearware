player.Godmode = function() 
    if not config.AdvGetBool(fGodmode) then
        return 
    end

    if GetPlayerHealth() then
        SetPlayerHealth(1)
    end
end