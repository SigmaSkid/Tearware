-- updated automatically, by the packing script.
fProjectName = "Tearware Github Preview"

-- visuals
fWatermark = { legacyName = "Watermark", configString = "watermark", hostOnly=nil, mpOnly=nil, campaignOnly=nil, clientOnly=nil}
fFeatureList = { legacyName = "Feature List", configString = "featurelist"}

fObjectiveEsp = { legacyName = "Objective ESP", configString = "objectiveesp", campaignOnly=true}
fOptionalEsp = { legacyName = "Optional ESP", configString = "optionalesp", campaignOnly=true}
fValuableEsp = { legacyName = "Valuable ESP", configString = "valueesp", campaignOnly=true}
fToolEsp = { legacyName = "Tool ESP", configString = "toolesp", campaignOnly=true}
fPlayerGlow = { legacyName = "Player Glow", configString = "playerglow"}
fActiveGlow = { legacyName = "Active Glow", configString = "activeglow"}
fRainbowFog = { legacyName = "Colored Fog", configString = "rainbowfog", hostOnly=true}
fPostProcess = { legacyName = "Post Processing", configString = "postprocessing"}
fWeaponGlow = { legacyName = "Equipped Tool Glow", configString = "weaponglow"}

-- player
fSpeed = { legacyName = "Speed", configString = "speedhack"}
fSpider = { legacyName = "Spider", configString = "spider"}
fFly = { legacyName = "Fly", configString = "fly"}
fFloorStrafe = { legacyName = "Floor Strafe", configString = "floorstrafe"}
fBunnyhop = { legacyName = "Bunnyhop", configString = "bunnyhop"}
fJetpack = { legacyName = "Jetpack", configString = "jetpack"}
fJesus = { legacyName = "Jesus", configString = "jesus"}
fQuickstop = { legacyName = "Quickstop", configString = "quickstop"}
fInfiniteAmmo = { legacyName = "Infinite Ammo", configString = "infiniteammo", hostOnly=true}
fSuperStrength = { legacyName = "Super Strength", configString = "superstrength"}
fGodmode = { legacyName = "Godmode", configString = "godmode"}
fNoFall = { legacyName = "No-Fall", configString = "nofall"}

-- world
fBulletTime = { legacyName = "Timescale", configString = "timer", hostOnly=true}
fSkipObjective = { legacyName = "Skip Objective", configString = "skipobjective", hostOnly=true, campaignOnly=true}
fDisableAlarm = { legacyName = "Disable Alarm", configString = "disablealarm", hostOnly=true, campaignOnly=true}
fDisableRobots = { legacyName = "Disable Robots", configString = "disablerobots", hostOnly=true}
fDisablePhysics = { legacyName = "Disable Physics", configString = "disablephysics", hostOnly=true}
fForceUpdatePhysics = { legacyName = "Force Update Physics", configString = "forceupdatephysics", hostOnly=true}
fTeleportValuables = { legacyName = "Teleport Valuables", configString = "autocollect", hostOnly=true, campaignOnly=true}
fUnfairValuables = { legacyName = "Unfair Valuables", configString = "inflation", hostOnly=true, campaignOnly=true}

-- tools
fStructureRestorer = { legacyName = "Structure Restorer", configString = "structurerestorer", hostOnly=true}
fRubberband = { legacyName = "Rubberband", configString = "rubberband"}
fExplosionBrush = { legacyName = "Explosion Brush", configString = "explosionbrush"}
fFireBrush = { legacyName = "Fire Brush", configString = "firebrush"}
fTeleport = { legacyName = "Teleport", configString = "teleport"}

-- shared sub settings
fSubSpeed = { legacyName = "Speed", configString = "amount"}
fSubBoost = { legacyName = "Boost", configString = "boost"}
fSubScale = {legacyName = "Scale", configString = "scale"}
fSubPatch = {legacyName = "Patch", configString = "patch"}
fSubSize = {legacyName = "Size", configString ="size"}
fMethod = { legacyName = "Method", configString = "method"}
fSubDelay = { legacyName = "Delay", configString = "delay"}

-- 
fAlignmentLR = {legacyName = "Alignment", configString = "alignmentlr"}

-- menu items 
fMenuResetConfig = "Reset Config"
fMenuFinishLevel = "Finish Level"
fMenuActivateRobots = "Activate Robots"
fRegistryTool = "Explore Registry"
fEditorTool = "Editor"
fMenuX = {configString = "MenuX" } 
fMenuY = {configString = "MenuY" }
fInputLock = {configString = "InputLock" }

-- used for legacyMenu_SubSettingCycleList
left_right_string_array = {"left", "right"}
method_instant_smooth = {"instant", "smooth"}
method_pause_stop = {"pause", "stop"}
fontnames = {
  "Roboto Regular",
  "Roboto Bold",
  "Orbitron Regular",
  "Orbitron SemiBold"
}

-- antiaim
fAntiAim = { legacyName = "Anti-Aim", configString = "antiaim"}
fResolver = { legacyName = "Anti-Aim Resolver", configString = "resolver", mpOnly=true, clientOnly=true}

fAntiAimYawModes = {legacyName = "Yaw", configString = "yawmode"}
fSubYawOffset = { legacyName = "Yaw Offset", configString = "yawoffset"}
fSubYawSpeed = { legacyName = "Yaw Speed", configString = "yawspeed"}
fSubYawAmp = { legacyName = "Yaw Amplitude", configString = "yawamp"}

fAntiAimPitchModes = {legacyName = "Pitch", configString = "pitchmode"}
fSubPitchOffset = { legacyName = "Pitch Offset", configString = "pitchoffset"}
fSubPitchSpeed = { legacyName = "Pitch Speed", configString = "pitchspeed"}
fSubPitchAmp = { legacyName = "Pitch Amplitude", configString = "pitchamp"}

antiaim_yaw_modes = {"disabled", "offset", "spin", "oscillate", "jitter", "jitter spin", "debug"} 
antiaim_pitch_modes = {"disabled", "static", "oscillate", "jitter"}
