# Tearware - transitioning to API v2
Teardown cheat inspired by modern game cheats.

Access the menu by pressing Insert in-game or through the pause menu.  
Most features can be assigned keyboard shortcuts, by right clicking on them.  
Remove the shortcut by assigning the "enter" key. 

#### [Steam Workshop Page](https://steamcommunity.com/sharedfiles/filedetails/?id=2798126764) 
#### [Github Page](https://github.com/SigmaSkid/Tearware)

## Features:
### Visuals:
- Feature List  - CONFIRMED WORKS
- Objective ESP& - CONFIRMED WORKS
- Optional ESP& - CONFIRMED WORKS
- Valuable ESP& - CONFIRMED WORKS
- Tool ESP& - CONFIRMED WORKS
- Player Glow - UNCONFIRMED WORKS [needs testing in multiplayer.]
- Equipped Tool Glow - CONFIRMED WORKS
- Active Glow - CONFIRMED WORKS [needs check for active bodies attached to player models]
- Colored Fog* - CONFIRMED WORKS [host setting synced with clients]
- Post Processing - CONFIRMED WORKS

### Player:
- Speed - borked [uses SetPlayerVelocity] [possible mp workaround SetPlayerParam("walkingSpeed", speed, playerID) "This value is applied for 1 frame!"]
- Spider - borked [uses SetPlayerVelocity] 
- Bunnyhop - works in singleplayer | jumps trigger when holding space in tearware menu (only for host) | borked in multiplayer [uses SetPlayerVelocity]
- Fly - CONFIRMED WORKS [check if param disableInteract affects collisions, if not, check collisionmask - for noclip]
- Floor Strafe - works in singleplayer | networking screws it up in multiplayer, try achieving the same effect with param friction. [uses SetPlayerVelocity]
- Jetpack - borked [uses SetPlayerVelocity]
- Jesus - borked [uses SetPlayerVelocity]
- Quickstop - borked [uses SetPlayerVelocity]
- Infinite Ammo - borked, only works if host enables it, and only the weapon host holds. weapon ammo is synced, make this host only.
- Super Strength - borked [should be possible. ReleasePlayerGrab being serverside only makes it annoying to port.]
- Godmode - CONFIRMED WORKS
- No-fall@ - Works only in singleplayer, due to velocity/ground-velocity being applied inconcistently in multiplayer [also still the functions aren't called]
- Anti-Aim - WORKS! Minor issue: if AA selected and player connects, it's broken, and needs to be re-enabled. (Some stupid race condition due to caching)
- Anti-Aim Resolver^ - WORKS! Minor issue if player connects and host already antiaims. (Some stupid race condition due to caching)

### World:
- Slowmotion* - CONFIRMED WORKS
- Skip Objective&* - CONFIRMED WORKS
- Disable Alarm&* - AUDIO ISSUES ON FIRE ALARM ONLY FOR HOST, also countdown doesn't disappear.
- Disable Robots* - UNTESTED [should work]
- Disable Physics* - CONFIRMED WORKS
- Force Update Physics* - CONFIRMED WORKS
- Teleport Valuables&* - SEMI-WORKS (needs testing, might need to setActive false on clients when returning the items.)
- Unfair Valuables&* - UNTESTED [should work] (IIRC, if client picks up the valuable it doesn't, not sure while writing this. needs testing.)

### Tools:
- Structure Restorer* - Needs testing in multiplayer to verify sync on objects returning to inactive state.
- Rubberband - CONFIRMED WORKS
- Teleport - CONFIRMED WORKS
- Explosion Brush - borked [should be possible]
- Fire Brush - borked [should be possible]
- Unlock Guns&* - to implement, unlock all weapons in campaign. 

### Miscellaneous:
- Registry Explorer

Features marked with '*' are host only.
Features marked with '^' are multiplayer only.
Features marked with '&' are campaign only.
Features marked with '@' are singleplayer only. [due to API v2 multiplayer limitations]

## Installation
### Steam Workshop (recommended)
Subscribe to the mod through [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=2798126764).
 
### GitHub Release Builds
Download the latest release and unzip it into your local mods folder.  
The path is in the table below.
 
### GitHub Preview Build (git)
Clone the repository directly into your mods folder to get the latest changes.
 
**1. Navigate to your mods folder:**
 
| OS | Path |
|---|---|
| Windows | `~/Documents/Teardown/mods/` |
| Linux | `~/.steam/steam/steamapps/compatdata/1167630/pfx/drive_c/users/steamuser/Documents/Teardown/mods/` |
 
**2. Clone the repository:**
 
```
git clone https://github.com/SigmaSkid/Tearware
```
 
**Alternatively:**
- Use **GitHub Desktop** to clone into the path above.
- Not contributing? You can just **Download as ZIP** and unpack it into the mods folder instead.
 

## Building a release candidate.
Navigate to the github repository and run the pack python script.  
It creates a release folder containing the packaged code.

## Multiplayer debug session / found issues / todos:
1. OPTIMIZATION OF THE MULTIPLAYER STACK ON THE CLIENTSIDE,  
Doing this garbage for every feature is extremely stupid:
```
    local cfgVar = fSpeed
    local enabled = config_GetLocalFeatureState(cfgVar)
    local currentSettings = nil 

    if enabled then 
        currentSettings =
        { 
            baseSpeed = config_GetSubVar(GetFloat,cfgVar, fSubSpeed),
            boostSpeed = config_GetSubVar(GetFloat,cfgVar, fSubBoost)
        }
    end

    if utils_tableCompare(currentSettings, clientGetSyncedSetting(cfgVar)) then 
        return
    end

    clientScreamAtServerPolitely(cfgVar, currentSetting
```
We need to intercept config value changes and only then send update to the server, rather than constantly checking on the client if a value was changed.  
Current system prioritizes reducing bandwidth by doing useless and naive calculations on the clientside.  
(Which was fine as a testing placeholder btw.)   
We already use wrappers for most of this stuff, so it should be straightforward to add.  
So, expand config_UpdateAllFeatureStates, to forward the feature changes to appropriate functions.  
OR, make it proper and forward changes directly to the server.  
Keybinds can only toggle the feature on/off, so it should be only few lines of code to forward the state.  


1. Sync menu open state, so old helper functions for InputDown being false while in menu work again.  
Currently features like bunnyhop trigger while in menu.  

1. For now, get all of the movement features working in single-player again.  
Then figure out if there's a workaround or a way for SetPlayerVelocity to behave in multiplayer. If there isn't, constrain to single-player only.

1. Revamp our isKeyDown functions to support multiplayer, so we can properly test features like speed and spider.
[figure out how teardown does the inputdown for multiplayer.. I hope it's not as bad as it could be.. we might want to cache and network inputs ourselves]

1. Resolver works, but if player joins, he doesn't get active AA modes from before his connection.  
delay networking AA data on player join, and make sure everything is loaded first

1. Structure restorer, does not network de-activating objects.  
call SetActive False on clients, likely needs to be done in update/post-update/tick, rather than on receive call

1. Prevent local player and their attachments from glowing in first person perspective.  

1. Make & add the new multiplayer preview image.  

### Scope creep - low priority todo
- Ragebot^ also autowall.
- Rainbow lights. Get all light objects then apply our rgb to them.
- [unify ESP, GLOW, Tracers, Box ESP for players/objectives/valuables/custom]
- Radar^
- Jetpack sounds & particles.
- Persistent UUID between multiplayer sessions stored on client, so we can mark friends. [the game doesn't expose unique ids/steam ids of players, it should be different than our secret shared with the server]
- Anti-aim, naive freestanding that can be done in both client & server (face away from players?).  
- Throw projectiles/pipebomb in all direction? idk. @unlegitSenpaii keeps crying he wants it. (implement it yourself moron)
- Add rebinding menu key because @unlegitSenpaii can't afford a full keyboard. No, right shift is not a valid key.  (implement it yourself moron)
- Go through popular multiplayer mods and check if we can do team detection or features specific to them.
- Host priviledge menu [allow disabling access to features for clients, including client side only features like visuals]
- Spinny tool should be possible again? Maybe? In testing it was broken, I need to check for workarounds.
- Add sub setting for skip objectives to auto finish level [only autofinish if there are objectives, to prevent glitches in level select].  
- Registry explorer, "add key" button, so we can force silly stuff like hud.hide or something idk.  
- Add a game version check.
- Integrate my performance mod as a feature. [we can expand the performance mod with the new IsBodyVisible API call]
- Recode the menu, in a way that is so damn explicit there's no way a game update breaks the font alignment again.
- Buy the DLCs and make sure the mod works correctly for them? [I really don't want to, but probably should]
- Figure out what the hell that one guy in steam comments in 22 Apr, 2024 meant by "can you add one for the sidequest racing thing so i don't need to race too fast? i keep sliding in vehicles" (I might actually have to play the campaign.)
- Implement long jump feature using "JumpSpeed" player parameter.

## Final Patch notes, credits, etc for release when ready:
Ported to support API V2 and Multi-Player.  
Due to the new config system.  
Old configs are not compatible.  
I recommend resetting your config to get rid of ghost values if you used previous version of the mod on your current save file.  
Not doing so, won't break anything, but it'll keep the obsolete data.  

Rainbow color modifier can now be disabled. 
Thanks [Gunbot](https://steamcommunity.com/profiles/76561198428363041)

New features:  
Anti-Aim
Anti-Aim Resolver
Player Glow
No-Fall

Merged features:  
Fly combined with noclip, using the built-in player fly mode.  




