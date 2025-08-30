player_InfiniteAmmo = function() 
    if not config_AdvGetBool(fInfiniteAmmo) then 
        return 
    end

    -- already has inf ammo / return to prevent visual glitches 
    if GetBool("level.unlimitedammo") then
        return
    end

    local pTool = GetString("game.player.tool")
    local Ammo = GetInt("savegame.tool." .. pTool .. ".ammo")
    if Ammo == nil or Ammo == 0 then
        -- at 9999 ammo, the engine doesn't display ammo count
        Ammo = 9999
    end
    SetInt("game.tool." .. pTool .. ".ammo", Ammo)
end