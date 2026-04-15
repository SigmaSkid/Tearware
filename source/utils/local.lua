-- updated automatically, by the packing script.
fProjectName = "Tearware Github Preview"

-- visuals
fWatermark = { legacyName = "Watermark", configString = "watermark", hostOnly=false}
fFeatureList = { legacyName = "Feature List", configString = "featurelist", hostOnly=false}

fObjectiveEsp = { legacyName = "Objective ESP", configString = "objectiveesp", hostOnly=false}
fOptionalEsp = { legacyName = "Optional ESP", configString = "optionalesp", hostOnly=false}
fValuableEsp = { legacyName = "Valuable ESP", configString = "valueesp", hostOnly=false}
fToolEsp = { legacyName = "Tool ESP", configString = "toolesp", hostOnly=false}
fPlayerGlow = { legacyName = "Player Glow", configString = "playerglow", hostOnly=false}
fActiveGlow = { legacyName = "Active Glow", configString = "activeglow", hostOnly=false}
fRainbowFog = { legacyName = "Colored Fog", configString = "rainbowfog", hostOnly=false}
fPostProcess = { legacyName = "Post Processing", configString = "postprocessing", hostOnly=false}
fWeaponGlow = { legacyName = "Equipped Tool Glow", configString = "weaponglow", hostOnly=false}

-- player
fSpeed = { legacyName = "Speed", configString = "speedhack", hostOnly=false}
fSpider = { legacyName = "Spider", configString = "spider", hostOnly=false}
fFly = { legacyName = "Fly", configString = "fly", hostOnly=false}
fFloorStrafe = { legacyName = "Floor Strafe", configString = "floorstrafe", hostOnly=false}
fJetpack = { legacyName = "Jetpack", configString = "jetpack", hostOnly=false}
fJesus = { legacyName = "Jesus", configString = "jesus", hostOnly=false}
fQuickstop = { legacyName = "Quickstop", configString = "quickstop", hostOnly=false}
fInfiniteAmmo = { legacyName = "Infinite Ammo", configString = "infiniteammo", hostOnly=false}
fSuperStrength = { legacyName = "Super Strength", configString = "superstrength", hostOnly=false}
fGodmode = { legacyName = "Godmode", configString = "godmode", hostOnly=false}

-- world
fBulletTime = { legacyName = "Slowmotion", configString = "timer", hostOnly=true}
fSkipObjective = { legacyName = "Skip Objective", configString = "skipobjective", hostOnly=true}
fDisableAlarm = { legacyName = "Disable Alarm", configString = "disablealarm", hostOnly=true}
fDisableRobots = { legacyName = "Disable Robots", configString = "disablerobots", hostOnly=true}
fDisablePhysics = { legacyName = "Disable Physics", configString = "disablephysics", hostOnly=true}
fForceUpdatePhysics = { legacyName = "Force Update Physics", configString = "forceupdatephysics", hostOnly=true}
fTeleportValuables = { legacyName = "Teleport Valuables", configString = "autocollect", hostOnly=true}
fUnfairValuables = { legacyName = "Unfair Valuables", configString = "inflation", hostOnly=true}

-- tools
fStructureRestorer = { legacyName = "Structure Restorer", configString = "structurerestorer", hostOnly=true}
fRubberband = { legacyName = "Rubberband", configString = "rubberband", hostOnly=false}
fExplosionBrush = { legacyName = "Explosion Brush", configString = "explosionbrush", hostOnly=false}
fFireBrush = { legacyName = "Fire Brush", configString = "firebrush", hostOnly=false}
fTeleport = { legacyName = "Teleport", configString = "teleport", hostOnly=false}

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
fAntiAim = { legacyName = "Anti-Aim", configString = "antiaim", hostOnly=false}

fAntiAimYawModes = {legacyName = "Yaw", configString = "yawmode"}
fSubYawOffset = { legacyName = "Yaw Offset", configString = "yawoffset"}
fSubYawSpeed = { legacyName = "Yaw Speed", configString = "yawspeed"}
fSubYawAmp = { legacyName = "Yaw Amplitude", configString = "yawamp"}

fAntiAimPitchModes = {legacyName = "Pitch", configString = "pitchmode"}
fSubPitchOffset = { legacyName = "Pitch Offset", configString = "pitchoffset"}
fSubPitchSpeed = { legacyName = "Pitch Speed", configString = "pitchspeed"}
fSubPitchAmp = { legacyName = "Pitch Amplitude", configString = "pitchamp"}

antiaim_yaw_modes = {"disabled", "offset", "spin", "oscillate", "jitter", "jitter spin"} 
antiaim_pitch_modes = {"disabled", "static", "oscillate", "jitter"}
