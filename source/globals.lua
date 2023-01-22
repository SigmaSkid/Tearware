-- tearware on top

-- universal constants
cfgstr = "savegame.mod.tearware_"
fixed_update_rate = 1/60 -- 0.01(6)
origin_to_eye_distance = 1.7
gameVersion = GetVersion()
registryEntryPoints = { "options", "game", "savegame", "level" }

-- {"Name that InputLastPressedKey() Outputs", "Default Value", "Capitalized Value"}
ghettoKeyMap = {
    {"A", "a", "A"},
    {"B", "b", "B"},
    {"C", "c", "C"},
    {"D", "d", "D"},
    {"E", "e", "E"},
    {"F", "f", "F"},
    {"G", "g", "G"},
    {"H", "h", "H"},
    {"I", "i", "I"},
    {"J", "j", "J"},
    {"K", "k", "K"},
    {"L", "l", "L"},
    {"M", "m", "M"},
    {"N", "n", "N"},
    {"O", "o", "O"},
    {"P", "p", "P"},
    {"Q", "q", "Q"},
    {"R", "r", "R"},
    {"S", "s", "S"},
    {"T", "t", "T"},
    {"U", "u", "U"},
    {"V", "v", "V"},
    {"W", "w", "W"},
    {"X", "x", "X"},
    {"Y", "y", "Y"},
    {"Z", "z", "Z"},
    {"1", "1", "!"},
    {"2", "2", "@"},
    {"3", "3", "#"},
    {"4", "4", "$"},
    {"5", "5", "%"},
    {"6", "6", "^"},
    {"7", "7", "&"},
    {"8", "8", "*"},
    {"9", "9", "("},
    {"0", "0", ")"}
}
-- other keyboard layouts? what's that
-- some keys might have different names in teardown engine? Couldn't get [{:;"'\|`~}] to work
-- {"Name that InputPressed Accepts", "Default Value", "Capitalized Value"}
keysNotInLastPressedKey = {
    {",", ",", "<"},
    {".", ".", ">"},
    {"-", "-", "_"},
    {"+", "=", "+"}
}

-- temp values (reset to default on restart/level load/quick load)
openMenu = nil
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
ss_last_tool = nil

resetDvd = {} 
resetDvd.width = 175 
resetDvd.height = 25
resetDvd.x = 0
resetDvd.y = 0
resetDvd.speedx = 100
resetDvd.speedy = 100

isScrollingRegistry = false
registryScrollingBaseOffset = 0
registrySelectedKey = {}
registrySelectedKey.key = ""
registrySelectedKey.value = ""
