player.InfiniteAmmo = function() 
    if not config.AdvGetBool(fInfiniteAmmo) then 
        return 
    end

    -- already has inf ammo / return to prevent visual glitches 
    if GetBool("level.unlimitedammo") then
        return
    end

    local pTool = GetString("game.player.tool")
    local Ammo = GetInt("savegame.tool." .. pTool .. ".ammo")
    if Ammo == nil or Ammo == 0 then
        -- seems like the engine really likes 9999
        Ammo = 9999
    end
    SetInt("game.tool." .. pTool .. ".ammo", Ammo)
end