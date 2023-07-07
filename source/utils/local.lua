-- tearware on top

-- obviously change it before uploading to workshop.
fProjectName = "Tearware Github Preview"

-- visuals
fWatermark = { legacyName = "Watermark", dropdownName = "Watermark", newMenuName = "Watermark", configString = "watermark"}
fFeatureList = { legacyName = "Feature List", dropdownName = "FeatureList", newMenuName = "Feature List", configString = "featurelist", description = "Lists enabled features" }
fObjectiveEsp = { legacyName = "Objective ESP", dropdownName = "Objectives", configString = "objectiveesp", description = "Highlights mandatory objectives"}
fOptionalEsp = { legacyName = "Optional ESP", dropdownName = "Optionals", configString = "optionalesp", description = "Highlights optional objectives"}
fValuableEsp = { legacyName = "Valuable ESP", dropdownName = "Valuables", configString = "valueesp", description = "Highlights valuables"}
fToolEsp = { legacyName = "Tool ESP", dropdownName = "Tools", configString = "toolesp", description = "Highlights tools"}
fActiveGlow = { legacyName = "Active Glow", dropdownName = "ActiveGlow", configString = "activeglow", description = "Highlights active bodies"}
fRainbowFog = { legacyName = "Colored Fog", dropdownName = "ColorFog", configString = "rainbowfog", description = "Changes the color of fog"}
fPostProcess = { legacyName = "Post Processing", dropdownName = "PostProcess", configString = "postprocessing"}
fWeaponGlow = { legacyName = "Tool Glow", dropdownName = "GlowTool", configString = "weaponglow", description = "Highlights held tool"}
fSpinnyTool = { legacyName = "Spinny Tool", dropdownName = "SpinTool", configString = "spinnytool", description = "Makes your tool spin"}

-- player
fSpeed = { legacyName = "Speed", dropdownName = "Speed", configString = "speedhack", description = "Makes you faster"}
fSpider = { legacyName = "Spider", dropdownName = "Spider", configString = "spider", description = "Allows you to climb walls"}
fFly = { legacyName = "Fly", dropdownName = "Fly", configString = "fly", description = "Allows you to fly"}
fNoclip = { legacyName = "Noclip", dropdownName = "Noclip", configString = "noclip", description = "Allows you to noclip"}
fFloorStrafe = { legacyName = "Floor Strafe", dropdownName = "FloorStrafe", configString = "floorstrafe", description = "Disables ground friction"}
fJetpack = { legacyName = "Jetpack", dropdownName = "Jetpack", configString = "jetpack"}
fJesus = { legacyName = "Jesus", dropdownName = "Jesus", configString = "jesus", description = "Let's you turn water into wine"}
fQuickstop = { legacyName = "Quickstop", dropdownName = "Quickstop", configString = "quickstop", description = "Stops your velocity when there is no input"}
fInfiniteAmmo = { legacyName = "Infinite Ammo", dropdownName = "InfAmmo", configString = "infiniteammo", description = "Disables ammo limit"}
fSuperStrength = { legacyName = "Super Strength", dropdownName = "Strength", configString = "superstrength", description = "Allows you to grab all dynamic objects"}
fGodmode = { legacyName = "Godmode", dropdownName = "Godmode", configString = "godmode", description = "Prevents health loss"}

-- world
fBulletTime = { legacyName = "Slowmotion", dropdownName = "Timer", configString = "timer"}
  fBulletTimeScale = {legacyName = "Scale", dropdownName = "", configString = "scale"}
  fBulletTimePatch = {legacyName = "Patch", dropdownName = "", configString = "patch"}
fSkipObjective = { legacyName = "Skip Objective", dropdownName = "NoObjective", configString = "skipobjective", description = "Marks all objectives as completed"}
fDisableAlarm = { legacyName = "Disable Alarm", dropdownName = "NoAlarm", configString = "disablealarm", description = "Disables alarm"}
fDisableRobots = { legacyName = "Disable Robots", dropdownName = "NoRobots", configString = "disablerobots", description = "Disables robots"}
fDisablePhysics = { legacyName = "Disable Physics", dropdownName = "NoPhysics", configString = "disablephysics", description = "Disables dynamic objects"}
fForceUpdatePhysics = { legacyName = "Force Update Physics", dropdownName = "UpdatePhysics", configString = "forceupdatephysics", description = "Updates all dynamic objects"}
fTeleportValuables = { legacyName = "Teleport Valuables", dropdownName = "TpValuables", configString = "autocollect", description = "Teleports all valuables to you"}
fUnfairValuables = { legacyName = "Unfair Valuables", dropdownName = "MoreValue", configString = "inflation", description = "Increases value of all valuables"}

-- tools
fStructureRestorer = { legacyName = "Structure Restorer", dropdownName = "Restorer", configString = "structurerestorer"}
fRubberband = { legacyName = "Rubberband", dropdownName = "Rubberband", configString = "rubberband", description = "Teleports you to your previous position"}
fExplosionBrush = { legacyName = "Explosion Brush", dropdownName = "BoomBrush", configString = "explosionbrush"}
  fExplosionBrushSize = {legacyName = "Size", dropdownName = "", configString ="size"}
fFireBrush = { legacyName = "Fire Brush", dropdownName = "FireBrush", configString = "firebrush"}
fTeleport = { legacyName = "Teleport", dropdownName = "Teleport", configString = "teleport"}

-- shared sub settings
fSubSpeed = { legacyName = "Base Speed", dropdownName = "", configString = "amount"}
fSubBoost = { legacyName = "Boost Speed", dropdownName = "", configString = "boost"}

-- menu items 
fMenuStyle = { legacyName = "Menu Style", dropdownName = "UIStyle", configString = "menustyle", options = {"Legacy", "Dropdown", "Modern"} }
fMenuResetConfig = "Reset Config"
fMenuFinishLevel = "Finish Level"
fMenuActivateRobots = "Activate Robots"
fRegistryTool = "Explore Registry"
fEditorTool = "Editor"