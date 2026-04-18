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
- Objective ESP
- Optional ESP
- Valuable ESP
- Tool ESP
- Player Glow - confirmed works.
- Equipped Tool Glow
- Active Glow
- Colored Fog*
- Post Processing
- Radar - to implement.
- Tracers - to implement.
- Box ESP - to implement.

### Player:
- Ragebot - to implement, also autowall.
- Speed - borked - also add some funny modes to mimic how minecraft hax do it to bypass ACs
- Spider - borked
- Bunnyhop - works in singleplayer | jumps trigger when holding space in tearware menu
- Fly - WORKS!
- Floor Strafe - WORKS!
- Jetpack - borked - fix and add particles & sound
- Jesus - borked
- Quickstop - borked
- Infinite Ammo - borked, only works if host enables it, and only the weapon host holds. weapon ammo is synced, make this host only.
- Unlock Guns - to implement, unlock all weapons in campaign. 
- Super Strength - borked
- Godmode - WORKS!
- No-fall - *new* tested in singleplayer [but no menu button and code not called, but code itself was checked in singleplayer, idk)
- Anti-Aim - WORKS!
- Anti-Aim Resolver - tested only in single player. 

### World:
- Slowmotion* - CONFIRMED WORKS
- Skip Objective* - CONFIRMED WORKS
- Disable Alarm* - AUDIO ISSUES ON FIRE ALARM ONLY FOR HOST, also countdown doesn't disappear.
- Disable Robots* - UNTESTED
- Disable Physics* - CONFIRMED WORKS
- Force Update Physics* - CONFIRMED WORKS
- Teleport Valuables* - WORKS? kinda the valuables are falling and gaining infinite speed, the docs say settransform resets velocity, but it does not do that for clients.
- Unfair Valuables* - SHOULD WORK, UNTESTED, HOST HAS THE CAMPAIGN SAVE, SO PROBABLY WORKS.

### Tools:
- Structure Restorer* - Needs testing in multiplayer to verify sync on objects returning to inactive state.
- Rubberband - CONFIRMED WORKS
- Teleport - CONFIRMED WORKS
- Explosion Brush - borked
- Fire Brush - borked

### Miscellaneous:
- Registry Explorer

Features marked with '*' are host only.

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

## Multiplayer debug session, found issues:
Anti-aim only visible for host.  
Clients cannot see the anti-aim angle.  

If body is not active, it is not being networked? Could this explain antiaim (prolly not, might have to animate bones on clients)?   
  
Also add that new multiplayer preview image.  

Check for player attachments in both player & active glow.  
Prevent local player attachments from glowing in first person perspective.  
  
Sync menu open state, so old helper functions for InputDown being false while in menu work again.  
Currently features like bunnyhop trigger while in menu.  

Debug anti-aim breaks client collisions, movement is broken. Seems to be fine with normal AA modes.  
Anti-aim, free-standing/arrow keys

Autowall for aimbot.  
Resolver? Only network fake bones to clients?  

Throw projectiles/pipebomb in all direction? idk. @unlegitSenpaii begs me, even tho he won't even play the game with me to test shit.  
Add rebinding menu key because @unlegitSenpaii can't afford a full keyboard  