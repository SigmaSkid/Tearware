# Tearware - transitioning to API v2
Teardown cheat inspired by modern game cheats.

Access the menu by pressing Insert in-game or through the pause menu.  
Most features can be assigned keyboard shortcuts, by right clicking on them.  
Remove the shortcut by assigning the "enter" key. 

#### [Steam Workshop Page](https://steamcommunity.com/sharedfiles/filedetails/?id=2798126764) 
#### [Github Page](https://github.com/SigmaSkid/Tearware)

## Features:
### Visuals:
- Feature List          - WORKS SP|MP 
- Objective ESP&        - WORKS SP|MP
- Optional ESP&         - WORKS SP|MP
- Valuable ESP&         - WORKS SP|MP 
- Tool ESP&             - WORKS SP|MP
- Player Glow           - WORKS SP|MP
- Equipped Tool Glow    - WORKS SP|MP
- Active Glow           - WORKS SP|MP
- Colored Fog*          - WORKS SP|MP
- Post Processing       - WORKS SP|MP

### Player:
- Speed                 - WORKS SP|MP
- Spider                - WORKS SP|MP 
- Bunnyhop              - WORKS SP|MP
- Fly                   - WORKS SP|MP
- Floor Strafe          - WORKS SP|MP
- Jetpack               - WORKS SP|MP
- Jesus                 - WORKS SP|MP
- Quickstop             - WORKS SP|MP
- Infinite Ammo         - WORKS SP|MP
- Super Strength        - WORKS SP|MP
- Godmode               - WORKS SP|MP
- No-fall               - WORKS SP|MP
- Anti-Aim              - WORKS SP|MP
- Anti-Aim Resolver^    - BORKED

### World:
- Timescale*            - WORKS SP|MP
- Skip Objective&*      - WORKS SP|MP
- Disable Alarm&*       - WORKS SP|MP
- Disable Robots*       - WORKS SP|MP
- Disable Physics*      - WORKS SP|MP
- Force Update Physics* - WORKS SP|MP
- Teleport Valuables&*  - WORKS SP|MP
- Unfair Valuables&*    - WORKS SP|MP

### Tools:
- Structure Restorer*   - WORKS SP|MP
- Rubberband            - WORKS SP|MP
- Teleport              - WORKS SP|MP
- Explosion Brush       - WORKS SP|MP
- Fire Brush            - WORKS SP|MP

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
1. Resolver does not work. :/
1. Host needs resolver? But only sometimes?
1. Anti-aim being disabled is not networked, so resolver sometimes shows fake antiaim.
1. Unfair valuables, the tags are networked only when loading the map, client has to manually SetTag otherwise.
1. Structure restorer, maybe

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
- Fix DESYNC between host and clients.

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


