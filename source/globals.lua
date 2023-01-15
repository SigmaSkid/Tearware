-- tearware on top

-- universal constants
cfgstr = "savegame.mod.tearware_"
fixed_update_rate = 1/60 -- 0.01(6)
origin_to_eye_distance = 1.7
gameVersion = GetVersion()
registryEntryPoints = { {"options", false}, {"game", false}, { "savegame", false}, {"level", true} }

-- temp values (reset to default on restart/level load/quick load)
openMenu = nil
isScrollingRegistry = false
registryScrollingBaseOffset = 0
featurelist = {}
filthyglobal_editingkeybind = " "
skipped_objective = false
valuablesBackup = {}
cached_fog_color = {}
cached_post_process = {}
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

registryCache = {}
registryScrollPos = 0
lastRegistryInput = " "

ss_object = {}
ss_object.obj = nil 
ss_object.dist = nil
