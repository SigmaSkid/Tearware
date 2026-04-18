# Tearware - transitioning to API v2
Teardown cheat inspired by modern game cheats.

Access the menu by pressing Insert in-game or through the pause menu.  
Most features can be assigned keyboard shortcuts, by right clicking on them.  
Remove the shortcut by assigning the "enter" key. 

#### [Steam Workshop Page](https://steamcommunity.com/sharedfiles/filedetails/?id=2798126764) 
#### [Github Page](https://github.com/SigmaSkid/Tearware)

## Features:
### Visuals:
- Feature List 
- Objective ESP&
- Optional ESP& - make this a subsetting of objective esp 
- Valuable ESP&
- Tool ESP&
- Player Glow - confirmed works.
- Equipped Tool Glow
- Active Glow
- Colored Fog*
- Post Processing
- Radar^ - to implement.
- Tracers^ - to implement.
- Box ESP^ - to implement.

### Player:
- Ragebot^ - to implement, also autowall.
- Speed - borked - also add some funny modes to mimic how minecraft hax do it to bypass ACs
- Spider - borked
- Bunnyhop - works in singleplayer | jumps trigger when holding space in tearware menu (only for host) | borked in multiplayer
- Fly - WORKS!
- Floor Strafe - works in singleplayer | networking screws it up in multiplayer, try achieving the same effect with param friction.
- Jetpack - borked - fix and add particles & sound
- Jesus - borked
- Quickstop - borked
- Infinite Ammo - borked, only works if host enables it, and only the weapon host holds. weapon ammo is synced, make this host only.
- Unlock Guns&* - to implement, unlock all weapons in campaign. 
- Super Strength - borked
- Godmode - WORKS!
- No-fall - tested in singleplayer [but no menu button and code not called, but code itself was checked in singleplayer, idk)
- Anti-Aim - WORKS! Minor issue: if AA selected and player connects, it's broken, and needs to be re-enabled.
- Anti-Aim Resolver^ - WORKS! Minor issue if player connects and host already antiaims.

### World:
- Slowmotion* - CONFIRMED WORKS
- Skip Objective&* - CONFIRMED WORKS
- Disable Alarm&* - AUDIO ISSUES ON FIRE ALARM ONLY FOR HOST, also countdown doesn't disappear.
- Disable Robots* - UNTESTED
- Disable Physics* - CONFIRMED WORKS
- Force Update Physics* - CONFIRMED WORKS
- Teleport Valuables&* - WORKS? kinda the valuables are falling and gaining infinite speed, the docs say settransform resets velocity, but it does not do that for clients.
- Unfair Valuables&* - SHOULD WORK, UNTESTED, HOST HAS THE CAMPAIGN SAVE, SO PROBABLY WORKS.
- Rainbow lights - to implement. Get all light objects then apply our rgb to them.

### Tools:
- Structure Restorer* - Needs testing in multiplayer to verify sync on objects returning to inactive state.
- Rubberband - CONFIRMED WORKS
- Teleport - CONFIRMED WORKS
- Explosion Brush - borked
- Fire Brush - borked

### Miscellaneous:
- Registry Explorer

Features marked with '*' are host only.
Features marked with '^' are multiplayer only.
Features marked with '&' are campaign only.

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
1. Make & add the new multiplayer preview image.  

1. Prevent local player and their attachments from glowing in first person perspective.  

1. Player glow respect player color.  GetPlayerColor([playerID])

1. Sync menu open state, so old helper functions for InputDown being false while in menu work again.  
Currently features like bunnyhop trigger while in menu.  

1. Anti-aim, naive freestanding that can be done in both client & server (face away from players?).  

1. Autowall for ragebot.  

1. Throw projectiles/pipebomb in all direction? idk. @unlegitSenpaii keeps crying he wants it.  

1. Add rebinding menu key because @unlegitSenpaii can't afford a full keyboard. No, right shift is not a valid key.  

1. Add sub setting for skip objectives to auto finish level.  

1. Registry explorer, add key button, so we can force silly stuff like hud.hide or something idk.  

1. RAINBOW color modifier CANNOT be disabled. Oops.

1. Resolver works, but if player joins, he doesn't get active AA modes from before his connection.

1. Structure restorer, does not network de-activating objects.
