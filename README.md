# Tearware - transitioning to API v2
Teardown cheat inspired by modern game cheats.

Add rebinding menu key because @unlegitsenpaii skill isue

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
- Player Glow - WORKS PARTIALLY. CLIENTS NO GLOW, HOST GLOWS IDK. :shrug:
- Equipped Tool Glow
- Active Glow
- Colored Fog*
- Post Processing

### Player:
- Speed - borked
- Spider - borked
- Fly - CANNOT BE DISABLED
- Floor Strafe - borked
- Jetpack - borked
- Jesus - borked
- Quickstop - borked
- Infinite Ammo - ONLY HOST GLOWS D:
- Super Strength - borked
- Godmode - CANNOT BE DISABLED
- Anti-aim - ONLY HOST SEES BONE UPDATES

### World:
- Slowmotion* - CONFIRMED WORKS
- Skip Objective* - CONFIRMED WORKS
- Disable Alarm* - AUDIO ISSUES ON FIRE ALARM ONLY FOR HOST
- Disable Robots* - UNTESTED
- Disable Physics* - CONFIRMED WORKS
- Force Update Physics* - CONFIRMED WORKS
- Teleport Valuables* - CONFIRMED WORKS, REQUIRES SETACTIVE 
- Unfair Valuables* - DIDN"T TEST

### Tools:
- Structure Restorer* - FORGOT TO TEST IN MULTIPLAYER. MIGHT HAVE TO ACTIVATE BODIES TO FORCE UPDATE FOR CLIENTS
- Rubberband - DOES NOT WORK FOR CLIENTS. WORKS FOR HOST
- Teleport - DOES NOT WORK FOR CLIENTS. WORKS FOR HOST
- Explosion Brush - borked
- Fire Brush - borked

### Miscellaneous:
- Registry Explorer

Features marked with '*' are host only.

## Installation. 
### Steam Workshop (recommended)
Subscribe to the mod through [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=2798126764)
### Github Release Builds
Go to releases and unzip the latest build in your local mods folder.  
~/documents/teardown/mods/

## Using the github preview build.
Clone the repository into your local mods folder.  
Console in ~/documents/teardown/mods/
```
git clone https://github.com/SigmaSkid/Tearware
```
or use github desktop.

## Building a release candidate.
Navigate to the github repository and run the pack python script.  
It creates a release folder containing the packaged code.

## Multiplayer debug session, found issues:
Toggling flymode off doesn't work. Toggling godmode off doesn't work. GetParam does not work on clientside.
Anti-aim only works for host, as in, everyone can enable it but only host can see it.
Finish level button works FOR CLIENTS? Make it host only.
If body is not active, it is not being networked? Could this explain antiaim (prolly not, might have to animate bones on clients)? 
Infinite ammo, only works if host enables it and holds the weapon.
Disable alarm audio issues on host, if triggered fire alarm.
Teleport valuables only networks new positions if force update physics.