client.utils_IsDirectionalInput = function()
    local lockInputs = config_GetVar(GetBool, fInputLock)
    if lockInputs ~= nil then 
        return false 
    end

    return InputDown("up") or InputDown("down") or InputDown("left") or InputDown("right")
end

server.utils_IsDirectionalInput = function(playerID)
    local e = syncedPlayerSetting[playerID]
    if not e then 
        return false 
    end

    local lockInputs = server.getPlayerConfigValue(playerID, config_getKey(fInputLock))
    if lockInputs then 
        return false 
    end

    return InputDown("up", playerID) or InputDown("down", playerID) or InputDown("left", playerID) or InputDown("right", playerID)
end

client.utils_Input = function(InputFunction, input)
    local lockInputs = config_GetVar(GetBool, fInputLock)
    if lockInputs ~= nil then 
        return false 
    end

    --[[
        InputDown / InputPressed
    ]]
    return InputFunction(input)
end

server.utils_Input = function(InputFunction, input, playerID)
    local e = syncedPlayerSetting[playerID]
    if not e then 
        return false 
    end

    local lockInputs = server.getPlayerConfigValue(playerID, config_getKey(fInputLock))
    if lockInputs then 
        return false 
    end

    --[[
        InputDown / InputPressed
    ]]
    return InputFunction(input, playerID)
end

-- returns direction[vec3] and camera[table]
-- ex. local direction, camera = GetForwardDirection()
utils_GetForwardDirection = function()
	local camera = GetCameraTransform() -- why is this client only btw
	local parentpoint = TransformToParentPoint(camera, Vec(0, 0, 1))
    return VecNormalize(VecSub(camera.pos, parentpoint)), camera
end

-- returns ray hit[vec3]
-- ex. local endpos = GetPosWeAreLookingAt()
utils_GetPosWeAreLookingAt = function()
    local direction, camera = utils_GetForwardDirection() 
    local hit, dist = QueryRaycast(camera.pos, direction, 666)
    if hit then 
        return TransformToParentPoint(camera, Vec(0, 0, -dist))
    end
    return nil 
end

-- returns body[handle] and distance[float]
-- ex. local body, dist = GetObjectWeAreLookingAt()
utils_GetObjectWeAreLookingAt = function()
    local direction, camera = utils_GetForwardDirection() 
    local hit, dist, normal, shape = QueryRaycast(camera.pos, direction, 666)

    if hit then 
        return GetShapeBody(shape), dist
    end
    return nil 
end

-- accepts offset[float], ex. GetTime()
-- returns rgb[table] with R G B [float] values
-- ex. local rainbow = seedToRGB(GetTime())
utils_seedToRGB = function(y)
    local rgb = {}
    rgb.R = math.sin(y + 0) * 0.5 + 0.5
    rgb.G = math.sin(y + 2) * 0.5 + 0.5
    rgb.B = math.sin(y + 4) * 0.5 + 0.5
    return rgb 
end

-- accepts body[handle]
-- returns center of body[vec3]
utils_GetBodyCenter = function(body)
    local min, max = GetBodyBounds(body)
    return VecLerp(min, max, 0.5)
end

-- accepts pointA[vec3] pointB[vec3]
-- returns a [float]
utils_VecDist = function(vecA, vecB)
    local delta = VecSub(vecA, vecB)
    return math.sqrt(delta[1]^2 + delta[2]^2 + delta[3]^2)
end

-- accepts [vec3] [vec3]
-- returns a [bool]
utils_VecCompare = function(vecA, vecB)
    return vecA[1] == vecB[1] and vecA[2] == vecB[2] and vecA[3] == vecB[3]
end

-- accepts body[handle]
-- returns size[float]
utils_GetBodySize = function(body)
    local min, max = GetBodyBounds(body)
    return utils_VecDist(min, max)
end

-- accepts a [float]
-- returns closest [int]
utils_Round = function(value)
    return math.floor(value+0.5)
end

-- accepts 3 values, either [float] or [int]
-- returns a [float] or [int]
utils_Clamp = function(a, x, y) 
    if a < x then a = x end 
    if a > y then a = y end 
    return a
end

-- accepts a dvd[table] and delta time[float]
-- returns updated frame of dvd[table]
utils_animateDvd = function(dvd, dt)
    dvd.x = dvd.x + dvd.speedx * dt
    dvd.y = dvd.y + dvd.speedy * dt
    
    if dvd.x < 0 then
        dvd.x = 0
        dvd.speedx = -dvd.speedx
    elseif dvd.x + dvd.width > UiWidth() then
        dvd.x = UiWidth() - dvd.width
        dvd.speedx = -dvd.speedx
    end

    if dvd.y < 0 then
        dvd.y = 0
        dvd.speedy = -dvd.speedy
    elseif dvd.y + dvd.height > UiHeight() then
        dvd.y = UiHeight() - dvd.height
        dvd.speedy = -dvd.speedy
    end
    
    return dvd
end

