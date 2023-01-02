-- tearware on top

function DefineBool(name, var, default) 
    local feature = {}
    feature.name = name 
    feature.var = var
    featurelist[#featurelist+1] = feature

    if HasKey(cfgstr .. var) and HasKey(cfgstr .. var .. "_key") then 
        return 
    end
    SetBool(cfgstr .. var, default)
    SetString(cfgstr .. var .. "_key", "null")
end

function DefineTool(var) 
    if HasKey(cfgstr .. var) and HasKey(cfgstr .. var .. "_key") then 
        return 
    end
    SetBool(cfgstr .. var, false)
    SetString(cfgstr .. var .. "_key", "null")
end

function DefineInt(var, default) 
    if HasKey(cfgstr .. var) then 
        return 
    end
    SetInt(cfgstr .. var, default)
end

function AdvGetBool(var)
    if not HasKey(var .. "_key") then 
        return GetBool(var)
    end

    local key = GetString(var .. "_key")
    if key == "null" or key == "" or key == nil then 
        return GetBool(var)
    end

    if InputPressed(key) then 
        SetBool(var, not GetBool(var))
    end
    
    return GetBool(var) 
end

-- dll main, but more gay
function init()
    -- weapons/aim/triggerbot idk?
    DefineBool("Infinite Ammo", "infiniteammo", false)
    
    -- visuals
    DefineBool("Visuals", "visuals", true)
    DefineBool("Watermark", "watermark", true)
    DefineBool("Feature List", "featurelist", false)
    DefineBool("Objective ESP", "objectiveesp", false)
    DefineBool("Valuable ESP", "valueesp", false)
    DefineBool("Tool ESP", "toolesp", false)
    DefineBool("Weapon Glow", "weaponglow", false)
    DefineBool("Active Glow", "activeglow", false)
    
    -- movement
    DefineBool("Speed", "speedhack", false)
    DefineBool("Spider", "spider", false)
    DefineBool("Fly", "fly", false)
    DefineBool("Noclip", "noclip", false)
    DefineBool("Floor Strafe", "floorstrafe", false)
    DefineBool("Jetpack", "jetpack", false)
    DefineBool("Jesus", "jesus", false)
    DefineBool("Quickstop", "quickstop", false)
    
    -- misc
    DefineBool("Godmode", "godmode", false)
    DefineBool("Bullet Time", "timer", false)
    DefineBool("Skip Objective", "skipobjective", false)
    DefineBool("Disable Alarm", "disablealarm", false)
    DefineBool("Disable Physics", "disablephysics", false)
    DefineBool("Force Update Physics", "forceupdatephysics", false)

    -- tools
    DefineBool("Rubberband", "rubberband", false)
    DefineBool("Teleport Valuables", "autocollect", false)
    DefineBool("Unfair Valuables", "inflation", false)
    DefineTool("teleport")
    DefineBool("Explosion Brush", "explosionbrush", false)
    DefineBool("Fire Brush", "firebrush", false)
    
    -- sort for feature list.
    UiPush()
        UiFont("bold.ttf", 12)
        table.sort(featurelist, function (left, right)
            return UiGetTextSize(left.name) > UiGetTextSize(right.name)
        end)
    UiPop()
end
