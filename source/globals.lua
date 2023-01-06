-- tearware on top

-- dirty global variables that we all hate.
-- shame on you global variables!
cfgstr = "savegame.mod.tearware_"
featurelist = {}

-- universal constants
fixed_update_rate = 1/60 -- 0.01(6)
origin_to_eye_distance = 1.7

-- temp values (reset to default on restart/level load/quick load)
isMenuOpen = false
filthyglobal_editingkeybind = " "
skipped_objective = false
valuablesBackup = {}
cached_fog_color = {}
cachedValuablesPositions = {}
active_sub_menu = nil
overrideConfigValues = false
activeBodyCache = {}
noclipbackuppos = {}

funnyColorCopyCache = {}
funnyColorCopyCache.red = 1
funnyColorCopyCache.green = 1
funnyColorCopyCache.blue = 1
funnyColorCopyCache.alpha = 1
funnyColorCopyCache.rainbow = false
