-- tearware on top

-- dirty global variable that we all hate.
-- shame on you global variable!
cfgstr = "savegame.mod.tearware_"
featurelist = {}

-- universal constants
fixed_update_rate = 1/60 -- 0.01(6)
origin_to_eye_distance = 1.7

-- temp values (reset to default on restart/level load/quick load)
isMenuOpen = false
filthyglobal_editingkeybind = " "
skipped_objective = false