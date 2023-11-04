# Table of Contents

- [Table of Contents](#table-of-contents)
- [Teardown scripting](#teardown-scripting)
- [Parameters](#parameters)
  - [GetIntParam](#getintparam)
  - [GetFloatParam](#getfloatparam)
  - [GetBoolParam](#getboolparam)
  - [GetStringParam](#getstringparam)
- [Script control](#script-control)
  - [GetVersion](#getversion)
  - [HasVersion](#hasversion)
  - [GetTime](#gettime)
  - [GetTimeStep](#gettimestep)
  - [InputLastPressedKey](#inputlastpressedkey)
  - [InputPressed](#inputpressed)
  - [InputReleased](#inputreleased)
  - [InputDown](#inputdown)
  - [InputValue](#inputvalue)
  - [SetValue](#setvalue)
  - [PauseMenuButton](#pausemenubutton)
  - [StartLevel](#startlevel)
  - [SetPaused](#setpaused)
  - [Restart](#restart)
  - [Menu](#menu)
- [Registry](#registry)
  - [ClearKey](#clearkey)
  - [ListKeys](#listkeys)
  - [HasKey](#haskey)
  - [SetInt](#setint)
  - [GetInt](#getint)
  - [SetFloat](#setfloat)
  - [GetFloat](#getfloat)
  - [SetBool](#setbool)
  - [GetBool](#getbool)
  - [SetString](#setstring)
  - [GetString](#getstring)
- [Vector math](#vector-math)
  - [Vec](#vec)
  - [VecCopy](#veccopy)
  - [VecLength](#veclength)
  - [VecNormalize](#vecnormalize)
  - [VecScale](#vecscale)
  - [VecAdd](#vecadd)
  - [VecSub](#vecsub)
  - [VecDot](#vecdot)
  - [VecCross](#veccross)
  - [VecLerp](#veclerp)
  - [Quat](#quat)
  - [QuatCopy](#quatcopy)
  - [QuatAxisAngle](#quataxisangle)
  - [QuatEuler](#quateuler)
  - [GetQuatEuler](#getquateuler)
  - [QuatLookAt](#quatlookat)
  - [QuatSlerp](#quatslerp)
  - [QuatRotateQuat](#quatrotatequat)
  - [QuatRotateVec](#quatrotatevec)
  - [Transform](#transform)
  - [TransformCopy](#transformcopy)
  - [TransformToParentTransform](#transformtoparenttransform)
  - [TransformToLocalTransform](#transformtolocaltransform)
  - [TransformToParentVec](#transformtoparentvec)
  - [TransformToLocalVec](#transformtolocalvec)
  - [TransformToParentPoint](#transformtoparentpoint)
  - [TransformToLocalPoint](#transformtolocalpoint)
- [Entity](#entity)
  - [SetTag](#settag)
  - [RemoveTag](#removetag)
  - [HasTag](#hastag)
  - [GetTagValue](#gettagvalue)
  - [ListTags](#listtags)
  - [GetDescription](#getdescription)
  - [SetDescription](#setdescription)
  - [Delete](#delete)
  - [IsHandleValid](#ishandlevalid)
  - [GetEntityType](#getentitytype)
- [Body](#body)
  - [FindBody](#findbody)
  - [FindBodies](#findbodies)
  - [GetBodyTransform](#getbodytransform)
  - [SetBodyTransform](#setbodytransform)
  - [GetBodyMass](#getbodymass)
  - [IsBodyDynamic](#isbodydynamic)
  - [SetBodyDynamic](#setbodydynamic)
  - [SetBodyVelocity](#setbodyvelocity)
  - [GetBodyVelocity](#getbodyvelocity)
  - [GetBodyVelocityAtPos](#getbodyvelocityatpos)
  - [SetBodyAngularVelocity](#setbodyangularvelocity)
  - [GetBodyAngularVelocity](#getbodyangularvelocity)
  - [IsBodyActive](#isbodyactive)
  - [SetBodyActive](#setbodyactive)
  - [ApplyBodyImpulse](#applybodyimpulse)
  - [GetBodyShapes](#getbodyshapes)
  - [GetBodyVehicle](#getbodyvehicle)
  - [GetBodyBounds](#getbodybounds)
  - [GetBodyCenterOfMass](#getbodycenterofmass)
  - [IsBodyVisible](#isbodyvisible)
  - [IsBodyBroken](#isbodybroken)
  - [IsBodyJointedToStatic](#isbodyjointedtostatic)
  - [DrawBodyOutline](#drawbodyoutline)
  - [DrawBodyHighlight](#drawbodyhighlight)
  - [GetBodyClosestPoint](#getbodyclosestpoint)
  - [ConstrainVelocity](#constrainvelocity)
  - [ConstrainAngularVelocity](#constrainangularvelocity)
  - [ConstrainPosition](#constrainposition)
  - [ConstrainOrientation](#constrainorientation)
  - [GetWorldBody](#getworldbody)
- [Shape](#shape)
  - [FindShape](#findshape)
  - [FindShapes](#findshapes)
  - [GetShapeLocalTransform](#getshapelocaltransform)
  - [SetShapeLocalTransform](#setshapelocaltransform)
  - [GetShapeWorldTransform](#getshapeworldtransform)
  - [GetShapeBody](#getshapebody)
  - [GetShapeJoints](#getshapejoints)
  - [GetShapeLights](#getshapelights)
  - [GetShapeBounds](#getshapebounds)
  - [SetShapeEmissiveScale](#setshapeemissivescale)
  - [GetShapeMaterialAtPosition](#getshapematerialatposition)
  - [GetShapeMaterialAtIndex](#getshapematerialatindex)
  - [GetShapeSize](#getshapesize)
  - [GetShapeVoxelCount](#getshapevoxelcount)
  - [IsShapeVisible](#isshapevisible)
  - [IsShapeBroken](#isshapebroken)
  - [DrawShapeOutline](#drawshapeoutline)
  - [DrawShapeHighlight](#drawshapehighlight)
  - [SetShapeCollisionFilter](#setshapecollisionfilter)
  - [CreateShape](#createshape)
  - [ClearShape](#clearshape)
  - [ResizeShape](#resizeshape)
  - [SetShapeBody](#setshapebody)
  - [CopyShapeContent](#copyshapecontent)
  - [CopyShapePalette](#copyshapepalette)
  - [GetShapePalette](#getshapepalette)
  - [GetShapeMaterial](#getshapematerial)
  - [SetBrush](#setbrush)
  - [DrawShapeLine](#drawshapeline)
  - [DrawShapeBox](#drawshapebox)
  - [ExtrudeShape](#extrudeshape)
  - [TrimShape](#trimshape)
  - [SplitShape](#splitshape)
  - [MergeShape](#mergeshape)
  - [GetShapeClosestPoint](#getshapeclosestpoint)
  - [IsShapeTouching](#isshapetouching)
- [Location](#location)
  - [FindLocation](#findlocation)
  - [FindLocations](#findlocations)
  - [GetLocationTransform](#getlocationtransform)
- [Joint](#joint)
  - [FindJoint](#findjoint)
  - [FindJoints](#findjoints)
  - [IsJointBroken](#isjointbroken)
  - [GetJointType](#getjointtype)
  - [GetJointOtherShape](#getjointothershape)
  - [GetJointShapes](#getjointshapes)
  - [SetJointMotor](#setjointmotor)
  - [SetJointMotorTarget](#setjointmotortarget)
  - [GetJointLimits](#getjointlimits)
  - [GetJointMovement](#getjointmovement)
  - [GetJointedBodies](#getjointedbodies)
  - [DetachJointFromShape](#detachjointfromshape)
- [Light](#light)
  - [FindLight](#findlight)
  - [FindLights](#findlights)
  - [SetLightEnabled](#setlightenabled)
  - [SetLightColor](#setlightcolor)
  - [SetLightIntensity](#setlightintensity)
  - [GetLightTransform](#getlighttransform)
  - [GetLightShape](#getlightshape)
  - [IsLightActive](#islightactive)
  - [IsPointAffectedByLight](#ispointaffectedbylight)
- [Trigger](#trigger)
  - [FindTrigger](#findtrigger)
  - [FindTriggers](#findtriggers)
  - [GetTriggerTransform](#gettriggertransform)
  - [SetTriggerTransform](#settriggertransform)
  - [GetTriggerBounds](#gettriggerbounds)
  - [IsBodyInTrigger](#isbodyintrigger)
  - [IsVehicleInTrigger](#isvehicleintrigger)
  - [IsShapeInTrigger](#isshapeintrigger)
  - [IsPointInTrigger](#ispointintrigger)
  - [IsTriggerEmpty](#istriggerempty)
  - [GetTriggerDistance](#gettriggerdistance)
  - [GetTriggerClosestPoint](#gettriggerclosestpoint)
- [Screen](#screen)
  - [FindScreen](#findscreen)
  - [FindScreens](#findscreens)
  - [SetScreenEnabled](#setscreenenabled)
  - [IsScreenEnabled](#isscreenenabled)
  - [GetScreenShape](#getscreenshape)
- [Vehicle](#vehicle)
  - [FindVehicle](#findvehicle)
  - [FindVehicles](#findvehicles)
  - [GetVehicleTransform](#getvehicletransform)
  - [GetVehicleBody](#getvehiclebody)
  - [GetVehicleHealth](#getvehiclehealth)
  - [GetVehicleDriverPos](#getvehicledriverpos)
  - [DriveVehicle](#drivevehicle)
- [Player](#player)
  - [GetPlayerPos](#getplayerpos)
  - [GetPlayerTransform](#getplayertransform)
  - [SetPlayerTransform](#setplayertransform)
  - [SetPlayerGroundVelocity](#setplayergroundvelocity)
  - [GetPlayerCameraTransform](#getplayercameratransform)
  - [SetPlayerCameraOffsetTransform](#setplayercameraoffsettransform)
  - [SetPlayerSpawnTransform](#setplayerspawntransform)
  - [GetPlayerVelocity](#getplayervelocity)
  - [SetPlayerVehicle](#setplayervehicle)
  - [SetPlayerVelocity](#setplayervelocity)
  - [GetPlayerVehicle](#getplayervehicle)
  - [GetPlayerGrabShape](#getplayergrabshape)
  - [GetPlayerGrabBody](#getplayergrabbody)
  - [ReleasePlayerGrab](#releaseplayergrab)
  - [GetPlayerPickShape](#getplayerpickshape)
  - [GetPlayerPickBody](#getplayerpickbody)
  - [GetPlayerInteractShape](#getplayerinteractshape)
  - [GetPlayerInteractBody](#getplayerinteractbody)
  - [SetPlayerScreen](#setplayerscreen)
  - [GetPlayerScreen](#getplayerscreen)
  - [SetPlayerHealth](#setplayerhealth)
  - [GetPlayerHealth](#getplayerhealth)
  - [RespawnPlayer](#respawnplayer)
  - [RegisterTool](#registertool)
  - [GetToolBody](#gettoolbody)
  - [SetToolTransform](#settooltransform)
- [Sound](#sound)
  - [LoadSound](#loadsound)
  - [LoadLoop](#loadloop)
  - [PlaySound](#playsound)
  - [PlayLoop](#playloop)
  - [PlayMusic](#playmusic)
  - [StopMusic](#stopmusic)
- [Sprite](#sprite)
  - [LoadSprite](#loadsprite)
  - [DrawSprite](#drawsprite)
- [Scene queries](#scene-queries)
  - [QueryRequire](#queryrequire)
  - [QueryRejectVehicle](#queryrejectvehicle)
  - [QueryRejectBody](#queryrejectbody)
  - [QueryRejectShape](#queryrejectshape)
  - [QueryRaycast](#queryraycast)
  - [QueryClosestPoint](#queryclosestpoint)
  - [QueryAabbShapes](#queryaabbshapes)
  - [QueryAabbBodies](#queryaabbbodies)
  - [QueryPath](#querypath)
  - [AbortPath](#abortpath)
  - [GetPathState](#getpathstate)
  - [GetPathLength](#getpathlength)
  - [GetPathPoint](#getpathpoint)
  - [GetLastSound](#getlastsound)
  - [IsPointInWater](#ispointinwater)
  - [GetWindVelocity](#getwindvelocity)
- [Particles](#particles)
  - [ParticleReset](#particlereset)
  - [ParticleType](#particletype)
  - [ParticleTile](#particletile)
  - [ParticleColor](#particlecolor)
  - [ParticleRadius](#particleradius)
  - [ParticleAlpha](#particlealpha)
  - [ParticleGravity](#particlegravity)
  - [ParticleDrag](#particledrag)
  - [ParticleEmissive](#particleemissive)
  - [ParticleRotation](#particlerotation)
  - [ParticleStretch](#particlestretch)
  - [ParticleSticky](#particlesticky)
  - [ParticleCollide](#particlecollide)
  - [ParticleFlags](#particleflags)
  - [SpawnParticle](#spawnparticle)
- [Spawning](#spawning)
  - [Spawn](#spawn)
- [Miscellaneous](#miscellaneous)
  - [Shoot](#shoot)
  - [Paint](#paint)
  - [MakeHole](#makehole)
  - [Explosion](#explosion)
  - [SpawnFire](#spawnfire)
  - [GetFireCount](#getfirecount)
  - [QueryClosestFire](#queryclosestfire)
  - [QueryAabbFireCount](#queryaabbfirecount)
  - [RemoveAabbFires](#removeaabbfires)
  - [GetCameraTransform](#getcameratransform)
  - [SetCameraTransform](#setcameratransform)
  - [SetCameraFov](#setcamerafov)
  - [SetCameraDof](#setcameradof)
  - [PointLight](#pointlight)
  - [SetTimeScale](#settimescale)
- [Environment](#Environment)
  - [SetEnvironmentDefault](#setenvironmentdefault)
  - [SetEnvironmentProperty](#setenvironmentproperty)
  - [GetEnvironmentProperty](#getenvironmentproperty)
- [PostProcessing](#postprocessing)
  - [SetPostProcessingDefault](#setpostprocessingdefault)
  - [SetPostProcessingProperty](#setpostprocessingproperty)
  - [GetPostProcessingProperty](#getpostprocessingproperty)
- [Debug](#debug)
  - [DrawLine](#drawline)
  - [DebugLine](#debugline)
  - [DebugCross](#debugcross)
  - [DebugWatch](#debugwatch)
  - [DebugPrint](#debugprint)
- [User Interface](#user-interface)
  - [UiMakeInteractive](#uimakeinteractive)
  - [UiPush](#uipush)
  - [UiPop](#uipop)
  - [UiWidth](#uiwidth)
  - [UiHeight](#uiheight)
  - [UiCenter](#uicenter)
  - [UiMiddle](#uimiddle)
  - [UiColor](#uicolor)
  - [UiColorFilter](#uicolorfilter)
  - [UiTranslate](#uitranslate)
  - [UiRotate](#uirotate)
  - [UiScale](#uiscale)
  - [UiWindow](#uiwindow)
  - [UiSafeMargins](#uisafemargins)
  - [UiAlign](#uialign)
  - [UiModalBegin](#uimodalbegin)
  - [UiModalEnd](#uimodalend)
  - [UiDisableInput](#uidisableinput)
  - [UiEnableInput](#uienableinput)
  - [UiReceivesInput](#uireceivesinput)
  - [UiGetMousePos](#uigetmousepos)
  - [UiIsMouseInRect](#uiismouseinrect)
  - [UiWorldToPixel](#uiworldtopixel)
  - [UiPixelToWorld](#uipixeltoworld)
  - [UiBlur](#uiblur)
  - [UiFont](#uifont)
  - [UiFontHeight](#uifontheight)
  - [UiText](#uitext)
  - [UiGetTextSize](#uigettextsize)
  - [UiWordWrap](#uiwordwrap)
  - [UiTextOutline](#uitextoutline)
  - [UiTextShadow](#uitextshadow)
  - [UiRect](#uirect)
  - [UiImage](#uiimage)
  - [UiGetImageSize](#uigetimagesize)
  - [UiImageBox](#uiimagebox)
  - [UiSound](#uisound)
  - [UiSoundLoop](#uisoundloop)
  - [UiMute](#uimute)
  - [UiButtonImageBox](#uibuttonimagebox)
  - [UiButtonHoverColor](#uibuttonhovercolor)
  - [UiButtonPressColor](#uibuttonpresscolor)
  - [UiButtonPressDist](#uibuttonpressdist)
  - [UiTextButton](#uitextbutton)
  - [UiImageButton](#uiimagebutton)
  - [UiBlankButton](#uiblankbutton)
  - [UiSlider](#uislider)
  - [UiGetScreen](#uigetscreen)

# Teardown scripting

Teardown allegedly uses Lua version 5.1 as scripting language.  
The Lua 5.1 reference manual can be found [here](https://www.lua.org/manual/5.1/).  
Each Teardown script runs in its own Lua context and can only interact with the engine and other scripts through API functions and the registry.  
The registry is a database of hierarchical global variables that is used both internally in the engine, for communication between scripts and as a way to save persistent data.

The Teardown API uses only native lua types.  
Handles to objects are plain Lua numbers.  
Vector types are represented as plain Lua tables, and so on.  
Each script has four callback functions. 


| Function | Description |
| ------ | -------- |
| function init() | Called once at load time |
| function tick(dt) | Called exactly once per frame. deltaTime between 0.0 and 0.033.. |
| function update(dt) | Called at a fixed update rate, but at the most two times per frame. deltaTime is always 0.016.. (60TPS). Depending on frame rate it might not be called at all for a particular frame. |
| function draw(dt) | Called when the 2D overlay is being draw, after the scene but before the standard HUD. Ui functions can only be used from this callback. Exception: You can call ui functions e.g. to calculate text bounds, anywhere. Can be useful for caching text offsets in init. deltaTime between 0.0 and 0.033.. |
 
Yes, ticks are dynamic while updates are fixed.  
For your own sanity I recommend making your own functions to wrap them.  
  
Don't define functions like this:
```lua
myFunctions = {}
myFunctions.funny = function() 
-- it does stuff.
end
```
While it may appear to be supported, convenient, is supported by lua, and might work in most cases.  
Teardowns quickload functionality will remove all of your functions.  
Don't worry! It's not getting fixed. So, just avoid doing it this way.  
[Read More](https://github.com/Teardown-Issue-Tracker-Maintainers/Teardown-Issue-Tracker/issues/5)

Your global mods entry point is "main.lua"  
You can include other scripts using  
```lua
#include "folder/script.lua"
```

To be able to setup mod settings in the main menu mod selector.  
You can use an "options.lua" file.  
However, you cannot include other files in "options.lua"  
If you do, expect an "unexpected symbol near #" error.  
So have fun coding a settings screen in 1 file just for this.  

# Parameters

Scripts can have parameters defined in the level XML file. These serve as input to a specific instance of the script and can be used to configure various options and parameters of the script. While these parameters can be read at any time in the script, it's recommended to copy them to a global variable in or outside the init function.  
(If you're not making a map, then you don't care about this, I don't)  

## GetIntParam
Arguments:
- name (string) - Parameter name
- default (int) - Default parameter value
Return value:
- value (int) - Parameter value
```lua
--Retrieve blinkcount parameter, or set to 5 if omitted
parameterBlinkCount = GetIntParam("blinkcount", 5)
```

## GetFloatParam
Arguments:
- name (string) - Parameter name
- default (float) - Default parameter value
Return value:
- value (float) - Parameter value
```lua
--Retrieve speed parameter, or set to 10.0 if omitted
parameterSpeed = GetFloatParam("speed", 10.0)
```

## GetBoolParam
Arguments:
- name (string) - Parameter name
- default (boolean) - Default parameter value
Return value:
- value (boolean) - Parameter value
```lua
--Retrieve playsound parameter, or false if omitted
parameterPlaySound = GetBoolParam("playsound", false)
```

## GetStringParam
Arguments:
- name (string) - Parameter name
- default (string) - Default parameter value
Return value:
- value (string) - Parameter value
```lua
--Retrieve mode parameter, or "idle" if omitted
parameterMode = GetSrtingParam("mode", "idle")
```

# Script control

General functions that control the operation and flow of the script.
| Physical input | Description |
| ------ | -------- |
| esc | Escape key |
| tab | Tab key |
| lmb | Left mouse button |
| rmb | Right mouse button |
| mmb | Middle mouse button |
| uparrow | Up arrow key |
| downarrow | Down arrow key |
| leftarrow | Left arrow key |
| rightarrow | Right arrow key |
| f1-f12 | Function keys |
| backspace | Backspace key |
| alt | Alt key |
| delete | Delete key |
| home | Home key |
| end | End key |
| pgup | Pgup key |
| pgdown | Pgdown key |
| insert | Insert key |
| space | Space bar |
| shift | Shift key |
| ctrl | Ctrl key |
| return | Enter key |
| any | Any key or button |
| a,b,c,... | Latin, alphabetical keys a through z |
| 0-9 | Digits, zero to nine |
| mousedx | Mouse horizontal diff. Only valid in InputValue. |
| mousedy | Mouse vertical diff. Only valid in InputValue. |
| mousewheel | Mouse wheel. Only valid in InputValue. |

Numpad, Mouse4, Mouse5 and many keys like []\'; etc. don't appear to be parsed by the game, or get parsed incorrectly.  
Not all of the keys that work with InputDown, work with InputLastPressedKey. Be wary.  

| Logical input | Description |
| ------ | -------- |
| up | Move forward / Accelerate |
| down | Move backward / Brake |
| left | Move left |
| right | Move right |
| interact | Interact |
| flashlight | Flashlight |
| jump | Jump |
| crouch | Crouch |
| usetool | Use tool |
| grab | Grab |
| handbrake | Handbrake |
| map | Map |
| pause | Pause game (escape) |
| vehicleraise | Raise vehicle parts |
| vehiclelower | Lower vehicle parts |
| vehicleaction | Vehicle action |
| camerax | Camera x movement, scaled by sensitivity. Only valid in InputValue. |
| cameray | Camera y movement, scaled by sensitivity. Only valid in InputValue. |

## GetVersion
Return value:  
- version (string) – Dot separated string of current version of the game
```lua
local v = GetVersion()
--v is "1.4.0"
```

## HasVersion
Arguments:  
- version (string) - Reference version. e.g. "1.4.0"  
  
Return value:  
- match (boolean) - True if current version as at least provided one.
```lua
if not HasVersion("1.4.0") then 
    DebugPrint("lmao update your game pirate")
end
```

## GetTime
Return value:
- time (float) – The time in seconds since level was started

Returns running time of this script.  
```lua
local t = GetTime()
```

## GetTimeStep
Return value:
- dt (float) – The timestep in seconds  
  
Literally just deltaTime. Why call this function ever? No clue. But hey, it exists.  
Remember to call it in update to get the (1/60) constant.
```lua
local dt = GetTimeStep()
```

## InputLastPressedKey
Return value:
- name (string) – Name of last pressed key, empty if no key is pressed  

```lua
name = InputLastPressedKey()
```

## InputPressed
Arguments:
- input (string) – The input identifier

Return value:
- pressed (boolean) – True if input was pressed during last frame

```lua
if InputPressed("interact") then
	...
end
```


## InputReleased
Arguments:
- input (string) – The input identifier

Return value:
- pressed (boolean) – True if input was released during last frame

```lua
if InputReleased("interact") then
	...
end
```

## InputDown
Arguments:
- input (string) – The input identifier

Return value:
- pressed (boolean) – True if input is currently held down

```lua
if InputDown("interact") then
...
end
```

## InputValue
Arguments:
- input (string) – The input identifier

Return value:
- value (number) – Depends on input type

```lua
scrollPos = scrollPos + InputValue("mousewheel")
```

## SetValue
Arguments:
- variable (string) – Name of number variable in the global context
- value (number) – The new value
- transition (string, optional) – Transition type. See description.
- time (number, optional) – Transition time (seconds)

Set value of a number variable in the global context with an optional transition.  
If a transition is provided the value will animate from current value to the new value during the transition time.  
Transition can be one of the following: 

| Transition | Description |
| ------ | -------- |
| linear | Linear transition |
| cosine | Slow at beginning and end |
| easein | Slow at beginning |
| easeout | Slow at end |
| bounce | Bounce and overshoot new value |


```lua
myValue = 0
SetValue("myValue", 1, "linear", 0.5)

This will change the value of myValue from 0 to 1 in a linear fashion over 0.5 seconds
```

## PauseMenuButton
Arguments:
- title (string) – Text on button
- primary (bool, optional) – Primary button (only for maps)

Return value:
- clicked (boolean) – True if clicked, false otherwise

Calling this function will add a button on the bottom bar or in the main pause menu (center of the screen) when the game is paused.  
A primary button will be placed in the main pause menu if this function is called from a playable mod.  
Use this as a way to bring up mod settings or other user interfaces while the game is running.  
Call this function every frame from the tick function for as long as the pause menu button should still be visible. 

```lua
function tick(dt)
    if PauseMenuButton(fProjectName) then
		openMenu = "tearware"
    end
end

function draw(dt)
	if openMenu == "tearware" then
		UiMakeInteractive()
        SetBool("game.disablepause", true)
        if InputPressed("pause") then
            openMenu = nil
        end
		...
	end
end
```

## StartLevel
Arguments:
- mission (string) – An identifier of your choice
- path (string) – Path to level XML file
- layers (string, optional) – Active layers. Default is no layers.
- passThrough (boolean, optional) – If set, loading screen will have no text and music will keep playing
 
Start a level.  

```lua
--Start level with no active layers
StartLevel("level1", "MOD/level1.xml")

--Start level with two layers
StartLevel("level1", "MOD/level1.xml", "vehicles targets")
```

## SetPaused
Arguments:
- paused (boolean) – True if game should be paused

Set paused state of the game.  
  
Unless you're making a HUD overhaul mod.  
Only argument "true" makes sense.  
Your scripts don't execute while the game is paused.  

```lua
--Pause game and bring up pause menu on HUD
SetPaused(true)
```

## Restart
Restart level 

```lua
if shouldRestart then
    Restart()
end
```

## Menu
Go to main menu 

```lua
if shouldExitLevel then
    Menu()
end
```

# Registry

The Teardown engine uses a global key/value-pair registry that scripts can read and write. The engine exposes a lot of internal information through the registry, but it can also be used as way for scripts to communicate with each other.

The registry is a hierarchical node structure and can store a value in each node (parent nodes can also have a value). The values can be of type floating point number, integer, boolean or string, but all types are automatically converted if another type is requested. Some registry nodes are reserved and used for special purposes.

Registry node names may only contain the characters a-z, numbers 0-9, dot, dash and underscore.

| Key | Description | Write Access |
| ------ | -------- | -------- | 
| options | reserved for game settings | ❌ |
| game | reserved for the game engine internals | ✅ |
| savegame | used for persistent game data | ❌ |
| savegame.mod | used for persistent mod data. Use only alphanumeric character for key name. | ✅ |
| level | not reserved, but recommended for level specific entries and script communication | ✅ |
| promo | undocumented idk | ✅ |
| mods | data about installed mods | ✅ |

## ClearKey
Arguments:
- key (string) – Registry key to clear

Remove registry node, including all child nodes. 
```lua
--If the registry looks like this:
--	score
--		levels
--			level1 = 5
--			level2 = 4

ClearKey("score.levels")

--Afterwards, the registry will look like this:
--	score
```

## ListKeys
Arguments:
- parent (string) – The parent registry key

Return value:
- children (table) – Indexed table of strings with child keys

List all child keys of a registry node. 
```lua
--If the registry looks like this:
--	score
--		levels
--			level1 = 5
--			level2 = 4

local list = ListKeys("score.levels")
for i=1, #list do
	DebugPrint(list[i])
end

--This will output:
--level1
--level2
```

## HasKey
Arguments:
- key (string) - Registry key
  
Return value:
- exists (boolean) - True if key exists

Returns true if the registry contains a certain key 
```lua
local foo = HasKey("score.levels")
```

## SetInt
Arguments:
- key (string) – Registry key
- value (number) – Desired value

```lua
SetInt("score.levels.level1", 4)
```

## GetInt
Arguments:
- key (string) – Registry key

Return value:
- value (number) – Integer value of registry node or zero if not found

```lua
local a = GetInt("score.levels.level1")
```

## SetFloat
Arguments:
- key (string) – Registry key
- value (number) – Desired value

```lua
SetFloat("level.time", 22.3)
```


## GetFloat
Arguments:
- key (string) – Registry key

Return value:
- value (number) – Float value of registry node or zero if not found

```lua
local time = GetFloat("level.time")
```

## SetBool
Arguments:
- key (string) – Registry key
- value (boolean) – Desired value

```lua
SetBool("level.robots.enabled", true)
```

## GetBool
Arguments:
- key (string) – Registry key

Return value:
- value (boolean) – Boolean value of registry node or false if not found

```lua
local isRobotsEnabled = GetBool("level.robots.enabled")
```

## SetString
Arguments:
- key (string) – Registry key
- value (string) – Desired value

```lua
SetString("level.name", "foo")
```

## GetString
Arguments:
- key (string) – Registry key

Return value:
- value (string) – String value of registry node or "" if not found

```lua
local name = GetString("level.name")
```

# Vector math

Vector math is used in Teardown scripts to represent 3D positions, directions, rotations and transforms.  
The base types are vectors, quaternions and transforms.  
Vectors and quaternions are indexed tables with three and four components.  
Transforms are tables consisting of one vector (pos) and one quaternion (rot)

## Vec

Arguments:
- x (number, optional) – X value
- y (number, optional) – Y value
- z (number, optional) – Z value

Return value:
- vec (table) – New vector

Create new vector and optionally initializes it to the provided values.  
A Vec is equivalent to a regular lua table with three numbers.

```lua
--These are equivalent
local a1 = Vec()
local a2 = {0, 0, 0}

--These are equivalent
local b1 = Vec(0, 1, 0)
local b2 = {0, 1, 0}
```

## VecCopy
Arguments:
- org (table) – A vector

Return value:
- new (table) – Copy of org vector

Vectors should never be assigned like regular numbers.  
Since they are implemented with lua tables assignment means two references pointing to the same data.  
Use this function instead.

```lua
--Do this to assign a vector
local right1 = Vec(1, 2, 3)
local right2 = VecCopy(right1)

--Never do this unless you REALLY know what you're doing 
local wrong1 = Vec(1, 2, 3)
local wrong2 = wrong1 -- (this is a pointer to the original table!)
```

## VecLength
Arguments:
- vec (table) – A vector

Return value:
- length (number) – Length (magnitude) of the vector

```lua
local v = Vec(1,1,0)
local l = VecLength(v)

--l now equals 1.41421356
```

## VecNormalize
Arguments:
- vec (table) – A vector

Return value:
- norm (table) – A vector of length 1.0

If the input vector is of zero length, the function returns {0,0,1}

```lua
local v = Vec(0,3,0)
local n = VecNormalize(v)

--n now equals {0,1,0}
```

## VecScale
Arguments:
- vec (table) – A vector
- scale (number) – A scale factor

Return value:
- norm (table) – A scaled version of input vector

```lua
local v = Vec(1,2,3)
local n = VecScale(v, 2)

--n now equals {2,4,6}
```

## VecAdd
Arguments:
- a (table) – Vector
- b (table) – Vector

Return value:
- c (table) – New vector with sum of a and b

```lua
local a = Vec(1,2,3)
local b = Vec(3,0,0)
local c = VecAdd(a, b)

--c now equals {4,2,3}
```

## VecSub
Arguments:
- a (table) – Vector
- b (table) – Vector

Return value:
- c (table) – New vector representing a-b

```lua
local a = Vec(1,2,3)
local b = Vec(3,0,0)
local c = VecSub(a, b)

--c now equals {-2,2,3}
```

## VecDot
Arguments:
- a (table) – Vector
- b (table) – Vector

Return value:
- c (number) – Dot product of a and b

```lua
local a = Vec(1,2,3)
local b = Vec(3,1,0)
local c = VecDot(a, b)

--c now equals 5
```

## VecCross
Arguments:
- a (table) – Vector
- b (table) – Vector

Return value:
- c (table) – Cross product of a and b (also called vector product)

```lua
local a = Vec(1,0,0)
local b = Vec(0,1,0)
local c = VecCross(a, b)

--c now equals {0,0,1}
```

## VecLerp
Arguments:
- a (table) – Vector
- b (table) – Vector
- t (number) – fraction (usually between 0.0 and 1.0)

Return value:
- c (table) – Linearly interpolated vector between a and b, using t

```lua
local a = Vec(2,0,0)
local b = Vec(0,4,2)
local t = 0.5

--These two are equivalent
local c1 = VecLerp(a, b, t)
lcoal c2 = VecAdd(VecScale(a, 1-t), VecScale(b, t))

--c1 and c2 now equals {1, 2, 1}
```

## Quat
Arguments:
- x (number, optional) – X value
- y (number, optional) – Y value
- z (number, optional) – Z value
- w (number, optional) – W value

Return value:
- quat (table) – New quaternion

Create new quaternion and optionally initializes it to the provided values.  
Do not attempt to initialize a quaternion with raw values unless you know what you are doing.  
Use QuatEuler or QuatAxisAngle instead.  
If no arguments are given, a unit quaternion will be created: {0, 0, 0, 1}.  
A quaternion is equivalent to a regular lua table with four numbers.

```lua
--These are equivalent
local a1 = Quat()
local a2 = {0, 0, 0, 1}
```

## QuatCopy
Arguments:
- org (table) – Quaternion

Return value:
- new (table) – Copy of org quaternion

Quaternions should never be assigned like regular numbers.  
Since they are implemented with lua tables assignment means two references pointing to the same data.  
Use this function instead.

```lua
--Do this to assign a quaternion
local right1 = QuatEuler(0, 90, 0)
local right2 = QuatCopy(right1)

--Never do this unless you REALLY know what you're doing
local wrong1 = QuatEuler(0, 90, 0)
local wrong2 = wrong1
```

## QuatAxisAngle
Arguments:
- axis (table) – Rotation axis, unit vector
- angle (number) – Rotation angle in degrees

Return value:
- quat (table) – New quaternion

Create a quaternion representing a rotation around a specific axis

```lua
--Create quaternion representing rotation 30 degrees around Y axis
local q = QuatAxisAngle(Vec(0,1,0), 30)
```

## QuatEuler
Arguments:
- x (number) – Angle around X axis in degrees, sometimes also called roll or bank
- y (number) – Angle around Y axis in degrees, sometimes also called yaw or heading
- z (number) – Angle around Z axis in degrees, sometimes also called pitch or attitude

Return value:
- quat (table) – New quaternion

Create quaternion using euler angle notation.  
The order of applied rotations uses the "NASA standard aeroplane" model:

  1. Rotation around Y axis (yaw or heading)
  2. Rotation around Z axis (pitch or attitude)
  3. Rotation around X axis (roll or bank)

```lua
--Create quaternion representing rotation 30 degrees around Y axis and 25 degrees around Z axis
local q = QuatEuler(0, 30, 25)
```


## GetQuatEuler
Arguments:
- quat (table) – Quaternion

Return value:
- x (number) – Angle around X axis in degrees, sometimes also called roll or bank
- y (number) – Angle around Y axis in degrees, sometimes also called yaw or heading
- z (number) – Angle around Z axis in degrees, sometimes also called pitch or attitude

Return euler angles from quaternion.  
The order of rotations uses the "NASA standard aeroplane" model:

  1. Rotation around Y axis (yaw or heading)
  2. Rotation around Z axis (pitch or attitude)
  3. Rotation around X axis (roll or bank)

```lua
--Return euler angles from quaternion q
rx, ry, rz = GetQuatEuler(q)
```

## QuatLookAt
Arguments:
- eye (table) – Vector representing the camera location
- target (table) – Vector representing the point to look at

Return value:
- quat (table) – New quaternion

Create a quaternion pointing the negative Z axis (forward) towards a specific point, keeping the Y axis upwards.  
This is very useful for creating camera transforms.

```lua
local eye = Vec(0, 10, 0)
local target = Vec(0, 1, 5)
local rot = QuatLookAt(eye, target)
SetCameraTransform(Transform(eye, rot))
```


## QuatSlerp
Arguments:
- a (table) – Quaternion
- b (table) – Quaternion
- t (number) – fraction (usually between 0.0 and 1.0)

Return value:
- c (table) – New quaternion

Spherical, linear interpolation between a and b, using t.  
This is very useful for animating between two rotations.

```lua
local a = QuatEuler(0, 10, 0)
local b = QuatEuler(0, 0, 45)

--Create quaternion half way between a and b
local q = QuatSlerp(a, b, 0.5)
```

## QuatRotateQuat
Arguments:
- a (table) – Quaternion
- b (table) – Quaternion

Return value:
- c (table) – New quaternion

Rotate one quaternion with another quaternion.  
This is mathematically equivalent to c = a * b using quaternion multiplication.

```lua
local a = QuatEuler(0, 10, 0)
local b = QuatEuler(0, 0, 45)
local q = QuatRotateQuat(a, b)

--q now represents a rotation first 10 degrees around
--the Y axis and then 45 degrees around the Z axis.
```


## QuatRotateVec
Arguments:
- a (table) – Quaternion
- vec (table) – Vector

Return value:
- vec (table) – Rotated vector

Rotate a vector by a quaternion

```lua
local q = QuatEuler(0, 10, 0)
local v = Vec(1, 0, 0)
local r = QuatRotateVec(q, v)

--r is now vector a rotated 10 degrees around the Y axis
```

## Transform
Arguments:
- pos (table, optional) – Vector representing transform position
- rot (table, optional) – Quaternion representing transform rotation

Return value:
- transform (table) – New transform

A transform is a regular lua table with two entries: pos and rot, a vector and quaternion representing transform position and rotation.

```lua
--Create transform located at {0, 0, 0} with no rotation
local t1 = Transform()

--Create transform located at {10, 0, 0} with no rotation
local t2 = Transform(Vec(10, 0,0))

--Create transform located at {10, 0, 0}, rotated 45 degrees around Y axis
local t2 = Transform(Vec(10, 0,0), QuatEuler(0, 45, 0))
```


## TransformCopy
Arguments:
- org (table) – Transform

Return value:
- new (table) – Copy of org transform

Transforms should never be assigned like regular numbers.  
Since they are implemented with lua tables assignment means two references pointing to the same data.  
Use this function instead.

```lua
--Do this to assign a quaternion
local right1 = Transform(Vec(1,0,0), QuatEuler(0, 90, 0))
local right2 = TransformCopy(right1)

--Never do this unless you REALLY know what you're doing
local wrong1 = Transform(Vec(1,0,0), QuatEuler(0, 90, 0))
local wrong2 = wrong1
```

## TransformToParentTransform
Arguments:
- parent (table) – Transform
- child (table) – Transform

Return value:
- transform (table) – New transform

Transform child transform out of the parent transform.  
This is the opposite of TransformToLocalTransform.

```lua
local b = GetBodyTransform(body)
local s = GetShapeLocalTransform(shape)

--b represents the location of body in world space
--s represents the location of shape in body space

local w = TransformToParentTransform(b, s)

--w now represents the location of shape in world space
```

## TransformToLocalTransform
Arguments:
- parent (table) – Transform
- child (table) – Transform

Return value:
- transform (table) – New transform

Transform one transform into the local space of another transform.  
This is the opposite of TransformToParentTransform.

```lua
local b = GetBodyTransform(body)
local w = GetShapeWorldTransform(shape)

--b represents the location of body in world space
--w represents the location of shape in world space

local s = TransformToLocalTransform(b, w)

--s now represents the location of shape in body space.
```

## TransformToParentVec
Arguments:
- t (table) – Transform
- v (table) – Vector

Return value:
- r (table) – Transformed vector

Transfom vector v out of transform t only considering rotation.

```lua
local t = GetBodyTransform(body)
local localUp = Vec(0, 1, 0)
local up = TransformToParentVec(t, localUp)

--up now represents the local body up direction in world space
```

## TransformToLocalVec
Arguments:
- t (table) – Transform
- v (table) – Vector

Return value:
- r (table) – Transformed vector

Transfom vector v into transform t only considering rotation.

```lua
local t = GetBodyTransform(body)
local worldUp = Vec(0, 1, 0)
local up = TransformToLocalVec(t, worldUp)

--up now represents the world up direction in local body space
```

## TransformToParentPoint
Arguments:
- t (table) – Transform
- p (table) – Vector representing position

Return value:
- r (table) – Transformed position

Transfom position p out of transform t.

```lua
local t = GetBodyTransform(body)
local bodyPoint = Vec(0, 0, -1)
local p = TransformToParentPoint(t, bodyPoint)

--p now represents the local body point {0, 0, -1 } in world space
```

## TransformToLocalPoint
Arguments:
- t (table) – Transform
- p (table) – Vector representing position

Return value:
- r (table) – Transformed position

Transfom position p into transform t.

```lua
local t = GetBodyTransform(body)
local worldOrigo = Vec(0, 0, 0)
local p = TransformToLocalPoint(t, worldOrigo)

--p now represents the position of world origo in local body space
```

# Entity

An Entity is the basis of most objects in the Teardown engine (bodies, shapes, lights, locations, etc).  
All entities can have tags, which is a way to store custom properties on entities for scripting purposes.  
Some tags are also reserved for engine use. See documentation for details.

## SetTag
Arguments:
- handle (number) – Entity handle
- tag (string) – Tag name
- value (string, optional) – Tag value

```lua
--Add "special" tag to an entity
SetTag(handle, "special")

--Add "team" tag to an entity and give it value "red"
SetTag(handle, "team", "red")
```

## RemoveTag
Arguments:
- handle (number) – Entity handle
- tag (string) – Tag name

Remove tag from an entity.  
If the tag had a value it is removed too.

```lua
RemoveTag(handle, "special")
```

## HasTag
Arguments:
- handle (number) – Entity handle
- tag (string) – Tag name

Return value:
- exists (boolean) – Returns true if entity has tag

```lua
SetTag(handle, "special")
local hasSpecial = HasTag(handle, "special") 
-- hasSpecial will be true
```

## GetTagValue
Arguments:
- handle (number) – Entity handle
- tag (string) – Tag name

Return value:
- value (string) – Returns the tag value, if any. Empty string otherwise.

```lua
SetTag(handle, "special")
value = GetTagValue(handle, "special")
-- value will be ""

SetTag(handle, "special", "foo")
value = GetTagValue(handle, "special")
-- value will be "foo"
```

## ListTags
Arguments:
- handle (number) – Entity handle

Return value:
- tags (table) – Indexed table of tags on entity
```lua
--List all tags and their tag values for a particular entity
local tags = ListTags(handle)
for i=1, #tags do
	DebugPrint(tags[i] .. " " .. GetTagValue(handle, tags[i]))
end
```

## GetDescription
Arguments:
- handle (number) – Entity handle

Return value:
- description (string) – The description string

All entities can have an associated description.  
For bodies and shapes this can be provided through the editor.  
This function retrieves that description.

```lua
local desc = GetDescription(body)
```

## SetDescription
Arguments:
- handle (number) – Entity handle
- description (string) – The description string

All entities can have an associated description.  
The description for bodies and shapes will show up on the HUD when looking at them.
```lua
SetDescription(body, "Target object")
```

## Delete
Arguments:
- handle (number) – Entity handle

Remove an entity from the scene.  
All entities owned by this entity will also be removed.

```lua
Delete(body)
--All shapes associated with body will also be removed
```

## IsHandleValid
Arguments:
- handle (number) – Entity handle

Return value:
- exists (boolean) – Returns true if the entity pointed to by handle still exists

```lua
valid = IsHandleValid(body)

--valid is true if body still exists

Delete(body)
valid = IsHandleValid(body)

--valid will now be false
```

## GetEntityType
Arguments:
- handle (number) – Entity handle

Return value:
- type (string) – Type name of the provided entity

Returns the type name of provided entity, for example "body", "shape", "light", etc.

```lua
local t = GetEntityType(e)
if t == "body" then
	--e is a body handle
end
```

# Body

A body represents a rigid body in the scene.  
It can be either static or dynamic.  
Only dynamic bodies are affected by physics.

## FindBody
Arguments:
- tag (string) – Tag name
- global (boolean, optional) – Search in entire scene

Return value:
- handle (number) – Handle to first body with specified tag or zero if not found
```lua
--Search for a body tagged "target" in script scope
local target = FindBody("target")

--Search for a body tagged "escape" in entire scene
local escape = FindBody("escape", true)
```

## FindBodies
Arguments:
- tag (string) – Tag name
- global (boolean, optional) – Search in entire scene

Return value:
- list (table) – Indexed table with handles to all bodies with specified tag

```lua
--Search for bodies tagged "target" in script scope
local targets = FindBodies("target")
for i=1, #targets do
	local target = targets[i]
	...
end
```

## GetBodyTransform
Arguments:
- handle (number) – Body handle

Return value:
- transform (table) – Transform of the body

```lua
local t = GetBodyTransform(body)
```

## SetBodyTransform
Arguments:
- handle (number) – Body handle
- transform (table) – Desired transform

```lua
--Move a body 1 meter upwards
local t = GetBodyTransform(body)
t.pos = VecAdd(t.pos, Vec(0, 1, 0))
SetBodyTransform(body, t)
```

## GetBodyMass
Arguments:
- handle (number) – Body handle

Return value:
- mass (number) – Body mass. Static bodies always return zero mass.

```lua
local mass = GetBodyMass(body)
```

## IsBodyDynamic
Arguments:
- handle (number) – Body handle

Return value:
- dynamic (boolean) – Return true if body is dynamic

Check if body is dynamic.  
Note that something that was created static may become dynamic due to destruction.

```lua
local dynamic = IsBodyDynamic(body)
```

## SetBodyDynamic
Arguments:
- handle (number) – Body handle
- dynamic (boolean) – True for dynamic. False for static.

Change the dynamic state of a body.  
There is very limited use for this function.  
In most situations you should leave it up to the engine to decide. Use with caution.

```lua
SetBodyDynamic(body, false)
```

## SetBodyVelocity
Arguments:
- handle (number) – Body handle (should be a dynamic body)
- velocity (table) – Vector with linear velocity

This can be used for animating bodies with preserved physical interaction,  
but in most cases you are better off with a motorized joint instead.

```lua
local vel = Vec(2,0,0)
SetBodyVelocity(body, vel)
```

## GetBodyVelocity
Arguments:
- handle (number) – Body handle (should be a dynamic body)

Return value:
- velocity (table) – Linear velocity as vector

```lua
local linVel = GetBodyVelocity(body)
```

## GetBodyVelocityAtPos
Arguments:
- handle (number) – Body handle (should be a dynamic body)
- pos (table) – World space point as vector

Return value:
- velocity (table) – Linear velocity on body at pos as vector

Return the velocity on a body taking both linear and angular velocity into account.

```lua
local vel = GetBodyVelocityAtPos(body, pos)
```

## SetBodyAngularVelocity
Arguments:
- handle (number) – Body handle (should be a dynamic body)
- angVel (table) – Vector with angular velocity

This can be used for animating bodies with preserved physical interaction,  
but in most cases you are better off with a motorized joint instead.

```lua
local angVel = Vec(2,0,0)
SetBodyAngularVelocity(body, angVel)
```

## GetBodyAngularVelocity
Arguments:
- handle (number) – Body handle (should be a dynamic body)

Return value:
- angVel (table) – Angular velocity as vector

```lua
local angVel = GetBodyAngularVelocity(body)
```

## IsBodyActive
Arguments:
- handle (number) – Body handle

Return value:
- active (boolean) – Return true if body is active

Check if body is body is currently simulated.  
For performance reasons, bodies that don't move are taken out of the simulation.  
This function can be used to query the active state of a specific body.  
Only dynamic bodies can be active.

```lua
if IsBodyActive(body) then
	...
end
```

## SetBodyActive
Arguments:
- handle (number) – Body handle
- active (boolean) – Set to true if body should be active (simulated)

This function makes it possible to manually activate and deactivate bodies to include or exclude in simulation.  
The engine normally handles this automatically, so use with care.

```lua
--Wake up body
SetBodyActive(body, true)

--Put body to sleep
SetBodyActive(body, false)
```

## ApplyBodyImpulse
Arguments:
- handle (number) – Body handle (should be a dynamic body)
- position (table) – World space position as vector
- impulse (table) – World space impulse as vector

Apply impulse to dynamic body at position (give body a push).
```lua
local pos = Vec(0,1,0)
local imp = Vec(0,0,10)
ApplyBodyImpulse(body, pos, imp)
```

## GetBodyShapes
Arguments:
- handle (number) – Body handle

Return value:
- list (table) – Indexed table of shape handles

Return handles to all shapes owned by a body

```lua
local shapes = GetBodyShapes(body)
for i=1,#shapes do
	local shape = shapes[i]
end
```

## GetBodyVehicle
Arguments:
- body (number) – Body handle

Return value:
- handle (number) – Get parent vehicle for body, or zero if not part of vehicle

```lua
local vehicle = GetBodyVehicle(body)
```

## GetBodyBounds
Arguments:
- handle (number) – Body handle

Return value:
- min (table) – Vector representing the AABB lower bound
- max (table) – Vector representing the AABB upper bound

Return the world space, axis-aligned bounding box for a body.

```lua
local min, max = GetBodyBounds(body)
local boundsSize = VecSub(max, min)
local center = VecLerp(min, max, 0.5)
```

## GetBodyCenterOfMass
Arguments:
- handle (number) – Body handle

Return value:
- point (table) – Vector representing local center of mass in body space

```lua
--Visualize center of mass on for body
local com = GetBodyCenterOfMass(body)
local worldPoint = TransformToParentPoint(GetBodyTransform(body), com)
DebugCross(worldPoint)
```


## IsBodyVisible
Arguments:
- handle (number) – Body handle
- maxDist (number) – Maximum visible distance
- rejectTransparent (boolean, optional) – See through transparent materials. Default false.

Return value:
- visible (boolean) – Return true if body is visible

This will check if a body is currently visible and not occluded by other objects.

```lua
if IsBodyVisible(body, 25) then
	--Body is within 25 meters visible to the camera
end
```

## IsBodyBroken
Arguments:
- handle (number) – Body handle

Return value:
- broken (boolean) – Return true if body is broken

Determine if any shape of a body has been broken.

```lua
local broken = IsBodyBroken(body)
```

## IsBodyJointedToStatic
Arguments:
- handle (number) – Body handle

Return value:
- result (boolean) – Return true if body is in any way connected to a static body

Determine if a body is in any way connected to a static object,  
either by being static itself or be being directly or indirectly jointed to something static.

```lua
local connectedToStatic = IsBodyJointedToStatic(body)
```

## DrawBodyOutline
Arguments:
- handle (number) – Body handle
- r (number, optional) – Red
- g (number, optional) – Green
- b (number, optional) – Blue
- a (number) – Alpha

Render next frame with an outline around specified body.  
If no color is given, a white outline will be drawn.

```lua
--Draw white outline at 50% transparency
DrawBodyOutline(body, 0.5)

--Draw green outline, fully opaque
DrawBodyOutline(body, 0, 1, 0, 1)
```

## DrawBodyHighlight
Arguments:
- handle (number) – Body handle
- amount (number) – Amount

Flash the appearance of a body when rendering this frame.  
This is used for valuables in the game.

```lua
DrawBodyHighlight(body, 0.5)
```

## GetBodyClosestPoint
Arguments:
- body (number) – Body handle
- origin (table) – World space point

Return value:
- hit (boolean) – True if a point was found
- point (table) – World space closest point
- normal (table) – World space normal at closest point
- shape (number) – Handle to closest shape

This will return the closest point of a specific body

```lua
local hit, p, n, s = GetBodyClosestPoint(body, Vec(0, 5, 0))
if hit then
	--Point p of shape s is closest
end
```

## ConstrainVelocity
Arguments:
- bodyA (number) – First body handle (zero for static)
- bodyB (number) – Second body handle (zero for static)
- point (table) – World space point
- dir (table) – World space direction
- relVel (number) – Desired relative velocity along the provided direction
- min (number, optional) – Minimum impulse (default: -infinity)
- max (number, optional) – Maximum impulse (default: infinity)

This will tell the physics solver to constrain the velocity between two bodies.  
The physics solver will try to reach the desired goal, while not applying an impulse bigger than the min and max values.  
This function should only be used from the update callback.

```lua
--Constrain the velocity between bodies A and B so that the relative velocity 
--along the X axis at point (0, 5, 0) is always 3 m/s
ConstrainVelocity(a, b, Vec(0, 5, 0), Vec(1, 0, 0), 3)
```

## ConstrainAngularVelocity
Arguments:
- bodyA (number) – First body handle (zero for static)
- bodyB (number) – Second body handle (zero for static)
- dir (table) – World space direction
- relAngVel (number) – Desired relative angular velocity along the provided direction
- min (number, optional) – Minimum angular impulse (default: -infinity)
- max (number, optional) – Maximum angular impulse (default: infinity)

This will tell the physics solver to constrain the angular velocity between two bodies.  
The physics solver will try to reach the desired goal, while not applying an angular impulse bigger than the min and max values.  
This function should only be used from the update callback.

```lua
--Constrain the angular velocity between bodies A and B so that the relative angular velocity
--along the Y axis is always 3 rad/s
ConstrainAngularVelocity(a, b, Vec(1, 0, 0), 3)
```

## ConstrainPosition
Arguments:
- bodyA (number) – First body handle (zero for static)
- bodyB (number) – Second body handle (zero for static)
- pointA (table) – World space point for first body
- pointB (table) – World space point for second body
- maxVel (number, optional) – Maximum relative velocity (default: infinite)
- maxImpulse (number, optional) – Maximum impulse (default: infinite)

This is a helper function that uses ConstrainVelocity to constrain a point on one body to a point on another body while not affecting the bodies more than the provided maximum relative velocity and maximum impulse.  
In other words: physically push on the bodies so that pointA and pointB are aligned in world space.  
This is useful for physically animating objects.  
This function should only be used from the update callback.

```lua
--Constrain the origo of body a to an animated point in the world
local worldPos = Vec(0, 3+math.sin(GetTime()), 0)
ConstrainPosition(a, 0, GetBodyTransform(a).pos, worldPos)

--Constrain the origo of body a to the origo of body b (like a ball joint)
ConstrainPosition(a, b, GetBodyTransform(a).pos, GetBodyTransform(b).pos)
```

## ConstrainOrientation
Arguments:
- bodyA (number) – First body handle (zero for static)
- bodyB (number) – Second body handle (zero for static)
- quatA (table) – World space orientation for first body
- quatB (table) – World space orientation for second body
- maxAngVel (number, optional) – Maximum relative angular velocity (default: infinite)
- maxAngImpulse (number, optional) – Maximum angular impulse (default: infinite)

This is the angular counterpart to ConstrainPosition, a helper function that uses ConstrainAngularVelocity to constrain the orientation of one body to the orientation on another body while not affecting the bodies more than the provided maximum relative angular velocity and maximum angular impulse.  
In other words: physically rotate the bodies so that quatA and quatB are aligned in world space.  
This is useful for physically animating objects.  
This function should only be used from the update callback.

```lua
--Constrain the orietation of body a to an upright orientation in the world
ConstrainOrientation(a, 0, GetBodyTransform(a).rot, Quat())

--Constrain the orientation of body a to the orientation of body b
ConstrainOrientation(a, b, GetBodyTransform(a).rot, GetBodyTransform(b).rot)
```

## GetWorldBody
Return value:
- body (number) – Handle to the static world body

Every scene in Teardown has an implicit static world body that contains all shapes that are not explicitly assigned a body in the editor.

```lua
local w = GetWorldBody()
```

# Shape

A shape is a voxel object and always owned by a body.  
A single body may contain multiple shapes.  
The transform of shape is expressed in the parent body coordinate system.

## FindShape
Arguments:
- tag (string) – Tag name
- global (boolean, optional) – Search in entire scene

Return value:
- handle (number) – Handle to first shape with specified tag or zero if not found

```lua
--Search for a shape tagged "mybox" in script scope
local target = FindShape("mybox")

--Search for a shape tagged "laserturret" in entire scene
local escape = FindShape("laserturret", true)
```

## FindShapes
Arguments:
- tag (string) – Tag name
- global (boolean, optional) – Search in entire scene

Return value:
- list (table) – Indexed table with handles to all shapes with specified tag

```lua
--Search for shapes tagged "alarmbox" in script scope
local shapes = FindShapes("alarmbox")
for i=1, #shapes do
	local shape = shapes[i]
	...
end
```

## GetShapeLocalTransform
Arguments:
- handle (number) – Shape handle

Return value:
- transform (table) – Return shape transform in body space

```lua
--Shape transform in body local space
local shapeTransform = GetShapeLocalTransform(shape)

--Body transform in world space
local bodyTransform = GetBodyTransform(GetShapeBody(shape))

--Shape transform in world space
local worldTranform = TransformToParentTransform(bodyTransform, shapeTransform)
```

## SetShapeLocalTransform
Arguments:
- handle (number) – Shape handle
- transform (table) – Shape transform in body space

```lua
local transform = Transform(Vec(0, 1, 0), QuatEuler(0, 90, 0))
SetShapeLocalTransform(shape, transform)
```

## GetShapeWorldTransform
Arguments:
- handle (number) – Shape handle

Return value:
- transform (table) – Return shape transform in world space

This is a convenience function, transforming the shape out of body space

```lua
local worldTransform = GetShapeWorldTransform(shape)

--This is equivalent to
local shapeTransform = GetShapeLocalTransform(shape)
local bodyTransform = GetBodyTransform(GetShapeBody(shape))
worldTranform = TransformToParentTransform(bodyTransform, shapeTransform)
```

## GetShapeBody
Arguments:
- handle (number) – Shape handle

Return value:
- handle (number) – Body handle

Get handle to the body this shape is owned by.  
A shape is always owned by a body, but can be transfered to a new body during destruction.

```lua
local body = GetShapeBody(shape)
```

## GetShapeJoints
Arguments:
- shape (number) – Shape handle

Return value:
- list (table) – Indexed table with joints connected to shape

```lua
local hinges = GetShapeJoints(door)
for i=1, #hinges do
	local joint = hinges[i]
	...
end
```

## GetShapeLights
Arguments:
- shape (number) – Shape handle

Return value:
- list (table) – Indexed table of lights owned by shape

```lua
local lights = GetShapeLights(shape)
for i=1, #lights do
	local light = lights[i]
	...
end
```

## GetShapeBounds
Arguments:
- handle (number) – Shape handle

Return value:
- min (table) – Vector representing the AABB lower bound
- max (table) – Vector representing the AABB upper bound

Return the world space, axis-aligned bounding box for a shape.

```lua
local min, max = GetShapeBounds(shape)
local boundsSize = VecSub(max, min)
local center = VecLerp(min, max, 0.5)
```

## SetShapeEmissiveScale
Arguments:
- handle (number) – Shape handle
- scale (number) – Scale factor for emissiveness

Scale emissiveness for shape.  
If the shape has light sources attached,  
their intensity will be scaled by the same amount.

```lua
--Pulsate emissiveness and light intensity for shape
local scale = math.sin(GetTime())*0.5 + 0.5
SetShapeEmissiveScale(shape, scale)
```

## GetShapeMaterialAtPosition
Arguments:
- handle (number) – Shape handle
- pos (table) – Position in world space

Return value:
- type (string) – Material type
- r (number) – Red
- g (number) – Green
- b (number) – Blue
- a (number) – Alpha
- entry (number) – Palette entry for voxel (zero if empty)

Return material properties for a particular voxel

```lua
local hit, dist, normal, shape = QueryRaycast(pos, dir, 10)
if hit then
	local hitPoint = VecAdd(pos, VecScale(dir, dist))
	local mat = GetShapeMaterialAtPosition(shape, hitPoint)
	DebugPrint("Raycast hit voxel made out of " .. mat)
end
```

## GetShapeMaterialAtIndex
Arguments:
- handle (number) – Shape handle
- x (number) – X integer coordinate
- y (number) – Y integer coordinate
- z (number) – Z integer coordinate

Return value:
- type (string) – Material type
- r (number) – Red
- g (number) – Green
- b (number) – Blue
- a (number) – Alpha
- entry (number) – Palette entry for voxel (zero if empty)

Return material properties for a particular voxel in the voxel grid indexed by integer values. The first index is zero (not one, as opposed to a lot of lua related things)

```lua
local mat = GetShapeMaterialAtIndex(shape, 0, 0, 0)
DebugPrint("The voxel closest to origo is of material: " .. mat)
```

## GetShapeSize
Arguments:
- handle (number) – Shape handle

Return value:
- xsize (number) – Size in voxels along x axis
- ysize (number) – Size in voxels along y axis
- zsize (number) – Size in voxels along z axis
- scale (number) – The size of one voxel in meters (with default scale it is 0.1)

Return the size of a shape in voxels

```lua
local x, y, z = GetShapeSize(shape)
```

## GetShapeVoxelCount
Arguments:
- handle (number) – Shape handle

Return value:
- count (number) – Number of voxels in shape

Return the number of voxels in a shape, not including empty space

```lua
local voxelCount = GetShapeVoxelCount(shape)
```

## IsShapeVisible
Arguments:
- handle (number) – Shape handle
- maxDist (number) – Maximum visible distance
- rejectTransparent (boolean, optional) – See through transparent materials. Default false.

Return value:
- visible (boolean) – Return true if shape is visible

This will check if a shape is currently visible in the camera frustum and not occluded by other objects.

```lua
if IsShapeVisible(shape, 25) then
	--Shape is within 25 meters visible to the camera
end
```

## IsShapeBroken
Arguments:
- handle (number) – Shape handle

Return value:
- broken (boolean) – Return true if shape is broken

Determine if shape has been broken.  
Note that a shape can be transfered to another body during destruction,  
but might still not be considered broken if all voxels are intact.

```lua
local broken = IsShapeBroken(shape)
```

## DrawShapeOutline
Arguments:
- handle (number) – Shape handle
- r (number, optional) – Red
- g (number, optional) – Green
- b (number, optional) – Blue
- a (number) – Alpha

Render next frame with an outline around specified shape.  
If no color is given, a white outline will be drawn.

```lua
--Draw white outline at 50% transparency
DrawShapeOutline(shape, 0.5)

--Draw green outline, fully opaque
DrawShapeOutline(shape, 0, 1, 0, 1)
```

## DrawShapeHighlight
Arguments:
- handle (number) – Shape handle
- amount (number) – Amount

Flash the appearance of a shape when rendering this frame.

```lua
DrawShapeHighlight(shape, 0.5)
```

## SetShapeCollisionFilter
Arguments:
- handle (number) – Shape handle
- layer (number) – Layer bits (0-255)
- mask (number) – Mask bits (0-255)

This is used to filter out collisions with other shapes.  
Each shape can be given a layer bitmask (8 bits, 0-255) along with a mask (also 8 bits).  
The layer of one object must be in the mask of the other object and vice versa for the collision to be valid.  
The default layer for all objects is 1 and the default mask is 255 (collide with all layers).

```lua
--This will put shapes a and b in layer 2 and disable collisions with
--object shapes in layers 2, preventing any collisions between the two.
SetShapeCollisionFilter(a, 2, 255-2)
SetShapeCollisionFilter(b, 2, 255-2)

--This will put shapes c and d in layer 4 and allow collisions with other
--shapes in layer 4, but ignore all other collisions with the rest of the world.
SetShapeCollisionFilter(c, 4, 4)
SetShapeCollisionFilter(d, 4, 4)
```

## CreateShape
Arguments:
- body (number) – Body handle
- transform (table) – Shape transform in body space
- refShape (number) – Handle to reference shape or path to vox file

Return value:
- newShape (number) – Handle of new shape

Create new, empty shape on existing body using the palette of a reference shape.  
The reference shape can be any existingf shape in the scene or an external vox file.  
The size of the new shape will be 1x1x1. 

## ClearShape
Arguments:
- shape (number) – Shape handle

Fill a voxel shape with zeroes, thus removing all voxels. 

## ResizeShape
Arguments:
- shape (number) – Shape handle
- xmi (number) – Lower X coordinate
- ymi (number) – Lower Y coordinate
- zmi (number) – Lower Z coordinate
- xma (number) – Upper X coordinate
- yma (number) – Upper Y coordinate
- zma (number) – Upper Z coordinate

Return value:
- offset (table) – Offset vector in shape local space

Resize an existing shape.  
The new coordinates are expressed in the existing shape coordinate frame,  
so you can provide negative values.  
The existing content is preserved, but may be cropped if needed.  
The local shape transform will be moved automatically with an offset vector to preserve the original content in body space.  
This offset vector is returned in shape local space. 

## SetShapeBody
Arguments:
- shape (number) – Shape handle
- body (number) – Body handle
- transform (table, optional) – New local shape transform. Default is existing local transform.

Move existing shape to a new body, optionally providing a new local transform.


## CopyShapeContent
Arguments:
- src (number) – Source shape handle
- dst (number) – Destination shape handle

Copy voxel content from source shape to destination shape.  
If destination shape has a different size, it will be resized to match the source shape. 

## CopyShapePalette
Arguments:
- src (number) – Source shape handle
- dst (number) – Destination shape handle

Copy the palette from source shape to destination shape. 

## GetShapePalette
Arguments:
- shape (number) – Shape handle

Return value:
- entries (table) – Palette material entries

Return list of material entries, each entry is a material index that can be provided to GetShapeMaterial or used as brush for populating a shape. 

## GetShapeMaterial
Arguments:
- shape (number) – Shape handle
- entry (number) – Material entry

Return value:
- type (string) – Type
- red (number) – Red value
- green (number) – Green value
- blue (number) – Blue value
- alpha (number) – Alpha value
- reflectivity (number) – Range 0 to 1
- shininess (number) – Range 0 to 1
- metallic (number) – Range 0 to 1
- emissive (number) – Range 0 to 32

Return material properties for specific matirial entry. 

## SetBrush
Arguments:
- type (string) – One of "sphere", "cube" or "noise"
- size (number) – Size of brush in voxels (must be in range 1 to 16)
- index (or) – Material index or path to brush vox file
- object (string, optional) – Optional object in brush vox file if brush vox file is used

Set material index to be used for following calls to DrawShapeLine and DrawShapeBox and ExtrudeShape.  
An optional brush vox file and subobject can be used and provided instead of material index,  
in which case the content of the brush will be used and repeated. Use material index zero to remove of voxels. 

## DrawShapeLine
Arguments:
- shape (number) – Handle to shape
- x0 (number) – Start X coordinate
- y0 (number) – Start Y coordinate
- z0 (number) – Start Z coordinate
- x1 (number) – End X coordinate
- y1 (number) – End Y coordinate
- z1 (number) – End Z coordinate
- paint (bool, optional) – Paint mode. Default is false.
- noOverwrite (bool, optional) – Only fill in voxels if space isn't already occupied. Default is false.

Draw voxelized line between (x0,y0,z0) and (x1,y1,z1) into shape using the material set up with SetBrush.  
Paint mode will only change material of existing voxels (where the current material index is non-zero).  
noOverwrite mode will only fill in voxels if the space isn't already accupied by another shape in the scene. 

## DrawShapeBox
Arguments:
- shape (number) – Handle to shape
- x0 (number) – Start X coordinate
- y0 (number) – Start Y coordinate
- z0 (number) – Start Z coordinate
- x1 (number) – End X coordinate
- y1 (number) – End Y coordinate
- z1 (number) – End Z coordinate

Draw box between (x0,y0,z0) and (x1,y1,z1) into shape using the material set up with SetBrush.

## ExtrudeShape
Arguments:
- shape (number) – Handle to shape
- x (number) – X coordinate to extrude
- y (number) – Y coordinate to extrude
- z (number) – Z coordinate to extrude
- dx (number) – X component of extrude direction, should be -1, 0 or 1
- dy (number) – Y component of extrude direction, should be -1, 0 or 1
- dz (number) – Z component of extrude direction, should be -1, 0 or 1
- steps (number) – Length of extrusion in voxels
- mode (string) – Extrusion mode, one of "exact", "material", "geometry". Default is "exact"

Extrude region of shape.  
The extruded region will be filled in with the material set up with SetBrush.  
The mode parameter sepcifies how the region is determined.  
Exact mode selects region of voxels that exactly match the input voxel at input coordinate.  
Material mode selects region that has the same material type as the input voxel.  
Geometry mode selects any connected voxel in the same plane as the input voxel. 

## TrimShape
Arguments:
- shape (number) – Source handle

Return value:
- offset (table) – Offset vector in shape local space

Trim away empty regions of shape, thus potentially making it smaller.  
If the size of the shape changes, the shape will be automatically moved to preserve the shape content in body space.  
The offset vector for this translation is returned in shape local space. 

## SplitShape
Arguments:
- shape (number) – Source handle
- removeResidual (bool) – Remove residual shapes (default false)

Return value:
- newShapes (table) – List of shape handles created

Split up a shape into multiple shapes based on connectivity.  
If the removeResidual flag is used, small disconnected chunks will be removed during this process to reduce the number of newly created shapes. 

## MergeShape
Arguments:
- shape (number) – Input shape

Return value:
- shape (number) – Shape handle after merge

Try to merge shape with a nearby, matching shape.  
For a merge to happen, the shapes need to be aligned to the same rotation and touching.  
If the provided shape was merged into another shape, that shape may be resized to fit the merged content.  
If shape was merged, the handle to the other shape is returned, otherwise the input handle is returned. 

## GetShapeClosestPoint
Arguments:
- shape (number) – Shape handle
- origin (table) – World space point

Return value:
- hit (boolean) – True if a point was found
- point (table) – World space closest point
- normal (table) – World space normal at closest point

This will return the closest point of a specific shape

```lua
local hit, p, n = GetShapeClosestPoint(s, Vec(0, 5, 0))
if hit then
	--Point p of shape s is closest to (0,5,0)
end
```

## IsShapeTouching
*AreShapesTouching
Arguments:
- a (number) – Handle to first shape
- b (number) – Handle to second shape

Return value:
- touching (boolean) – True if shapes a and b are touching each other

This will check if two shapes has physical overlap

```lua
local touch = IsShapeTouching(a, b)
if touch then
	--Shapes are touching or overlapping
end
```

# Location

Locations are transforms placed in the editor as markers.  
Location transforms are always expressed in world space coordinates.

## FindLocation
Arguments:
- tag (string) – Tag name
- global (boolean, optional) – Search in entire scene

Return value:
- handle (number) – Handle to first location with specified tag or zero if not found

```lua
local loc = FindLocation("start")
```

## FindLocations
Arguments:
- tag (string) – Tag name
- global (boolean, optional) – Search in entire scene

Return value:
- list (table) – Indexed table with handles to all locations with specified tag

```lua
--Search for locations tagged "waypoint" in script scope
local locations = FindLocations("waypoint")
for i=1, #locs do
	local locs = locations[i]
	...
end
```

## GetLocationTransform
Arguments:
- handle (number) – Location handle

Return value:
- transform (table) – Transform of the location

```lua
local t = GetLocationTransform(loc)
```

# Joint

Joints are used to physically connect two shapes.  
There are several types of joints and they are typically placed in the editor.  
When destruction occurs, joints may be transferred to new shapes, detached or completely disabled.

## FindJoint
Arguments:
- tag (string) – Tag name
- global (boolean, optional) – Search in entire scene

Return value:
- handle (number) – Handle to first joint with specified tag or zero if not found

```lua
local joint = FindJoint("doorhinge")
```

## FindJoints
Arguments:
- tag (string) – Tag name
- global (boolean, optional) – Search in entire scene

Return value:
- list (table) – Indexed table with handles to all joints with specified tag

```lua
--Search for locations tagged "doorhinge" in script scope
local hinges = FindJoints("doorhinge")
for i=1, #hinges do
	local joint = hinges[i]
	...
end
```

## IsJointBroken
Arguments:
- joint (number) – Joint handle

Return value:
- broken (boolean) – True if joint is broken

```lua
local broken = IsJointBroken(joint)
```

## GetJointType
Arguments:
- joint (number) – Joint handle

Return value:
- type (string) – Joint type

Joint type is one of the following: "ball", "hinge", "prismatic" or "rope".  
An empty string is returned if joint handle is invalid.

```lua
if GetJointType(joint) == "rope" then
	--Joint is rope
end
```

## GetJointOtherShape
Arguments:
- joint (number) – Joint handle
- shape (number) – Shape handle

Return value:
- other (number) – Other shape handle

A joint is always connected to two shapes.  
Use this function if you know one shape and want to find the other one.

```lua
--joint is connected to a and b

otherShape = GetJointOtherShape(joint, a)
--otherShape is now b

otherShape = GetJointOtherShape(joint, b)
--otherShape is now a
```

## GetJointShapes
Arguments:
- joint (number) – Joint handle

Return value:
- shapes (number) – Shape handles

Get shapes connected to the joint.

```lua
-- Check to see if joint chain is still connected to vehicle main body
-- If not then disable motors

local mainBody = GetVehicleBody(vehicle)
local shapes = GetJointShapes(joint)

local connected = false
for i=1,#shapes do

	local body = GetShapeBody(shapes[i])

	if body == mainBody then
		connected = true
	end

end

if connected then
	SetJointMotor(joint, 0.5)
else
	SetJointMotor(joint, 0.0)
end
```

## SetJointMotor
Arguments:
- joint (number) – Joint handle
- velocity (number) – Desired velocity
- strength (number, optional) – Desired strength. Default is infinite. Zero to disable.

Set joint motor target velocity.  
If joint is of type hinge, velocity is given in radians per second angular velocity.  
If joint type is prismatic joint velocity is given in meters per second.  
Calling this function will override and void any previous call to SetJointMotorTarget.

```lua
--Set motor speed to 0.5 radians per second
SetJointMotor(hinge, 0.5)
```

## SetJointMotorTarget
Arguments:
- joint (number) – Joint handle
- target (number) – Desired movement target
- maxVel (number, optional) – Maximum velocity to reach target. Default is infinite.
- strength (number, optional) – Desired strength. Default is infinite. Zero to disable.

If a joint has a motor target, it will try to maintain its relative movement.  
This is very useful for elevators or other animated, jointed mechanisms.  
If joint is of type hinge, target is an angle in degrees (-180 to 180)  
and velocity is given in radians per second. If joint type is prismatic,  
target is given in meters and velocity is given in meters per second.  
Setting a motor target will override any previous call to SetJointMotor.

```lua
--Make joint reach a 45 degree angle, going at a maximum of 3 radians per second
SetJointMotorTarget(hinge, 45, 3)
```

## GetJointLimits
Arguments:
- joint (number) – Joint handle

Return value:
- min (number) – Minimum joint limit (angle or distance)
- max (number) – Maximum joint limit (angle or distance)

Return joint limits for hinge or prismatic joint.  
Returns angle or distance depending on joint type.

```lua
local min, max = GetJointLimits(hinge)
```

## GetJointMovement
Arguments:
- joint (number) – Joint handle

Return value:
- movement (number) – Current joint position or angle

Return the current position or angle or the joint,  
measured in same way as joint limits.

```lua
local current = GetJointMovement(hinge)
```

## GetJointedBodies
Arguments:
- body (number) – Body handle (must be dynamic)

Return value:
- bodies (table) – Handles to all dynamic bodies in the jointed structure. The input handle will also be included.

```lua
--Draw outline for all bodies in jointed structure
local all = GetJointedBodies(body)
for i=1,#all do
	DrawBodyOutline(all[i], 0.5)
end
```

## DetachJointFromShape
Arguments:
- joint (number) – Joint handle
- shape (number) – Shape handle


Detach joint from shape.  
If joint is not connected to shape, nothing happens.

```lua
DetachJointFromShape(hinge, door)
```

# Light

Light sources can be of several differnt types and configured in the editor.  
If a light source is owned by a shape, the intensity of the light source is scaled by the emissive scale of that shape.  
If the parent shape breaks, the emissive scale is set to zero and the light source is disabled.  
A light source without a parent shape will always emit light, unless exlicitly disabled by a script.  

## FindLight
Arguments:
- tag (string) – Tag name
- global (boolean, optional) – Search in entire scene

Return value:
- handle (number) – Handle to first light with specified tag or zero if not found

```lua
local light = FindLight("main")
```


## FindLights
Arguments:
- tag (string) – Tag name
- global (boolean, optional) – Search in entire scene

Return value:
- list (table) – Indexed table with handles to all lights with specified tag

```lua
--Search for lights tagged "main" in script scope
local lights = FindLights("main")
for i=1, #lights do
	local light = lights[i]
	...
end
```

## SetLightEnabled
Arguments:
- handle (number) – Light handle
- enabled (boolean) – Set to true if light should be enabled

If light is owned by a shape, the emissive scale of that shape will be set to 0.0 when light is disabled and 1.0 when light is enabled.

```lua
SetLightEnabled(light, false)
```

## SetLightColor
Arguments:
- handle (number) – Light handle
- r (number) – Red value
- g (number) – Green value
- b (number) – Blue value

This will only set the color tint of the light.  
Use SetLightIntensity for brightness.  
Setting the light color will not affect the emissive color of a parent shape.

```lua
--Set light color to yellow
SetLightColor(light, 1, 1, 0)
```

## SetLightIntensity
Arguments:
- handle (number) – Light handle
- intensity (number) – Desired intensity of the light

If the shape is owned by a shape you most likely want to use SetShapeEmissiveScale instead,  
which will affect both the emissiveness of the shape and the brightness of the light at the same time.

```lua
--Pulsate light
SetLightIntensity(light, math.sin(GetTime())*0.5 + 1.0)
```

## GetLightTransform
Arguments:
- handle (number) – Light handle

Return value:
- transform (table) – World space light transform

Lights that are owned by a dynamic shape are automatcially moved with that shape

```lua
local pos = GetLightTransform(light).pos
```


## GetLightShape
Arguments:
- handle (number) – Light handle

Return value:
- handle (number) – Shape handle or zero if not attached to shape

```lua
local shape = GetLightShape(light)
```

## IsLightActive
Arguments:
- handle (number) – Light handle

Return value:
- active (boolean) – True if light is currently emitting light

```lua
if IsLightActive(light) then
	--Do something
end
```

## IsPointAffectedByLight
Arguments:
- handle (number) – Light handle
- point (table) – World space point as vector

Return value:
- affected (boolean) – Return true if point is in light cone and range

```lua
local point = Vec(0, 10, 0)
local affected = IsPointAffectedByLight(light, point)
```

# Trigger

Triggers can be placed in the scene and queried by scripts to see if something is within a certain part of the scene.

## FindTrigger
Arguments:
- tag (string) – Tag name
- global (boolean, optional) – Search in entire scene

Return value:
- handle (number) – Handle to first trigger with specified tag or zero if not found

```lua
local goal = FindTrigger("goal")
```

## FindTriggers
Arguments:
- tag (string) – Tag name
- global (boolean, optional) – Search in entire scene

Return value:
- list (table) – Indexed table with handles to all triggers with specified tag

```lua
--Find triggers tagged "toxic" in script scope
local triggers = FindTriggers("toxic")
for i=1, #triggers do
	local trigger = triggers[i]
	...
end
```


## GetTriggerTransform
Arguments:
- handle (number) – Trigger handle

Return value:
- transform (table) – Current trigger transform in world space

```lua
local t = GetTriggerTransform(trigger)
```

## SetTriggerTransform
Arguments:
- handle (number) – Trigger handle
- transform (table) – Desired trigger transform in world space

```lua
local t = Transform(Vec(0, 1, 0), QuatEuler(0, 90, 0))
SetTriggerTransform(trigger, t)
```

## GetTriggerBounds
Arguments:
- handle (number) – Trigger handle

Return value:
- min (table) – Lower point of trigger bounds in world space
- max (table) – Upper point of trigger bounds in world space

Return the lower and upper points in world space of the trigger axis aligned bounding box

```lua
local mi, ma = GetTriggerBounds(trigger)
local list = QueryAabbShapes(mi, ma)
```

## IsBodyInTrigger
Arguments:
- trigger (number) – Trigger handle
- body (number) – Body handle

Return value:
- inside (boolean) – True if body is in trigger volume

This function will only check the center point of the body

```lua
if IsBodyInTrigger(trigger, body) then
	...
end
```

## IsVehicleInTrigger
Arguments:
- trigger (number) – Trigger handle
- vehicle (number) – Vehicle handle

Return value:
- inside (boolean) – True if vehicle is in trigger volume

This function will only check origo of vehicle

```lua
if IsVehicleInTrigger(trigger, vehicle) then
	...
end
```

## IsShapeInTrigger
Arguments:
- trigger (number) – Trigger handle
- shape (number) – Shape handle

Return value:
- inside (boolean) – True if shape is in trigger volume

This function will only check the center point of the shape

```lua
if IsShapeInTrigger(trigger, shape) then
	...
end
```

## IsPointInTrigger
Arguments:
- trigger (number) – Trigger handle
- point (table) – Word space point as vector

Return value:
- inside (boolean) – True if point is in trigger volume

```lua
local p = Vec(0, 10, 0)
if IsPointInTrigger(trigger, p) then
	...
end
```

## IsTriggerEmpty
Arguments:
- handle (number) – Trigger handle
- demolision (boolean, optional) – If true, small debris and vehicles are ignored

Return value:
- empty (boolean) – True if trigger is empty
- maxpoint (table) – World space point of highest point (largest Y coordinate) if not empty

This function will check if trigger is empty.  
If trigger contains any part of a body it will return false and the highest point as second return value.

```lua
local empty, highPoint = IsTriggerEmpty(trigger)
if not empty then
	--highPoint[2] is the tallest point in trigger
end
```


## GetTriggerDistance
Arguments:
- trigger (number) – Trigger handle
- point (table) – Word space point as vector

Return value:
- distance (number) – Positive if point is outside, negative if inside

Get distance to the surface of trigger volume.  
Will return negative distance if inside.

```lua
local p = Vec(0, 10, 0)
local dist = GetTriggerDistance(trigger, p)
```

## GetTriggerClosestPoint
Arguments:
- trigger (number) – Trigger handle
- point (table) – Word space point as vector

Return value:
- closest (table) – Closest point in trigger as vector

Return closest point in trigger volume.  
Will return the input point itself if inside trigger or closest point on surface of trigger if outside.

```lua
local p = Vec(0, 10, 0)
local closest = GetTriggerClosestPoint(trigger, p)
```

# Screen

Screens display the content of UI scripts and can be made interactive.

## FindScreen
Arguments:
- tag (string) – Tag name
- global (boolean, optional) – Search in entire scene

Return value:
- handle (number) – Handle to first screen with specified tag or zero if not found

```lua
local screen = FindTrigger("tv")
```

## FindScreens
Arguments:
- tag (string) – Tag name
- global (boolean, optional) – Search in entire scene

Return value:
- list (table) – Indexed table with handles to all screens with specified tag

```lua
--Find screens tagged "tv" in script scope
local screens = FindScreens("tv")
for i=1, #screens do
	local screen = screens[i]
	...
end
```

## SetScreenEnabled
Arguments:
- screen (number) – Screen handle
- enabled (boolean) – True if screen should be enabled

Enable or disable screen

```lua
SetScreenEnabled(screen, true)
```

## IsScreenEnabled
Arguments:
- screen (number) – Screen handle

Return value:
- enabled (boolean) – True if screen is enabled

```lua
local b = IsScreenEnabled(screen)
```

## GetScreenShape
Arguments:
- screen (number) – Screen handle

Return value:
- shape (number) – Shape handle or zero if none

Return handle to the parent shape of a screen

```lua
local shape = GetScreenShape(screen)
```

# Vehicle

Vehicles are set up in the editor and consists of multiple parts owned by a vehicle entity.

## FindVehicle
Arguments:
- tag (string) – Tag name
- global (boolean, optional) – Search in entire scene

Return value:
- handle (number) – Handle to first vehicle with specified tag or zero if not found

```lua
local vehicle = FindVehicle("mycar")
```

## FindVehicles
Arguments:
- tag (string) – Tag name
- global (boolean, optional) – Search in entire scene

Return value:
- list (table) – Indexed table with handles to all vehicles with specified tag

```lua
--Find all vehicles in level tagged "boat"
local boats = FindVehicles("boat")
for i=1, #boats do
	local boat = boats[i]
	...
end
```


## GetVehicleTransform
Arguments:
- vehicle (number) – Vehicle handle

Return value:
- transform (table) – Transform of vehicle

```lua
local t = GetVehicleTransform(vehicle)
```

## GetVehicleBody
Arguments:
- vehicle (number) – Vehicle handle

Return value:
- body (number) – Main body of vehicle

```lua
local body = GetVehicleBody(vehicle)
if IsBodyBroken(body) then
--Vehicle body is broken
end
```

## GetVehicleHealth
Arguments:
- vehicle (number) – Vehicle handle

Return value:
- health (number) – Vehicle health (zero to one)

```lua
local health = GetVehicleHealth(vehicle)
```

## GetVehicleDriverPos
Arguments:
- vehicle (number) – Vehicle handle

Return value:
- pos (table) – Driver position as vector in vehicle space

```lua
local driverPos = GetVehicleDriverPos(vehicle)
local t = GetVehicleTransform(vehicle)
local worldPos = TransformToParentPoint(t, driverPos)
```

## DriveVehicle
Arguments:
- vehicle (number) – Vehicle handle
- drive (number) – Reverse/forward control -1 to 1
- steering (number) – Left/right control -1 to 1
- handbrake (boolean) – Handbrake control

This function applies input to vehicles, allowing for autonomous driving.  
The vehicle will be turned on automatically and turned off when no longer called.  
Call this from the tick function, not update.

```lua
function tick()
	--Drive mycar forwards
	local v = FindVehicle("mycar")
	DriveVehicle(v, 1, 0, false)
end
```

# Player

The player functions expose certain information about the player.

## GetPlayerPos
Return value:
- position (table) – Player center position

Return center point of player.  
This function is deprecated.  
Use GetPlayerTransform instead.

```lua
local p = GetPlayerPos()

--This is equivalent to
p = VecAdd(GetPlayerTransform().pos, Vec(0,1,0))
```

## GetPlayerTransform
Arguments:
- includePitch (boolean) – Include the player pitch (look up/down) in transform

Return value:
- transform (table) – Current player transform

The player transform is located at the bottom of the player.  
The player transform considers heading (looking left and right).  
Forward is along negative Z axis.  
Player pitch (looking up and down) does not affect player transform unless includePitch is set to true.  
If you want the transform of the eye, use GetPlayerCameraTransform() instead.

```lua
local t = GetPlayerTransform()
```

## SetPlayerTransform
Arguments:
- transform (table) – Desired player transform
- includePitch (boolean) – Set player pitch (look up/down) as well

Instantly teleport the player to desired transform.  
Unless includePitch is set to true, up/down look angle will be set to zero during this process.  
Player velocity will be reset to zero.

```lua
local t = Transform(Vec(10, 0, 0), QuatEuler(0, 90, 0))
SetPlayerTransform(t)
```

## SetPlayerGroundVelocity
Arguments:
- vel (table) – Desired ground velocity

Make the ground act as a conveyor belt, pushing the player even if ground shape is static.

```lua
SetPlayerGroundVelocity(Vec(2,0,0))
```

## GetPlayerCameraTransform
Return value:
- transform (table) – Current player camera transform

The player camera transform is usually the same as what you get from GetCameraTransform,  
but if you have set a camera transform manually with SetCameraTransform,  
you can retrieve the standard player camera transform with this function.

```lua
local t = GetPlayerCameraTransform()
```

## SetPlayerCameraOffsetTransform
Arguments:
- transform (table) – Desired player camera offset transform

Call this function continously to apply a camera offset.  
Can be used for camera effects such as shake and wobble.

```lua
local t = Transform(Vec(), QuatAxisAngle(Vec(1, 0, 0), math.sin(time*3.0) * 3.0))
SetPlayerCameraOffsetTransform(t)
```

## SetPlayerSpawnTransform
Arguments:
- transform (table) – Desired player spawn transform

Call this function during init to alter the player spawn transform.

```lua
local t = Transform(Vec(10, 0, 0), QuatEuler(0, 90, 0))
SetPlayerSpawnTransform(t)
```

## GetPlayerVelocity
Return value:
- velocity (table) – Player velocity in world space as vector

```lua
local vel = GetPlayerVelocity()
```

## SetPlayerVehicle
Arguments:
- vehicle (value) – Handle to vehicle or zero to not drive.

Drive specified vehicle.

```lua
local car = FindVehicle("mycar")
SetPlayerVehicle(car)
```


## SetPlayerVelocity
Arguments:
- velocity (table) – Player velocity in world space as vector

```lua
SetPlayerVelocity(Vec(0, 5, 0))
```

## GetPlayerVehicle
Return value:
- handle (number) – Current vehicle handle, or zero if not in vehicle

```lua
local vehicle = GetPlayerVehicle()
if vehicle ~= 0 then
	...
end
```

## GetPlayerGrabShape
Return value:
- handle (number) – Handle to grabbed shape or zero if not grabbing.

```lua
local shape = GetPlayerGrabShape()
if shape ~= 0 then
	...
end
```

## GetPlayerGrabBody
Return value:
- handle (number) – Handle to grabbed body or zero if not grabbing.

```lua
local body = GetPlayerGrabBody()
if body ~= 0 then
	...
end
```

## ReleasePlayerGrab
Release what the player is currently holding

```lua
ReleasePlayerGrab()
```

## GetPlayerPickShape
Return value:
- handle (number) – Handle to picked shape or zero if nothing is picked

```lua
local shape = GetPlayerPickShape()
if shape ~= 0 then
	...
end
```


## GetPlayerPickBody
Return value:
- handle (number) – Handle to picked body or zero if nothing is picked

```lua
local body = GetPlayerPickBody()
if body ~= 0 then
	...
end
```


## GetPlayerInteractShape
Return value:
- handle (number) – Handle to interactable shape or zero

Interactable shapes has to be tagged with "interact".  
The engine determines which interactable shape is currently interactable.

```lua
local shape = GetPlayerInteractShape()
if shape ~= 0 then
	...
end
```


## GetPlayerInteractBody
Return value:
- handle (number) – Handle to interactable body or zero

Interactable shapes has to be tagged with "interact".  
The engine determines which interactable body is currently interactable.

```lua
local body = GetPlayerInteractBody()
if body ~= 0 then
	...
end
```


## SetPlayerScreen
Arguments:
- handle (number) – Handle to screen or zero for no screen

Set the screen the player should interact with.  
For the screen to feature a mouse pointer and receieve input,  
the screen also needs to have interactive property.

```lua
--Interact with screen
SetPlayerScreen(screen)

--Do not interact with screen
SetPlayerScreen(0)
```


## GetPlayerScreen
Return value:
- handle (number) – Handle to interacted screen or zero if none

```lua
--Interact with screen
local screen = GetPlayerScreen()
```

## SetPlayerHealth
Arguments:
- health (number) – Set player health (between zero and one)

```lua
SetPlayerHealth(0.5)
```

## GetPlayerHealth
Return value:
- health (number) – Current player health

```lua
local health = GetPlayerHealth()
```

## RespawnPlayer
Respawn player at spawn position without modifying the scene

```lua
RespawnPlayer()
```

## RegisterTool
Arguments:
- id (string) – Tool unique identifier
- name (string) – Tool name to show in hud
- file (string) – Path to vox file
- group (number, optional) – Tool group for this tool (1-6) Default is 6.

Register a custom tool that will show up in the player inventory and can be selected with scroll wheel.  
Do this only once per tool. You also need to enable the tool in the registry before it can be used.

```lua
function init()
	RegisterTool("lasergun", "Laser Gun", "MOD/vox/lasergun.vox")
	SetBool("game.tool.lasergun.enabled", true)
end

function tick()
	if GetString("game.player.tool") == "lasergun" then
		--Tool is selected. Tool logic goes here.
	end
end
```

## GetToolBody
Return value:
- handle (number) – Handle to currently visible tool body or zero if none

Return body handle of the visible tool.  
You can use this to retrieve tool shapes and animate them, change emissiveness, etc.  
Do not attempt to set the tool body transform, since it is controlled by the engine. Use SetToolTranform for that.

```lua
local toolBody = GetToolBody()
if toolBody~=0 then
	...
end
```


## SetToolTransform
Arguments:
- transform (table) – Tool body transform
- sway (number) – Tool sway amount. Default is 1.0.

Apply an additional transform on the visible tool body.  
This can be used to create tool animations.  
You need to set this every frame from the tick function.  
The optional sway parameter control the amount of tool swaying when walking.  
Set to zero to disable completely.

```lua
--Offset the tool half a meter to the right
local offset = Transform(Vec(0.5, 0, 0))
SetToolTransform(offset)
```

# Sound
Sound functions are used for playing sounds or loops in the world.  
There sound functions are alwyas positioned and will be affected by acoustics simulation.  
If you want to play dry sounds without acoustics you should use UiSound and UiSoundLoop in the User Interface section.

## LoadSound
Arguments:
- path (string) – Path to ogg sound file
- nominalDistance (number, optional) – The distance in meters this sound is recorded at. Affects attenuation, default is 10.0

Return value:
- handle (number) – Sound handle

```lua
local snd = LoadSound("beep.ogg")
```

## LoadLoop
Arguments:
- path (string) – Path to ogg sound file
- nominalDistance (number, optional) – The distance in meters this sound is recorded at. Affects attenuation, default is 10.0

Return value:
- handle (number) – Loop handle

```lua
local loop = LoadLoop("siren.ogg")
```

## PlaySound
Arguments:
- handle (number) – Sound handle
- pos (table, optional) – World position as vector. Default is player position.
- volume (number, optional) – Playback volume. Default is 1.0

```lua
function init()
	snd = LoadSound("beep.ogg")
end

function tick()
	if trigSound then
		local pos = Vec(100, 0, 0)
		PlaySound(snd, pos, 0.5)
	end
end
```

If you have a list of sound files and you add a sequence number, starting from zero, at the end of each filename like below,
then each time you call PlaySound it will pick a random sound from that list and play that sound.

```lua
"example-sound0.ogg"
"example-sound1.ogg"
"example-sound2.ogg"
"example-sound3.ogg"
...

function init()
	--Load sound serie, OBS no ".ogg" or sequence number in filename
	snd = LoadSound("example-sound")
end

Plays a random sound from the loaded sound series
function tick()
	if trigSound then
		local pos = Vec(100, 0, 0)
		PlaySound(snd, pos, 0.5)
	end
end
```


## PlayLoop
Arguments:
- handle (number) – Loop handle
- pos (table, optional) – World position as vector. Default is player position.
- volume (number, optional) – Playback volume. Default is 1.0

Call this function continuously to play loop

```lua
function init()
	loop = LoadLoop("siren.ogg")
end

function tick()
	local pos = Vec(100, 0, 0)
	PlayLoop(loop, pos, 0.5)
end
```

## PlayMusic
Arguments:
- path (string) – Music path

```lua
PlayMusic("MOD/music/background.ogg")
```

## StopMusic
It stops da music. 

```lua
StopMusic()
```

# Sprite
Sprites are 2D images in PNG or JPG format that can be drawn into the world.  
Sprites can be drawn with ot without depth test (occluded by geometry).  
Sprites will not be affected by lighting but they will go through post processing.  
If you want to display positioned information to the player as an overlay,  
you probably want to use the Ui functions in combination with UiWorldToPixel instead.

## LoadSprite
Arguments:
- path (string) – Path to sprite. Must be PNG or JPG format.

Return value:
- handle (number) – Sprite handle

```lua
function init()
	arrow = LoadSprite("arrow.png")
end
```

## DrawSprite
Arguments:
- handle (number) – Sprite handle
- transform (table) – Transform
- width (number) – Width in meters
- height (number) – Height in meters
- r (number, optional) – Red color. Default 1.0.
- g (number, optional) – Green color. Default 1.0.
- b (number, optional) – Blue color. Default 1.0.
- a (number, optional) – Alpha. Default 1.0.
- depthTest (boolean, optional) – Depth test enabled. Default false.
- additive (boolean, optional) – Additive blending enabled. Default false.

Draw sprite in world at next frame.  
Call this function from the tick callback.

```lua
function init()
	arrow = LoadSprite("arrow.png")
end

function tick()
	--Draw sprite using transform
	--Size is two meters in width and height
	--Color is white, fully opaue
	local t = Transform(Vec(0, 10, 0), QuatEuler(0, GetTime(), 0))
	DrawSprite(arrow, t, 2, 2, 1, 1, 1, 1)
end
```

# Scene queries
Query the level in various ways.

## QueryRequire
Arguments:
- layers (string) – Space separate list of layers

Set required layers for next query. Available layers are:
| Layer | Description |
| - | - |
| physical | have a physical representation |
| dynamic | part of a dynamic body |
| static | part of a static body |
| large | above debris threshold |
| small | below debris threshold |
| visible | only hit visible shapes |

```lua
--Raycast dynamic, physical objects above debris threshold, but not specific vehicle
QueryRequire("physical dynamic large")
QueryRejectVehicle(vehicle)
QueryRaycast(...)
```

## QueryRejectVehicle
Arguments:
- vehicle (number) – Vehicle handle

Exclude vehicle from the next query

```lua
--Do not include vehicle in next raycast
QueryRejectVehicle(vehicle)
QueryRaycast(...)
```

## QueryRejectBody
Arguments:
- body (number) – Body handle

Exclude body from the next query

```lua
--Do not include body in next raycast
QueryRejectBody(body)
QueryRaycast(...)
```

## QueryRejectShape
Arguments:
- shape (number) – Shape handle

Exclude shape from the next query

```lua
--Do not include shape in next raycast
QueryRejectShape(shape)
QueryRaycast(...)
```

## QueryRaycast
Arguments:
- origin (table) – Raycast origin as world space vector
- direction (table) – Unit length raycast direction as world space vector
- maxDist (number) – Raycast maximum distance. Keep this as low as possible for good performance.
- radius (number, optional) – Raycast thickness. Default zero.
- rejectTransparent (boolean, optional) – Raycast through transparent materials. Default false.

Return value:
- hit (boolean) – True if raycast hit something
- dist (number) – Hit distance from origin
- normal (table) – World space normal at hit point
- shape (number) – Handle to hit shape

This will perform a raycast or spherecast (if radius is more than zero) query.  
If you want to set up a filter for the query you need to do so before every call to this function.

```lua
--Raycast from a high point straight downwards, excluding a specific vehicle
QueryRejectVehicle(vehicle)
local hit, d = QueryRaycast(Vec(0, 100, 0), Vec(0, -1, 0), 100)
if hit then
	...hit something at distance d
end
```

## QueryClosestPoint
Arguments:
- origin (table) – World space point
- maxDist (number) – Maximum distance. Keep this as low as possible for good performance.

Return value:
- hit (boolean) – True if a point was found
- point (table) – World space closest point
- normal (table) – World space normal at closest point
- shape (number) – Handle to closest shape

This will query the closest point to all shapes in the world.  
If you want to set up a filter for the query you need to do so before every call to this function.

```lua
--Find closest point within 10 meters of {0, 5, 0}, excluding any point on myVehicle
QueryRejectVehicle(myVehicle)
local hit, p, n, s = QueryClosestPoint(Vec(0, 5, 0), 10)
if hit then
	--Point p of shape s is closest
end
```

## QueryAabbShapes
Arguments:
- min (table) – Aabb minimum point
- max (table) – Aabb maximum point

Return value:
- list (table) – Indexed table with handles to all shapes in the aabb

Return all shapes within the provided world space, axis-aligned bounding box

```lua
local list = QueryAabbShapes(Vec(0, 0, 0), Vec(10, 10, 10))
for i=1, #list do
	local shape = list[i]
	..
end
```

## QueryAabbBodies
Arguments:
- min (table) – Aabb minimum point
- max (table) – Aabb maximum point

Return value:
- list (table) – Indexed table with handles to all bodies in the aabb

Return all bodies within the provided world space, axis-aligned bounding box

```lua
local list = QueryAabbBodies(Vec(0, 0, 0), Vec(10, 10, 10))
for i=1, #list do
	local body = list[i]
	..
end
```


## QueryPath
Arguments:
- start (table) – World space start point
- end (table) – World space target point
- maxDist (number, optional) – Maximum path length before giving up. Default is infinite.
- targetRadius (number, optional) – Maximum allowed distance to target in meters. Default is 2.0

Initiate path planning query.  
The result will run asynchronously as long as GetPathState retuns "busy".  
An ongoing path query can be aborted with AbortPath.  
The path planning query will use the currently set up query filter, just like the other query functions.

```lua
QueryPath(Vec(-10, 0, 0), Vec(10, 0, 0))
```

## AbortPath
Abort current path query, regardless of what state it is currently in.  
This is a way to save computing resources if the result of the current query is no longer of interest.

```lua
AbortPath()
```

## GetPathState
Return value:
- state (string) – Current path planning state

Return the current state of the last path planning query.
| State | Description |
| - | - |
| idle | No recent query |
| busy | Busy computing. No path found yet. |
| fail | Failed to find path. You can still get the resulting path (even though it won't reach the target). |
| done | Path planning completed and a path was found. Get it with GetPathLength and GetPathPoint) |

```lua
local s = GetPathState()
if s == "done" then
	DoSomething()
end
```

## GetPathLength
Return value:
- length (number) – Length of last path planning result (in meters)

Return the path length of the most recently computed path query.  
Note that the result can often be retrieved even if the path query failed.  
If the target point couldn't be reached, the path endpoint will be the point closest to the target.

```lua
local l = GetPathLength()
```

## GetPathPoint
Arguments:
- dist (number) – The distance along path. Should be between zero and result from GetPathLength()

Return value:
- point (table) – The path point dist meters along the path

Return a point along the path for the most recently computed path query.  
Note that the result can often be retrieved even if the path query failed.  
If the target point couldn't be reached, the path endpoint will be the point closest to the target.

```lua
local d = 0
local l = GetPathLength()
while d < l do
	DebugCross(GetPathPoint(d))
	d = d + 0.5
end
```

## GetLastSound
Return value:
- volume (number) – Volume of loudest sound played last frame
- position (table) – World position of loudest sound played last frame

```lua
local vol, pos = GetLastSound()
```

## IsPointInWater
Arguments:
- point (table) – World point as vector

Return value:
- inWater (boolean) – True if point is in water
- depth (number) – Depth of point into water, or zero if not in water

```lua
local wet, d = IsPointInWater(Vec(10, 0, 0))
if wet then
	...point d meters into water
end
```

## GetWindVelocity
Arguments:
- point (table) – World point as vector

Return value:
- vel (table) – Wind at provided position

Get the wind velocity at provided point.  
The wind will be determined by wind property of the environment,  
but it varies with position procedurally.

```lua
local v = GetWindVelocity(Vec(0, 10, 0))
```

# Particles

Functions to configure and emit particles, used for fire, smoke and other visual effects.  
There are two types of particles in Teardown - plain particles and smoke particles.  
Plain particles are simple billboard particles simulated with gravity and velocity that can be used for fire, debris, rain, snow and such.  
Smoke particles are only intended for smoke and they are simulated with fluid dynamics internally and rendered with some special tricks to get a more smoke-like appearance.  


All functions in the particle API, except for SpawnParticle modify properties in the particle state, which is then used when emitting particles, so the idea is to set up a state, and then emit one or several particles using that state.  


Most properties in the particle state can be either constant or animated over time.  
Supply a single argument for constant, two argument for linear interpolation, and optionally a third argument for other types of interpolation.  
There are also fade in and fade out parameters that fade from and to zero.

## ParticleReset
Reset to default particle state, which is a plain, white particle of radius 0.5.  
Collision is enabled and it alpha animates from 1 to 0.

```lua
ParticleReset()
```


## ParticleType
Arguments:
- type (string) – Type of particle. Can be "smoke" or "plain".

Set type of particle

```lua
ParticleType("smoke")
```

## ParticleTile
Arguments:
- type (int) – Tile in the particle texture atlas (0-15)

```lua
--Smoke particle
ParticleTile(0)

--Fire particle
ParticleTile(5)
```

## ParticleColor
Arguments:
- r0 (float) – Red value
- g0 (float) – Green value
- b0 (float) – Blue value
- r1 (float, optional) – Red value at end
- g1 (float, optional) – Green value at end
- b1 (float, optional) – Blue value at end

Set particle color to either constant (three arguments) or linear interpolation (six arguments)

```lua
--Constant red
ParticleColor(1,0,0)

--Animating from yellow to red
ParticleColor(1,1,0, 1,0,0)
```

## ParticleRadius
Arguments:
- r0 (float) – Radius
- r1 (float, optional) – End radius
- interpolation (string, optional) – Interpolation method: linear, smooth, easein, easeout or constant. Default is linear.
- fadein (float, optional) – Fade in between t=0 and t=fadein. Default is zero.
- fadeout (float, optional) – Fade out between t=fadeout and t=1. Default is one.

Set the particle radius. Max radius for smoke particles is 1.0.

```lua
--Constant radius 0.4 meters
ParticleRadius(0.4)

--Interpolate from small to large
ParticleRadius(0.1, 0.7)
```

## ParticleAlpha
Arguments:
- a0 (float) – Alpha (0.0 - 1.0)
- a1 (float, optional) – End alpha (0.0 - 1.0)
- interpolation (string, optional) – Interpolation method: linear, smooth, easein, easeout or constant. Default is linear.
- fadein (float, optional) – Fade in between t=0 and t=fadein. Default is zero.
- fadeout (float, optional) – Fade out between t=fadeout and t=1. Default is one.

Set the particle alpha (opacity).

```lua
--Interpolate from opaque to transparent
ParticleAlpha(1.0, 0.0)
```

## ParticleGravity
Arguments:
- g0 (float) – Gravity
- g1 (float, optional) – End gravity
- interpolation (string, optional) – Interpolation method: linear, smooth, easein, easeout or constant. Default is linear.
- fadein (float, optional) – Fade in between t=0 and t=fadein. Default is zero.
- fadeout (float, optional) – Fade out between t=fadeout and t=1. Default is one.

Set particle gravity.  
It will be applied along the world Y axis.  
A negative value will move the particle downwards.

```lua
--Move particles slowly upwards
ParticleGravity(2)
```

## ParticleDrag
Arguments:
- d0 (float) – Drag
- d1 (float, optional) – End drag
- interpolation (string, optional) – Interpolation method: linear, smooth, easein, easeout or constant. Default is linear.
- fadein (float, optional) – Fade in between t=0 and t=fadein. Default is zero.
- fadeout (float, optional) – Fade out between t=fadeout and t=1. Default is one.

Particle drag will slow down fast moving particles.  
It's implemented slightly different for smoke and plain particles.  
Drag must be positive, and usually look good between zero and one.

```lua
--Slow down fast moving particles
ParticleDrag(0.5)
```

## ParticleEmissive
Arguments:
- d0 (float) – Emissive
- d1 (float, optional) – End emissive
- interpolation (string, optional) – Interpolation method: linear, smooth, easein, easeout or constant. Default is linear.
- fadein (float, optional) – Fade in between t=0 and t=fadein. Default is zero.
- fadeout (float, optional) – Fade out between t=fadeout and t=1. Default is one.

Draw particle as emissive (glow in the dark).  
This is useful for fire and embers.

```lua
--Highly emissive at start, not emissive at end
ParticleEmissive(5, 0)
```

## ParticleRotation
Arguments:
- r0 (float) – Rotation speed in radians per second.
- r1 (float, optional) – End rotation speed in radians per second.
- interpolation (string, optional) – Interpolation method: linear, smooth, easein, easeout or constant. Default is linear.
- fadein (float, optional) – Fade in between t=0 and t=fadein. Default is zero.
- fadeout (float, optional) – Fade out between t=fadeout and t=1. Default is one.

Makes the particle rotate. Positive values is counter-clockwise rotation.

```lua
--Rotate fast at start and slow at end
ParticleRotation(10, 1)
```

## ParticleStretch
Arguments:
- s0 (float) – Stretch
- s1 (float, optional) – End stretch
- interpolation (string, optional) – Interpolation method: linear, smooth, easein, easeout or constant. Default is linear.
- fadein (float, optional) – Fade in between t=0 and t=fadein. Default is zero.
- fadeout (float, optional) – Fade out between t=fadeout and t=1. Default is one.

Stretch particle along with velocity.  
0.0 means no stretching.  
1.0 stretches with the particle motion over one frame.  
Larger values stretches the particle even more.

```lua
--Stretch particle along direction of motion
ParticleStretch(1.0)
```

## ParticleSticky
Arguments:
- s0 (float) – Sticky (0.0 - 1.0)
- s1 (float, optional) – End sticky (0.0 - 1.0)
- interpolation (string, optional) – Interpolation method: linear, smooth, easein, easeout or constant. Default is linear.
- fadein (float, optional) – Fade in between t=0 and t=fadein. Default is zero.
- fadeout (float, optional) – Fade out between t=fadeout and t=1. Default is one.

Make particle stick when in contact with objects.  
This can be used for friction.

```lua
--Make particles stick to objects
ParticleSticky(0.5)
```

## ParticleCollide
Arguments:
- c0 (float) – Collide (0.0 - 1.0)
- c1 (float, optional) – End collide (0.0 - 1.0)
- interpolation (string, optional) – Interpolation method: linear, smooth, easein, easeout or constant. Default is linear.
- fadein (float, optional) – Fade in between t=0 and t=fadein. Default is zero.
- fadeout (float, optional) – Fade out between t=fadeout and t=1. Default is one.

Control particle collisions.  
A value of zero means that collisions are ignored. One means full collision.  
It is sometimes useful to animate this value from zero to one in order to not collide with objects around the emitter.

```lua
--Disable collisions
ParticleCollide(0)

--Enable collisions over time
ParticleCollide(0, 1)

--Ramp up collisions very quickly, only skipping the first 5% of lifetime
ParticleCollide(1, 1, "constant", 0.05)
```


## ParticleFlags
Arguments:
- bitmask (number) – Particle flags (bitmask 0-65535)

Set particle bitmask.  
The value 256 means fire extinguishing particles and is currently the only flag in use.  
There might be support for custom flags and queries in the future.

```lua
--Fire extinguishing particle
ParticleFlags(256)
SpawnParticle(...)
```

## SpawnParticle
Arguments:
- pos (table) – World space point as vector
- velocity (table) – World space velocity as vector
- lifetime (number) – Particle lifetime in seconds

Spawn particle using the previously set up particle state.  
You can call this multiple times using the same particle state,  
but with different position, velocity and lifetime.  
You can also modify individual properties in the particle state in between calls to to this function.

```lua
ParticleReset()
ParticleType("smoke")
ParticleColor(0.7, 0.6, 0.5)
--Spawn particle at world origo with upwards velocity and a lifetime of ten seconds
SpawnParticle(Vec(0, 0, 0), Vec(0, 1, 0), 10.0)
```


# Spawning
The spawn API can be used to add entities into the existing scenes.  
You can spawn existing prefab XML files or generate XML and pass it in as a lua string.

## Spawn
Arguments:
- xml (string) – File name or xml string
- transform (table) – Spawn transform
- allowStatic (boolean, optional) – Allow spawning static shapes and bodies (default false)
- jointExisting (boolean, optional) – Allow joints to connect to existing scene geometry (default false)

Return value:
- entities (table) – Indexed table with handles to all spawned entities

The first argument can be either a prefab XML file in your mod folder or a string with XML content.  
It is also possible to spawn prefabs from other mods, by using the mod id followed by colon, followed by the prefab path.  
Spawning prefabs from other mods should be used with causion since the referenced mod might not be installed.

```lua
Spawn("MOD/prefab/mycar.xml", Transform(Vec(0, 5, 0)))
Spawn("<voxbox size='10 10 10' prop='true' material='wood'/>", Transform(Vec(0, 10, 0)))
```

# Miscellaneous
Functions of peripheral nature that doesn't fit in anywhere else

## Shoot
Arguments:
- origin (table) – Origin in world space as vector
- direction (table) – Unit length direction as world space vector
- type (string, optional) – Shot type, see description, default is "bullet"
- strength (number, optional) – Strength scaling, default is 1.0
- maxDist (number, optional) – Maximum distance, default is 100.0

Fire projectile.  
Type can be one of "bullet", "rocket", "gun" or "shotgun".  
For backwards compatilbility, type also accept a number, where 1 is same as "rocket" and anything else "bullet" Note that this function will only spawn the projectile,  
not make any sound Also note that "bullet" and "rocket" are the only projectiles that can hurt the player.

```lua
Shoot(Vec(0, 10, 0), Vec(0, 0, 1), "shotgun")
```


## Paint
Arguments:
- origin (table) – Origin in world space as vector
- radius (number) – Affected radius, in range 0.0 to 5.0
- type (string, optional) – Paint type. Can be "explosion" or "spraycan". Default is spraycan.
- probability (number, optional) – Dithering probability between zero and one, default is 1.0

Tint the color of objects within radius to either black or yellow.

```lua
Paint(Vec(0, 10, 0), 0.5, "spraycan")
```

## MakeHole
Arguments:
- position (table) – Hole center point
- r0 (number) – Hole radius for soft materials
- r1 (number, optional) – Hole radius for medium materials. May not be bigger than r0. Default zero.
- r2 (number, optional) – Hole radius for hard materials. May not be bigger than r1. Default zero.
- silent (boolean, optional) – Make hole without playing any break sounds.

Return value:
- count (number) – Number of voxels that was cut out. This will be zero if there were no changes to any shape.

Make a hole in the environment.  
Radius is given in meters.  
Soft materials: glass, foliage, dirt, wood, plaster and plastic.  
Medium materials: concrete, brick and weak metal. Hard materials: hard metal and hard masonry.

```lua
MakeHole(pos, 1.2, 1.0)
```

## Explosion
Arguments:
- pos (table) – Position in world space as vector
- size (number) – Explosion size from 0.5 to 4.0

```lua
Explosion(Vec(0, 10, 0), 1)
```

## SpawnFire
Arguments:
- pos (table) – Position in world space as vector

```lua
SpawnFire(Vec(0, 10, 0))
```

## GetFireCount
Return value:
- count (number) – Number of active fires in level

```lua
local c = GetFireCount()
```


## QueryClosestFire
Arguments:
- origin (table) – World space position as vector
- maxDist (number) – Maximum search distance

Return value:
- hit (boolean) – A fire was found within search distance
- pos (table) – Position of closest fire

```lua
local hit, pos = QueryClosestFire(GetPlayerTransform().pos, 5.0)
if hit then
	--There is a fire within 5 meters to the player. Mark it with a debug cross.
	DebugCross(pos)
end
```

## QueryAabbFireCount
Arguments:
- min (table) – Aabb minimum point
- max (table) – Aabb maximum point

Return value:
- count (number) – Number of active fires in bounding box

```lua
local count = QueryAabbFireCount(Vec(0,0,0), Vec(10,10,10))
```

## RemoveAabbFires
Arguments:
- min (table) – Aabb minimum point
- max (table) – Aabb maximum point

Return value:
- count (number) – Number of fires removed

```lua
local removedCount= RemoveAabbFires(Vec(0,0,0), Vec(10,10,10))
```


## GetCameraTransform
Return value:
- transform (table) – Current camera transform

```lua
local t = GetCameraTransform()
```

## SetCameraTransform
Arguments:
- transform (table) – Desired camera transform
- fov (number, optional) – Optional horizontal field of view in degrees (default: 90)

Override current camera transform for this frame.  
Call continuously to keep overriding.

```lua
SetCameraTransform(Transform(Vec(0, 10, 0), QuatEuler(0, 90, 0)))
```

## SetCameraFov
Arguments:
- degrees (number) – Horizontal field of view in degrees (10-170)

Override field of view for the next frame for all camera modes,  
except when explicitly set in SetCameraTransform

```lua
function tick()
	SetCameraFov(60)
end
```

## SetCameraDof
Arguments:
- distance (number) – Depth of field distance
- amount (number, optional) – Optional amount of blur (default 1.0)

Override depth of field for the next frame for all camera modes.  
Depth of field will be used even if turned off in options.

```lua
--Set depth of field to 10 meters
SetCameraDof(10)
```

## PointLight
Arguments:
- pos (table) – World space light position
- r (number) – Red
- g (number) – Green
- b (number) – Blue
- intensity (number, optional) – Intensity. Default is 1.0.

Add a temporary point light to the world for this frame.  
Call continuously for a steady light.

```lua
--Pulsating, yellow light above world origo
local intensity = 3 + math.sin(GetTime())
PointLight(Vec(0, 5, 0), 1, 1, 0, intensity)
```

## SetTimeScale
Arguments:
- scale (number) – Time scale 0.1 to 1.0

Scale time in order to make a slow-motion effect.  
Audio will also be affected.  
Note that this will affect physics behavior and is not intended for gameplay purposes.  
Calling this function will slow down time for the next frame only.  
Call every frame from tick function to get steady slow-motion.

```lua
--Slow down time when holding down a key
if InputDown('t') then
SetTimeScale(0.2)
end
```


# Environment
| Property | Values | Decsription |
| - | - | - |
| skybox | DDS File | skybox, e.g. cloudy.dds / day.dds, more in data/env |
| skyboxtint | 3 floats 0 ~ 1 | Skybox color tint |
| skyboxbrightness | float 0 ~ 1 | Skybox brightness scale |
| skyboxrot | float euler degrees | Skybox rotation around Y axis |
| constant | 3 floats 0 ~ 1 | Base light |
| ambient | float | Determines how much the skybox will light up the scene |
| ambientexponent | float | Determines ambient light falloff when occluded. Higher value = darker indoors |
| fogcolor | 3 floats 0 ~ 1 | Color used for distance fog |
| fogParams | 4 floats | Four fog parameters: fog start, fog end, fog amount, fog exponent (higher gives steeper falloff along y axis) |
| sunBrightness | float | Light contribution by sun (gives directional shadows) |
| sunColorTint | 3 floats 0 ~ 1 | Color tint of sunlight. Multiplied with brightest spot in skybox. |
| sunDir | [editor default: auto] | Direction of sunlight. A value of zero will point from brightest spot in skybox |
| sunSpread | float | Divergence of sunlight as a fraction. A value of 0.05 will blur shadows 5 cm per meter |
| sunLength | int, default 32 | Maximum length of sunlight shadows. AS low as possible for best performance. |
| sunFogScale | float | Volumetric fog caused by sunlight |
| sunGlare | float | Sun glare scaling |
| exposure | float | Limits for automatic exposure, min max |
| brightness | float | Desired scene brightness that controls automatic exposure. Set higher for brighter scene. |
| wetness | float | Base wetness |
| puddleamount | float | Puddle coverage. Fraction between zero and one. |
| puddlesize | float | Puddle size |
| rain | float 0 ~ 1 | Amount of rain |
| nightlight | boolean | If set to false, all lights tagged night will be removed. |
| ambience | Environment sound path [volume] | e.g. outdoor/field.ogg |
| fogscale | float | Scale fog value on all light sources with this amount. |
| slippery | float | Slippery roads. Affects vehicles when outdoors. |
| waterhurt | float | Players take damage being in water. If above zero, health will decrease and not regenerate in water. |
| snowdir | 4 floats, direction vector + spread | Snow direction x, y, z and spread |
| snowamount | 2 floats | Snow particle amount (0-1) [optional speed] |
| snowonground | boolean | Generate snow on ground |
| wind | 3 floats, direction vector | Wind direction and strength: x y z |

## SetEnvironmentDefault
Reset the environment properties to default. This is often useful before setting up a custom environment.

```lua
SetEnvironmentDefault()
```

## SetEnvironmentProperty
Arguments:
- name (string) – Property name
- value0 (varying) – Property value (type depends on property)
- value1 (varying, optional) – Extra property value (only some properties)
- value2 (varying, optional) – Extra property value (only some properties)
- value3 (varying, optional) – Extra property value (only some properties)

This function is used for manipulating the environment properties.  
The available properties are exactly the same as in the editor, except for "snowonground" which is not currently supported.

```lua
SetEnvironmentProperty("skybox", "cloudy.dds")
SetEnvironmentProperty("rain", 0.7)
SetEnvironmentProperty("fogcolor", 0.5, 0.5, 0.8)
SetEnvironmentProperty("nightlight", false)
```

## GetEnvironmentProperty
Return value:
- value0 (varying) – Property value (type depends on property)
- value1 (varying) – Property value (only some properties)
- value2 (varying) – Property value (only some properties)
- value3 (varying) – Property value (only some properties)
- value4 (varying) – Property value (only some properties)

This function is used for querying the current environment properties. The available properties are exactly the same as in the editor.

```lua
local skyboxPath = GetEnvironmentProperty("skybox")
local rainValue = GetEnvironmentProperty("rain")
local r,g,b = GetEnvironmentProperty("fogcolor")
local enabled = GetEnvironmentProperty("nightlight")
```

# PostProcessing

| PostProcess | Values |
| - | - |
| saturation | float 0 - 1 | Adjust saturation (zero is greyscale) |
| colorbalance | 3 floats 0 - 1 | Adjust red green and blue channel |
| brightness | float | Adjust brightness (scale RGB) |
| gamma | float | Adjust gamma (use in combination with brightness for contrast) |
| bloom | float | Adjust bloom amount |

## SetPostProcessingDefault
Reset the post processing properties to default.

```lua
SetPostProcessingDefault()
```

## SetPostProcessingProperty
Arguments:
- name (string) – Property name
- value0 (number) – Property value
- value1 (number, optional) – Extra property value (only some properties)
- value2 (number, optional) – Extra property value (only some properties)

This function is used for manipulating the post processing properties.  
The available properties are exactly the same as in the editor.

```lua
--Sepia post processing
SetPostProcessingProperty("saturation", 0.4)
SetPostProcessingProperty("colorbalance", 1.3, 1.0, 0.7)
```

## GetPostProcessingProperty
Return value:
- value0 (number) – Property value
- value1 (number) – Property value (only some properties)
- value2 (number) – Property value (only some properties)

This function is used for querying the current post processing properties.  
The available properties are exactly the same as in the editor.

```lua
local saturation = GetPostProcessingProperty("saturation")
local r,g,b = GetPostProcessingProperty("colorbalance")
```

# Debug

## DrawLine
Arguments:
- p0 (table) – World space point as vector
- p1 (table) – World space point as vector
- r (number, optional) – Red
- g (number, optional) – Green
- b (number, optional) – Blue
- a (number, optional) – Alpha

Draw a 3D line.  
In contrast to DebugLine, it will not show behind objects.  
Default color is white.

```lua
--Draw white debug line
DrawLine(Vec(0, 0, 0), Vec(-10, 5, -10))

--Draw red debug line
DrawLine(Vec(0, 0, 0), Vec(10, 5, 10), 1, 0, 0)
```

## DebugLine
Arguments:
- p0 (table) – World space point as vector
- p1 (table) – World space point as vector
- r (number, optional) – Red
- g (number, optional) – Green
- b (number, optional) – Blue
- a (number, optional) – Alpha

Draw a 3D debug overlay line in the world.  
Default color is white.

```lua
--Draw white debug line
DebugLine(Vec(0, 0, 0), Vec(-10, 5, -10))

--Draw red debug line
DebugLine(Vec(0, 0, 0), Vec(10, 5, 10), 1, 0, 0)
```

## DebugCross
Arguments:
- p0 (table) – World space point as vector
- r (number, optional) – Red
- g (number, optional) – Green
- b (number, optional) – Blue
- a (number, optional) – Alpha

Draw a debug cross in the world to highlight a location.  
Default color is white.

```lua
DebugCross(Vec(10, 5, 5))
```

## DebugWatch
Arguments:
- name (string) – Name
- value (string) – Value

Show a named valued on screen for debug purposes.  
Up to 32 values can be shown simultaneously.  
Values updated the current frame are drawn opaque.  
Old values are drawn transparent in white.


The function will also recognize vectors,  
quaternions and transforms as second argument and convert them to strings automatically.

```lua
local t = 5
DebugWatch("time", t)
```


## DebugPrint
Arguments:
- message (string) – Message to display

Display message on screen.  
The last 20 lines are displayed.

```lua
DebugPrint("time")
```

# User Interface

The user interface functions are used for drawing interactive 2D graphics and can only be called from the draw function of a script.  
The ui functions are designed with the immediate mode gui paradigm in mind and uses a cursor and state stack.  
Pushing and popping the stack is cheap and designed to be called often.  
This is just an abstraction layer for imgui, pretty much.  
Heads up: the UI is always 1920x1080. no matter your resolution.  

## UiMakeInteractive
Calling this function will disable game input,  
bring up the mouse pointer and allow Ui interaction with the calling script without pausing the game.  
This can be useful to make interactive user interfaces from scripts while the game is running.  
Call this continuously every frame as long as Ui interaction is desired.

```lua
UiMakeInteractive()
```

## UiPush
Push state onto stack.  
This is used in combination with UiPop to remember a state and restore to that state later.

```lua
UiColor(1,0,0)
UiText("Red")
UiPush()
	UiColor(0,1,0)
	UiText("Green")
UiPop()
UiText("Red")
```


## UiPop
Pop state from stack and make it the current one.  
This is used in combination with UiPush to remember a previous state and go back to it later.

```lua
UiColor(1,0,0)
UiText("Red")
UiPush()
	UiColor(0,1,0)
	UiText("Green")
UiPop()
UiText("Red")
```

## UiWidth
Return value:
- width (number) – Width of draw context

```lua
local w = UiWidth()
```

## UiHeight
Return value:
- height (number) – Height of draw context

```lua
local h = UiHeight()
```

## UiCenter
Return value:
- center (number) – Half width of draw context

```lua
local c = UiCenter()
--Same as 
local c = UiWidth()/2
```

## UiMiddle
Return value:
- middle (number) – Half height of draw context

```lua
local m = UiMiddle()
--Same as
local m = UiHeight()/2
```

## UiColor
Arguments:
- r (float) – Red channel
- g (float) – Green channel
- b (float) – Blue channel
- a (float, optional) – Alpha channel. Default 1.0

```lua
--Set color yellow
UiColor(1,1,0)
```

## UiColorFilter
Arguments:
- r (number) – Red channel
- g (number) – Green channel
- b (number) – Blue channel
- a (number, optional) – Alpha channel. Default 1.0

Color filter, multiplied to all future colors in this scope

```lua
UiPush()
	--Draw menu in transparent, yellow color tint
	UiColorFilter(1, 1, 0, 0.5)
	drawMenu()
UiPop()
```


## UiTranslate
Arguments:
- x (number) – X component
- y (number) – Y component

Translate cursor

```lua
UiPush()
	UiTranslate(100, 0)
	UiText("Indented")
UiPop()
```

## UiRotate
Arguments:
- angle (number) – Angle in degrees, counter clockwise

Rotate cursor

```lua
UiPush()
	UiRotate(45)
	UiText("Rotated")
UiPop()
```

## UiScale
Arguments:
- x (number) – X component
- y (number, optional) – Y component. Default value is x.

Scale cursor either uniformly (one argument) or non-uniformly (two arguments)

```lua
UiPush()
	UiScale(2)
	UiText("Double size")
UiPop()
```

## UiWindow
Arguments:
- width (number) – Window width
- height (number) – Window height
- clip (boolean, optional) – Clip content outside window. Default is false.
- inherit (boolean, optional) – Inherit current clip region (for nested clip regions)

Set up new bounds.  
Calls to UiWidth, UiHeight, UiCenter and UiMiddle will operate in the context of the window size.  
If clip is set to true, contents of window will be clipped to bounds (only works properly for non-rotated windows).

```lua
UiPush()
	UiWindow(400, 200)
	local w = UiWidth()
	--w is now 400
UiPop()
```

## UiSafeMargins
Return value:
- x0 (number) – Left
- y0 (number) – Top
- x1 (number) – Right
- y1 (number) – Bottom

Return a safe drawing area that will always be visible regardless of display aspect ratio.  
The safe drawing area will always be 1920 by 1080 in size. This is useful for setting up a fixed size UI.

```lua
function draw()
	local x0, y0, x1, y1 = UiSafeMargins()
	UiTranslate(x0, y0)
	UiWindow(x1-x0, y1-y0, true)
	--The drawing area is now 1920 by 1080 in the center of screen
	drawMenu()
end
```

## UiAlign
Arguments:
- alignment (string) – Alignment keywords

The alignment determines how content is aligned with respect to the cursor.
| Alignment |  Description |
| - | - |
| left | Horizontally align to the left |
| right | Horizontally align to the right |
| center | Horizontally align to the center |
| top | Vertically align to the top |
| bottom | Veritcally align to the bottom |
| middle | Vertically align to the middle |

Alignment can contain combinations of these, for instance: "center middle", "left top", "center top", etc.  
If horizontal or vertical alginment is omitted it will depend on the element drawn.  
Text, for instance has default vertical alignment at baseline.

```lua
UiAlign("left")
UiText("Aligned left at baseline")

UiAlign("center middle")
UiText("Fully centered")
```


## UiModalBegin
Disable input for everything, except what's between UiModalBegin and UiModalEnd (or if modal state is popped)

```lua
UiModalBegin()
if UiTextButton("Okay") then
	--All other interactive ui elements except this one are disabled
end
UiModalEnd()

--This is also okay
UiPush()
	UiModalBegin()
	if UiTextButton("Okay") then
		--All other interactive ui elements except this one are disabled
	end
UiPop()
--No longer modal
```


## UiModalEnd
Disable input for everything, except what's between UiModalBegin and UiModalEnd Calling this function is optional.  
Modality is part of the current state and will be lost if modal state is popped.

```lua
UiModalBegin()
if UiTextButton("Okay") then
	--All other interactive ui elements except this one are disabled
end
UiModalEnd()
```

## UiDisableInput
Disable input

```lua
UiPush()
	UiDisableInput()
	if UiTextButton("Okay") then
		--Will never happen
	end
UiPop()
```

## UiEnableInput
Enable input that has been previously disabled

```lua
UiDisableInput()
if UiTextButton("Okay") then
	--Will never happen
end

UiEnableInput()
if UiTextButton("Okay") then
	--This can happen
end
```

## UiReceivesInput
Return value:
- receives (boolean) – True if current context receives input

This function will check current state receives input.  
This is the case if input is not explicitly disabled with (with UiDisableInput) and no other state is currently modal (with UiModalBegin).  
Input functions and UI elements already do this check internally, but it can sometimes be useful to read the input state manually to trigger things in the UI. 

```lua
if UiReceivesInput() then
	highlightItemAtMousePointer()
end
```


## UiGetMousePos
Return value:
- x (number) – X coordinate
- y (number) – Y coordinate

Get mouse pointer position relative to the cursor

```lua
local x, y = UiGetMousePos()
```

## UiIsMouseInRect
Arguments:
- w (number) – Width
- h (number) – Height

Return value:
- inside (boolean) – True if mouse pointer is within rectangle

Check if mouse pointer is within rectangle.  
Note that this function respects alignment.

```lua
if UiIsMouseInRect(100, 100) then
	-- mouse pointer is in rectangle
end
```


## UiWorldToPixel
Arguments:
- point (table) – 3D world position as vector

Return value:
- x (number) – X coordinate
- y (number) – Y coordinate
- distance (number) – Distance to point

Convert world space position to user interface X and Y coordinate relative to the cursor.  
The distance is in meters and positive if in front of camera, negative otherwise.

```lua
local x, y, dist = UiWorldToPixel(point)
if dist > 0 then
UiTranslate(x, y)
UiText("Label")
end
```

## UiPixelToWorld
Arguments:
- x (number) – X coordinate
- y (number) – Y coordinate

Return value:
- direction (table) – 3D world direction as vector

Convert X and Y UI coordinate to a world direction, as seen from current camera.  
This can be used to raycast into the scene from the mouse pointer position.

```lua
UiMakeInteractive()
local x, y = UiGetMousePos()
local dir = UiPixelToWorld(x, y)
local pos = GetCameraTransform().pos
local hit, dist = QueryRaycast(pos, dir, 100)
if hit then
	DebugPrint("hit distance: " .. dist)
end
```

## UiBlur
Arguments:
- amount (number) – Blur amount (0.0 to 1.0)

Perform a gaussian blur on current screen content

```lua
UiBlur(1.0)
drawMenu()
```

## UiFont
Arguments:
- path (string) – Path to TTF font file
- size (number) – Font size (10 to 100)

| Font | Description |
| - | - |
| regular.ttf | Regular font |
| bold.ttf | Bold font |

Game contains a reference to "ProggyClean.ttf" at 140356700,
However it's unusable. Probably deprecated at some point.

Another font used in the game is pixeloid.ttf used exclusively in art vandals.  
Check art vandals code to learn how to implement custom fonts properly.  

```lua
UiFont("bold.ttf", 24)
UiText("Hello")
```

## UiFontHeight

Return value:
- size (number) – Font size

```lua
local h = UiFontHeight()
```

## UiText
Arguments:
- text (string) – Print text at cursor location
- move (boolean, optional) – Automatically move cursor vertically. Default false.

Return value:
- w (number) – Width of text
- h (number) – Height of text
- x (number) – End x-position of text. Only valid when "advance cursor" is false
- y (number) – End y-position of text. Only valid when "advance cursor" is false

```lua
UiFont("bold.ttf", 24)
UiText("Hello")

...

--Automatically advance cursor
UiText("First line", true)
UiText("Second line", true)
```


## UiGetTextSize
Arguments:
- text (string) – A text string

Return value:
- w (number) – Width of text
- h (number) – Height of text

```lua
local w, h = UiGetTextSize("Some text")
```

## UiWordWrap
Arguments:
- width (number) – Maximum width of text

```lua
UiWordWrap(200)
UiText("Some really long text that will get wrapped into several lines")
```

## UiTextOutline
Arguments:
- r (number) – Red channel
- g (number) – Green channel
- b (number) – Blue channel
- a (number) – Alpha channel
- thickness (number, optional) – Outline thickness. Default is 0.1

```lua
--Black outline, standard thickness
UiTextOutline(0,0,0,1)
UiText("Text with outline")
```

## UiTextShadow
Arguments:
- r (number) – Red channel
- g (number) – Green channel
- b (number) – Blue channel
- a (number) – Alpha channel
- distance (number, optional) – Shadow distance. Default is 1.0
- blur (number, optional) – Shadow blur. Default is 0.5

```lua
--Black drop shadow, 50% transparent, distance 2
UiTextShadow(0, 0, 0, 0.5, 2.0)
UiText("Text with drop shadow")
```


## UiRect
Arguments:
- w (number) – Width
- h (number) – Height

Draw solid rectangle at cursor position
```lua
--Draw full-screen black rectangle
UiColor(0, 0, 0)
UiRect(UiWidth(), UiHeight())

--Draw smaller, red, rotating rectangle in center of screen
UiPush()
	UiColor(1, 0, 0)
	UiTranslate(UiCenter(), UiMiddle())
	UiRotate(GetTime())
	UiAlign("center middle")
	UiRect(100, 100)
UiPop()
```


## UiImage
Arguments:
- path (string) – Path to image (PNG or JPG format)
- x0 (number, optional) – Lower x coordinate (default is 0)
- y0 (number, optional) – Lower y coordinate (default is 0)
- x1 (number, optional) – Upper x coordinate (default is image width)
- y1 (number, optional) – Upper y coordinate (default is image height)

Return value:
- w (number) – Width of drawn image
- h (number) – Height of drawn image

Draw image at cursor position. If x0, y0, x1, y1 is provided a cropped version will be drawn in that coordinate range.  
fun fact, game does not support the full jpeg spec, while the official docs say to use PNG or JPG format  
if you use the wrong jpeg format the game will crash (stick to png to be safe)

```lua
--Draw image in center of screen
UiPush()
	UiTranslate(UiCenter(), UiMiddle())
	UiAlign("center middle")
	UiImage("test.png")
UiPop()
```


## UiGetImageSize
Arguments:
- path (string) – Path to image (PNG or JPG format)

Return value:
- w (number) – Image width
- h (number) – Image height

Get image size

```lua
local w, h = UiGetImageSize("test.png")
```


## UiImageBox
Arguments:
- path (string) – Path to image (PNG or JPG format)
- width (number) – Width
- height (number) – Height
- borderWidth (number) – Border width
- borderHeight (number) – Border height

Draw 9-slice image at cursor position.  
Width should be at least 2*borderWidth.  
Height should be at least 2*borderHeight.

```lua
UiImageBox("menu-frame.png", 200, 200, 10, 10)
```


## UiSound
Arguments:
- path (string) – Path to sound file (OGG format)
- volume (number, optional) – Playback volume. Default 1.0
- pitch (number, optional) – Playback pitch. Default 1.0
- pan (number, optional) – Playback stereo panning (-1.0 to 1.0). Default 0.0.

UI sounds are not affected by acoustics simulation.  
Use LoadSound / PlaySound for that.

```lua
UiSound("click.ogg")
```

## UiSoundLoop
Arguments:
- path (string) – Path to looping sound file (OGG format)
- volume (number, optional) – Playback volume. Default 1.0

Call this continuously to keep playing loop.  
UI sounds are not affected by acoustics simulation.  
Use LoadLoop / PlayLoop for that.

```lua
if animating then
	UiSoundLoop("screech.ogg")
end
```

## UiMute
Arguments:
- amount (number) – Mute by this amount (0.0 to 1.0)
- music (boolean, optional) – Mute music as well

Mute game audio and optionally music for the next frame.  
Call continuously to stay muted.

```lua
if menuOpen then
	UiMute(1.0)
end
```


## UiButtonImageBox
Arguments:
- path (string) – Path to image (PNG or JPG format)
- borderWidth (number) – Border width
- borderHeight (number) – Border height
- r (number, optional) – Red multiply. Default 1.0
- g (number, optional) – Green multiply. Default 1.0
- b (number, optional) – Blue multiply. Default 1.0
- a (number, optional) – Alpha channel. Default 1.0

Set up 9-slice image to be used as background for buttons.

```lua
UiButtonImageBox("button-9slice.png", 10, 10)
if UiTextButton("Test") then
	...
end
```

## UiButtonHoverColor
Arguments:
- r (number) – Red multiply
- g (number) – Green multiply
- b (number) – Blue multiply
- a (number, optional) – Alpha channel. Default 1.0

Button color filter when hovering mouse pointer.

```lua
UiButtonHoverColor(1, 0, 0)
if UiTextButton("Test") then
	...
end
```

## UiButtonPressColor
Arguments:
- r (number) – Red multiply
- g (number) – Green multiply
- b (number) – Blue multiply
- a (number, optional) – Alpha channel. Default 1.0

Button color filter when pressing down.

```lua
UiButtonPressColor(0, 1, 0)
if UiTextButton("Test") then
	...
end
```

## UiButtonPressDist
Arguments:
- dist (number) – Press distance

The button offset when being pressed

```lua
UiButtonPressDistance(4)
if UiTextButton("Test") then
	...
end
```

## UiTextButton
Arguments:
- text (string) – Text on button
- w (number, optional) – Button width
- h (number, optional) – Button height

Return value:
- pressed (boolean) – True if user clicked button

```lua
if UiTextButton("Test") then
	...
end
```


## UiImageButton
Arguments:
- path (number) – Image path (PNG or JPG file)

Return value:
- pressed (boolean) – True if user clicked button

```lua
if UiImageButton("image.png") then
	...
end
```

## UiBlankButton
Arguments:
- w (number) – Button width
- h (number) – Button height

Return value:
- pressed (boolean) – True if user clicked button

```lua
if UiBlankButton(30, 30) then
	...
end
```


## UiSlider
Arguments:
- path (number) – Image path (PNG or JPG file)
- axis (string) – Drag axis, must be "x" or "y"
- current (number) – Current value
- min (number) – Minimum value
- max (number) – Maximum value

Return value:
- value (number) – New value, same as current if not changed
- done (boolean) – True if user is finished changing (released slider)

```lua
value = UiSlider("dot.png", "x", value, 0, 100)
```

## UiGetScreen
Return value:
- handle (number) – Handle to the screen running this script or zero if none.

```lua
--Turn off screen running current script
screen = UiGetScreen()
SetScreenEnabled(screen, false)
```
