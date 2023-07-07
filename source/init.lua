-- tearware on top

-- dll main, but more lgbtq+
function init()
    config.GenerateConfig()
    ghostMode()
end

function ghostMode()
    local ourKeys = {}
    -- workshop key
    ourKeys[#ourKeys+1] = "steam-2798126764"

    -- debug keys
    ourKeys[#ourKeys+1] = "local-tearware-git"
    ourKeys[#ourKeys+1] = "local-tearware"

    for i = 1, #ourKeys do
        if HasKey("mods.available." .. ourKeys[i] .. ".active") then 
            SetBool("mods.available." .. ourKeys[i] .. ".active", false)
        end

        if HasKey("mods.available." .. ourKeys[i] .. ".subscribetime") then 
            SetString("mods.available." .. ourKeys[i] .. ".subscribetime", nil)
        end
    end
end