-- accepts registry key[string]
-- returns boolean
utils_DirtyWriteAccessCheck = function(key)
    local d = GetString(key)
    
    -- attempt to change the key value
    SetString(key, "tearware")

    -- let's hope you don't crash here!

    -- successfully changed key value
    if GetString(key) == "tearware" then
        SetString(key, d)
        -- now you can crash
        return true
    end

    -- we failed to change key value, no need to restore
    return false
end

-- accepts an input[char]
-- can pass input[string] as unmodified [string], after wasting cpu cycles
-- returns modified [char]
utils_InputCapitalization = function(input)
    for i=1, #ghettoKeyMap do
        if input == ghettoKeyMap[i][1] then
            if InputDown("shift") then
                return ghettoKeyMap[i][3]
            else
                return ghettoKeyMap[i][2]
            end
        end
    end
    return input
end

-- accepts a [string] and cursor[int]
-- returns a modified [string], a [bool] if the [string] was modified, and updated cursor[int]
-- does NOT draw anything use DrawInputStringCursor for drawing the cursor and uitext for the string.
-- todo:
-- add ctrl interaction to the cursor, so it can skip words. 
-- issues:
-- Numpad makes InputLastPressedKey() output letters.
-- 0=A, 1=B, 2=C ... 9=I,/=O, *=J, -=M, +=K, ,=N
utils_ModifyString = function(base, cursorPos)

    if cursorPos == nil then 
        cursorPos = #base + 1
        inputStringCursorSwitchTimer = 0
        inputStringDrawCursor = false
    elseif inputStringCursorTimer <= GetTime() then
        if InputDown("leftarrow") then 
            cursorPos = utils_Clamp(cursorPos - 1, 1, #base+1)
            inputStringCursorTimer = GetTime() + 0.1
            inputStringCursorSwitchTimer = 0
            inputStringDrawCursor = false
        elseif InputDown("rightarrow")then 
            cursorPos = utils_Clamp(cursorPos + 1, 1, #base+1)
            inputStringCursorTimer = GetTime() + 0.1
            inputStringCursorSwitchTimer = 0
            inputStringDrawCursor = false
        end
    end

    local old_state = base

    -- split base based on cursorPos
    local stringEnd = string.sub(base, cursorPos)

    -- only parts of base before the cursor
    local base = string.sub(base, 1, cursorPos - 1)

    local input = InputLastPressedKey()

    -- not a single char
    if #input > 1 then
        if input == "space" then
            base = base .. " "
            cursorPos = utils_Clamp(cursorPos + 1, 1, #old_state+2)
        end
    elseif input ~= nil and input ~= "" then
        base = base .. utils_InputCapitalization(input)
        cursorPos = utils_Clamp(cursorPos + 1, 1, #old_state+2)
    else
        for i=1, #keysNotInLastPressedKey do
            if InputPressed(keysNotInLastPressedKey[i][1]) then
                if InputDown("shift") then
                    base = base .. keysNotInLastPressedKey[i][3]
                else
                    base = base .. keysNotInLastPressedKey[i][2]
                end
                cursorPos = utils_Clamp(cursorPos + 1, 1, #old_state+2)
            end
        end

        if InputDown("backspace") then
            if #base > 0 then
                if inputStringBackspaceTimer <= GetTime() then
                    base = base:sub(1, -2)
                    inputStringBackspaceTimer = GetTime() + 0.1
                    cursorPos = utils_Clamp(cursorPos - 1, 1, #old_state+2)
                end
            end
        end
    end

    -- restore the part of the string after the cursor
    base = base .. stringEnd
    
    local modified = not (old_state == base)
    
    -- if we changed the string, ask the cursor to redraw
    if modified then 
        inputStringCursorSwitchTimer = 0
        inputStringDrawCursor = false
    end

    return base, modified, cursorPos
end

-- accepts a [string] and cursor[int]
-- draws a Rect at the cursor pos,
-- doesn't do anything if cursor is invalid [nil]
utils_DrawInputStringCursor = function(base, cursorPos, alignment)
    -- make it pop in and out like in all funny text editors.
    inputStringDrawCursor = math.floor(GetTime() * 3) % 2 == 0

    if not inputStringDrawCursor then return end

    UiPush()
        local prefix = string.sub(base, 1, cursorPos - 1)
        
        local prefixWidth, prefixHeight = UiGetTextSize(prefix)
        local fullWidth = UiGetTextSize(base)

        local a,b = UiGetTextSize("|")

        local x = prefixWidth

        -- align it.
        if alignment == "center" then 
           x = prefixWidth - (fullWidth / 2)
        elseif alignment == "right" then
            x = prefixWidth - fullWidth
        end

        UiTranslate(x + 1, 0)
        UiRect(2, b)
    UiPop()
end

-- outputs an array[1~3] of floats in range of -1 to 1
utils_RandomVector = function()
    local x = math.random()*2 - 1 -- Random value between -1 and 1
    local y = math.random()*2 - 1 -- Random value between -1 and 1
    local z = math.random()*2 - 1 -- Random value between -1 and 1

    return {x, y, z}
end

-- accepts Min[vec3] Max[vec3]
-- optionally accepts R[float], G[float], B[float], A[float]
utils_DebugDrawCube = function(Min, Max, r, g, b, a)
    r=r or 1
    g=g or 1
    b=b or 1
    a=a or 1
    
    DebugLine(Vec(Min[1],Min[2],Min[3]),Vec(Min[1],Min[2],Max[3]),r,g,b,a)
    DebugLine(Vec(Min[1],Min[2],Min[3]),Vec(Min[1],Max[2],Min[3]),r,g,b,a)
    DebugLine(Vec(Min[1],Min[2],Min[3]),Vec(Max[1],Min[2],Min[3]),r,g,b,a)
    
    DebugLine(Vec(Max[1],Max[2],Min[3]),Vec(Max[1],Max[2],Max[3]),r,g,b,a)
    DebugLine(Vec(Max[1],Min[2],Max[3]),Vec(Max[1],Max[2],Max[3]),r,g,b,a)
    DebugLine(Vec(Min[1],Max[2],Max[3]),Vec(Max[1],Max[2],Max[3]),r,g,b,a)
    
    DebugLine(Vec(Max[1],Min[2],Min[3]),Vec(Max[1],Min[2],Max[3]),r,g,b,a)
    DebugLine(Vec(Min[1],Max[2],Min[3]),Vec(Max[1],Max[2],Min[3]),r,g,b,a)
    DebugLine(Vec(Min[1],Min[2],Max[3]),Vec(Min[1],Max[2],Max[3]),r,g,b,a)
    
    DebugLine(Vec(Min[1],Max[2],Min[3]),Vec(Min[1],Max[2],Max[3]),r,g,b,a)
    DebugLine(Vec(Min[1],Min[2],Max[3]),Vec(Max[1],Min[2],Max[3]),r,g,b,a)
    DebugLine(Vec(Max[1],Min[2],Min[3]),Vec(Max[1],Max[2],Min[3]),r,g,b,a)
end

-- accepts Min[vec3] Max[vec3]
-- optionally accepts R[float], G[float], B[float], A[float]
utils_DebugDrawCylinder = function(Min, Max, r, g, b, a)
    r=r or 1
    g=g or 1
    b=b or 1
    a=a or 1
    local center = VecLerp(Min, Max, 0.5)
    local radius = utils_VecDist( {Min[1], 0, Min[3] }, { Max[1], 0, Max[3]}) / 2
    local height = Max[2] - Min[2]
    local numSegments = 16
    local angleIncrement = (2 * math.pi) / numSegments
    local currentAngle = 0
    for i = 1, numSegments do
        local x1 = center[1] + (math.cos(currentAngle) * radius)
        local z1 = center[3] + (math.sin(currentAngle) * radius)
        local x2 = center[1] + (math.cos(currentAngle + angleIncrement) * radius)
        local z2 = center[3] + (math.sin(currentAngle + angleIncrement) * radius)
        DebugLine(Vec(x1, Min[2], z1), Vec(x1, Max[2], z1), r, g, b, a)
        DebugLine(Vec(x1, Min[2], z1), Vec(x2, Min[2], z2), r, g, b, a)
        DebugLine(Vec(x1, Max[2], z1), Vec(x2, Max[2], z2), r, g, b, a)
        currentAngle = currentAngle + angleIncrement
    end
end

-- accepts table A = {} B = {}
-- returns whether A == B
utils_tableCompare = function(A, B)
    if A == nil and B == nil then return true end -- if both nil
    if A == nil or B == nil then return false end -- if either nil
    if A == B then return true end -- if not an array and same value, or if same array pointer

    for k, v in pairs(A) do
        if B[k] ~= v then
            return false -- if A[x] != B[x] 
        end
    end
    return true
end

utils_GetLastInputBetter = function()
    local realInput = InputLastPressedKey()
    if realInput == nil or realInput == "" then 
        for i=1, #keysNotInLastPressedKey do
            if InputPressed(keysNotInLastPressedKey[i][1]) then
                realInput = keysNotInLastPressedKey[i][1]
            end
        end
    end
    return realInput
end

utils_ShortenKeyString = function(string)
    if #string > 2 then 
        if keyShort[string] then 
            return keyShort[string]
        end 
        -- DebugPrint(keyShort[string])
    end
    return string 
end

utils_boolStr = function(bool)
    if bool then return "True" else return "False" end
end

utils_floatStr = function(float, precision)
    precision = precision or 2
    return string.format("%." .. precision .. "f", float)
end

-- hides tearware from the modlist.
function utils_ghostMode()
    local ourKeys = {}
    
    -- workshop key
    ourKeys[#ourKeys+1] = "steam-2798126764"

    -- debug keys
    ourKeys[#ourKeys+1] = "local-tearware-git"
    ourKeys[#ourKeys+1] = "local-tearware"

    for i = 1, #ourKeys do
        if HasKey("mods.available." .. ourKeys[i] .. ".active") then 
            SetBool("mods.available." .. ourKeys[i] .. ".active", false)
        end

        if HasKey("mods.available." .. ourKeys[i] .. ".subscribetime") then 
            SetString("mods.available." .. ourKeys[i] .. ".subscribetime", nil)
        end
    end
end
