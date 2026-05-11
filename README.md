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
- Tool ESP&             - [needs confirmation on that specific campaign mission]
- Player Glow           - WORKS SP
- Equipped Tool Glow    - WORKS SP
- Active Glow           - WORKS SP [check for active bodies attached to player models]
- Colored Fog*          - WORKS SP 
- Post Processing       - WORKS SP 

### Player:
- Speed                 - WORKS SP 
- Spider                - WORKS SP [borked multiplayer = SetPlayerVelocity] 
- Bunnyhop              - [borked cfg v2] [borked multiplayer = SetPlayerVelocity] [no menu input check, jumps trigger in menu]
- Fly                   - WORKS SP
- Floor Strafe          - WORKS SP [borked multiplayer = SetPlayerGroundVelocity] works in singleplayer | networking screws it up in multiplayer, try achieving the same effect with param friction.
- Jetpack               - [borked cfg v2] [borked multiplayer = SetPlayerVelocity]
- Jesus                 - WORKS SP [borked multiplayer = SetPlayerVelocity]
- Quickstop             - WORKS SP
- Infinite Ammo         - [borked cfg v2] in mp only works if host enables it, and only the weapon host holds. weapon ammo is synced, make this host only. [is there a way to check if ammo synced between players?]
- Super Strength        - [borked cfg v2] [should be possible. ReleasePlayerGrab being serverside only makes it annoying to port, but the logic itself.. should be fine?]
- Godmode               - WORKS SP
- No-fall               - WORKS SP [borked multiplayer = SetPlayerGroundVelocity]
- Anti-Aim              - WORKS SP [add back sending resolver data]
- Anti-Aim Resolver^    - [borked cfg v2] [explicit request resolver data every 15 seconds as a race condition workaround]

### World:
- Timescale*            - WORKS SP
- Skip Objective&*      - WORKS SP
- Disable Alarm&*       - AUDIO ISSUES ON FIRE ALARM ONLY FOR HOST, also countdown doesn't disappear.
- Disable Robots*       - [needs confirmation on that specific campaign mission]
- Disable Physics*      - WORKS SP
- Force Update Physics* - WORKS SP
- Teleport Valuables&*  - WORKS SP (needs MP testing, might need to setActive false on clients when returning the items.)
- Unfair Valuables&*    - WORKS SP

### Tools:
- Structure Restorer*   - WORKS SP [borked mp, have to set body inactive on clientside]
- Rubberband            - WORKS SP 
- Teleport              - WORKS SP 
- Explosion Brush       - [borked cfg v2]
- Fire Brush            - [borked cfg v2]

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
- Unlock Guns&*         - to implement, unlock all weapons in campaign. 

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


