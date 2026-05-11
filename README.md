# Tearware - transitioning to API v2
Teardown cheat inspired by modern game cheats.

Access the menu by pressing Insert in-game or through the pause menu.  
Most features can be assigned keyboard shortcuts, by right clicking on them.  
Remove the shortcut by assigning the "enter" key. 

#### [Steam Workshop Page](https://steamcommunity.com/sharedfiles/filedetails/?id=2798126764) 
#### [Github Page](https://github.com/SigmaSkid/Tearware)

## Features:
### Visuals:
- Feature List          - WORKS SP 
- Objective ESP&        - WORKS SP 
- Optional ESP&         - WORKS SP 
- Valuable ESP&         - WORKS SP 
- Tool ESP&             - WORKS SP
- Player Glow           - WORKS SP
- Equipped Tool Glow    - WORKS SP
- Active Glow           - WORKS SP
- Colored Fog*          - WORKS SP 
- Post Processing       - WORKS SP 

### Player:
- Speed                 - WORKS SP 
- Spider                - WORKS SP [borked multiplayer = SetPlayerVelocity] 
- Bunnyhop              - WORKS SP [borked multiplayer = SetPlayerVelocity]
- Fly                   - WORKS SP
- Floor Strafe          - WORKS SP [borked multiplayer = SetPlayerGroundVelocity]
- Jetpack               - WORKS SP [borked multiplayer = SetPlayerVelocity]
- Jesus                 - WORKS SP [borked multiplayer = SetPlayerVelocity]
- Quickstop             - WORKS SP
- Infinite Ammo         - WORKS SP
- Super Strength        - WORKS SP
- Godmode               - WORKS SP
- No-fall               - WORKS SP [borked multiplayer = SetPlayerGroundVelocity]
- Anti-Aim              - WORKS SP
- Anti-Aim Resolver^    - NEEDS TESTING

### World:
- Timescale*            - WORKS SP
- Skip Objective&*      - WORKS SP
- Disable Alarm&*       - WORKS SP
- Disable Robots*       - WORKS SP
- Disable Physics*      - WORKS SP
- Force Update Physics* - WORKS SP
- Teleport Valuables&*  - WORKS SP
- Unfair Valuables&*    - WORKS SP

### Tools:
- Structure Restorer*   - WORKS SP
- Rubberband            - WORKS SP 
- Teleport              - WORKS SP 
- Explosion Brush       - WORKS SP 
- Fire Brush            - WORKS SP 

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
1. OPTIMIZATION OF THE MULTIPLAYER STACK.

1. Prevent local player and their attachments from glowing in first person perspective.  

1. Make & add the new multiplayer preview image.  

### Scope creep - low priority todo
- Ragebot^ also autowall.
- Rainbow lights. Get all light objects then apply our rgb to them.
- [unify ESP, GLOW, Tracers, Box ESP for players/objectives/valuables/custom]
- Radar^
- Persistent UUID between multiplayer sessions stored on client, so we can mark friends. [the game doesn't expose unique ids/steam ids of players, it should be different than our secret shared with the server]
- Anti-aim, naive freestanding that can be done in both client & server (face away from players?).  
- Throw projectiles/pipebomb in all direction? idk. @unlegitSenpaii keeps crying he wants it. (implement it yourself moron)
- Go through popular multiplayer mods and check if we can do team detection or features specific to them.
- Host priviledge menu [allow disabling access to features for clients, including client side only features like visuals]
- Spinny tool should be possible again? Maybe? In testing it was broken, I need to check for workarounds.
- Registry explorer, "add key" button, so we can force silly stuff like hud.hide or something idk.  
- Integrate intP

## Final Patch notes, credits, etc for release when ready:
Ported to support API V2 and Multi-Player.  
Due to the new config system.  
Old configs are not compatible.  
I recommend resetting your config to get rid of ghost values if you used previous version of the mod on your current save file.  
Not doing so, won't break anything, but it'll keep the obsolete data.  


New features:  
Anti-Aim
Anti-Aim Resolver
Player Glow
No-Fall

Merged features:  
Fly combined with noclip, using the built-in player fly mode.  


Fixes:
Disable Alarm causing Fire Alarm audio loop.

Rainbow color modifier can now be disabled. 
Thanks [Gunbot](https://steamcommunity.com/profiles/76561198428363041)

Misc:
Slowmotion renamed to Timescale.


