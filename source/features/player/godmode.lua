function Godmode() 
    if not AdvGetBool(fGodmode) then
        return 
    end

    if GetPlayerHealth() then
        SetPlayerHealth(1)
    end
end