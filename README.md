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
- Player ESP - to implement
- Objective ESP
- Optional ESP
- Valuable ESP
- Tool ESP
- Weapon Glow
- Active Glow
- Colored Fog*
- Post Processing

### Player:
- Speed - borked
- Spider - borked
- Fly
- Floor Strafe - borked
- Jetpack - borked
- Jesus - borked
- Quickstop - borked
- Infinite Ammo - borked
- Super Strength - borked
- Godmode
- Anti-aim - to implement, figure out if it's now possible to manipulate the player model without affecting camera.

### World:
- Slowmotion*
- Skip Objective*
- Disable Alarm*
- Disable Robots*
- Disable Physics*
- Force Update Physics*
- Teleport Valuables*
- Unfair Valuables*
- Performance mod -- to implement, update and integrate intP https://steamcommunity.com/sharedfiles/filedetails/?id=2978347999 (current version removes player models..)

### Tools:
- Structure Restorer*
- Rubberband - borked
- Teleport - borked
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
