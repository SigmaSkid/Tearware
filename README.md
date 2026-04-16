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
- Player Glow - WORKS PARTIALLY. CLIENTS NO GLOW, HOST GLOWS IDK. potential fix? not tested
- Equipped Tool Glow
- Active Glow
- Colored Fog*
- Post Processing

### Player:
- Speed - borked
- Spider - borked
- Bunnyhop - to implement, hold spacebar to continue jumping, also boost slider for it, to allow extra speed gain.
- Fly - fixed? not confirmed
- Floor Strafe - borked
- Jetpack - borked
- Jesus - borked
- Quickstop - borked
- Infinite Ammo - borked, only works if host enables it, and only the weapon host holds. weapon ammo is synced, make this host only.
- Super Strength - borked
- Godmode - fixed? not confirmed
- Anti-aim - ONLY HOST SEES BONE UPDATES, hard to test solo. :shrug: might either need to animate on clients too, or maybe setactive fixes it? idk.

### World:
- Slowmotion* - CONFIRMED WORKS
- Skip Objective* - CONFIRMED WORKS
- Disable Alarm* - AUDIO ISSUES ON FIRE ALARM ONLY FOR HOST, also countdown doesn't disappear.
- Disable Robots* - UNTESTED
- Disable Physics* - CONFIRMED WORKS
- Force Update Physics* - CONFIRMED WORKS
- Teleport Valuables* - fixed? not confirmed
- Unfair Valuables* - DIDN"T TEST

### Tools:
- Structure Restorer* - fixed? not confirmed
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
Anti-aim only works for host, as in, everyone can enable it but only host can see it.  
If body is not active, it is not being networked? Could this explain antiaim (prolly not, might have to animate bones on clients)?  
Figure out if clients respect server hitboxes, or if a local hit counts, (fake angles?)
Finish level button works FOR CLIENTS? Make it host only.  

Testing build workshop:  
https://steamcommunity.com/sharedfiles/filedetails/?id=3707414940  
  
Add rebinding menu key because @unlegitsenpaii can't afford a full keyboard  

Also add that new multiplayer preview image.  

Check for player attachments in both player & active glow.  
Prevent local player attachments from glowing in first person perspective.  