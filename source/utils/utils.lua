-- tearware on top

-- accepts euler yaw[float]
-- returns modified euler yaw[float] based on inputs
-- ex. local newyaw = TransformYawByInput(oldyaw)
-- context ex. changing direction of velocity
utils.TransformYawByInput = function(y)
    y=y or 1

    if lockInputs then return y end

    local Forward = InputDown("up") 
    local Back = InputDown("down")
    local Left = InputDown("left")
    local Right = InputDown("right")

    -- there must be a better way of doing this...
    if Forward then
        if Left then
            y = y + 45
        elseif Right then
            y = y - 45
        end
    elseif Back then 
        y = y + 180
        if Left  then
            y = y - 45
        elseif Right  then
            y = y + 45
        end
    else
        if Left then
            y = y + 90
        elseif Right then
            y = y - 90
        else 
            return 
        end
    end

    -- clamp it
    return math.fmod(y + 180, 360) - 180
end

-- returns whether any input is pressed[bool]
-- ex. if IsDirectionalInputDown then
utils.IsDirectionalInputDown = function() 
    if lockInputs then return false end
    return InputDown("up") or InputDown("down") or InputDown("left") or InputDown("right")
end

-- returns direction[vec3] and camera[table]
-- ex. local direction, camera = GetForwardDirection()
utils.GetForwardDirection = function()
	local camera = GetCameraTransform()
	local parentpoint = TransformToParentPoint(camera, Vec(0, 0, 1))
    return VecNormalize(VecSub(camera.pos, parentpoint)), camera
end

-- returns ray hit[vec3]
-- ex. local endpos = GetPosWeAreLookingAt()
utils.GetPosWeAreLookingAt = function()
    local direction, camera = utils.GetForwardDirection() 
    local hit, dist = QueryRaycast(camera.pos, direction, 666)
    if hit then 
        return TransformToParentPoint(camera, Vec(0, 0, -dist))
    end
    return nil 
end

-- returns body[handle] and distance[float]
-- ex. local body, dist = GetObjectWeAreLookingAt()
utils.GetObjectWeAreLookingAt = function()
    local direction, camera = utils.GetForwardDirection() 
    local hit, dist, normal, shape = QueryRaycast(camera.pos, direction, 666)

    if hit then 
        return GetShapeBody(shape), dist
    end
    return nil 
end

-- accepts offset[float], ex. GetTime()
-- returns rgb[table] with R G B [float] values
-- ex. local rainbow = seedToRGB(GetTime())
utils.seedToRGB = function(y)
    local rgb = {}
    rgb.R = math.sin(y + 0) * 0.5 + 0.5
    rgb.G = math.sin(y + 2) * 0.5 + 0.5
    rgb.B = math.sin(y + 4) * 0.5 + 0.5
    return rgb 
end

-- accepts body[handle]
-- returns center of body[vec3]
utils.GetBodyCenter = function(body)
    local min, max = GetBodyBounds(body)
    return VecLerp(min, max, 0.5)
end

-- accepts pointA[vec3] pointB[vec3]
-- returns a [float]
utils.VecDist = function(vecA, vecB)
    local delta = VecSub(vecA, vecB)
    return math.sqrt(delta[1]^2 + delta[2]^2 + delta[3]^2)
end

-- accepts body[handle]
-- returns size[float]
utils.GetBodySize = function(body)
    local min, max = GetBodyBounds(body)
    return VecDist(min, max)
end

-- accepts a [float]
-- returns closest [int]
utils.MathRound = function(value)
    return math.floor(value+0.5)
end

-- accepts 3 values, either [float] or [int]
-- returns a [float] or [int]
utils.Clamp = function(a, x, y) 
    if a < x then a = x end 
    if a > y then a = y end 
    return a
end

-- accepts a dvd[table] and delta time[float]
-- returns updated frame of dvd[table]
utils.animateDvd = function(dvd, dt)
    dvd.x = dvd.x + dvd.speedx * dt
    dvd.y = dvd.y + dvd.speedy * dt
    
    if dvd.x < 0 or dvd.x + dvd.width > UiWidth() then
      dvd.speedx = -dvd.speedx
    end
    if dvd.y < 0 or dvd.y + dvd.height > UiHeight() then
      dvd.speedy = -dvd.speedy
    end
    return dvd
end

-- accepts registry key[string]
-- returns boolean
utils.DirtyWriteAccessCheck = function(key)
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
utils.InputCapitalization = function(input)
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
utils.ModifyString = function(base, cursorPos)

    if cursorPos == nil then 
        cursorPos = #base + 1
        inputStringCursorSwitchTimer = 0
        inputStringDrawCursor = false
    elseif inputStringCursorTimer <= GetTime() then
        if InputDown("leftarrow") then 
            cursorPos = utils.Clamp(cursorPos - 1, 1, #base+1)
            inputStringCursorTimer = GetTime() + 0.1
            inputStringCursorSwitchTimer = 0
            inputStringDrawCursor = false
        elseif InputDown("rightarrow")then 
            cursorPos = utils.Clamp(cursorPos + 1, 1, #base+1)
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
            cursorPos = utils.Clamp(cursorPos + 1, 1, #old_state+2)
        end
    elseif input ~= nil and input ~= "" then
        base = base .. utils.InputCapitalization(input)
        cursorPos = utils.Clamp(cursorPos + 1, 1, #old_state+2)
    else
        for i=1, #keysNotInLastPressedKey do
            if InputPressed(keysNotInLastPressedKey[i][1]) then
                if InputDown("shift") then
                    base = base .. keysNotInLastPressedKey[i][3]
                else
                    base = base .. keysNotInLastPressedKey[i][2]
                end
                cursorPos = utils.Clamp(cursorPos + 1, 1, #old_state+2)
            end
        end

        if InputDown("backspace") then
            if #base > 0 then
                if inputStringBackspaceTimer <= GetTime() then
                    base = base:sub(1, -2)
                    inputStringBackspaceTimer = GetTime() + 0.1
                    cursorPos = utils.Clamp(cursorPos - 1, 1, #old_state+2)
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
utils.DrawInputStringCursor = function(base, cursorPos)
    if cursorPos == nil then return end

    -- make it pop in and out like in all funny text editors.
    if inputStringCursorSwitchTimer <= GetTime() then
        inputStringCursorSwitchTimer = GetTime() + 0.5
        inputStringDrawCursor = not inputStringDrawCursor
    end

    if not inputStringDrawCursor then return end

    UiPush()
        local base = string.sub(base, 1, cursorPos - 1)
        
        -- add a dot at the end so that spaces aren't skipped
        -- when calculating string size
        base = base .. "dot"

        local basex, basey = UiGetTextSize(base)
        
        -- now get the dot size
        local dotx, doty = UiGetTextSize("dot") 
        
        local translatedOffset = basex - dotx + 3

        UiTranslate(translatedOffset, 0)
        
        UiRect(2, basey)
    UiPop()
end

-- accepts Min[vec3] Max[vec3]
-- optionally accepts R[float], G[float], B[float], A[float]
utils.DebugDrawCube = function(Min, Max, r, g, b, a)
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
utils.DebugDrawCylinder = function(Min, Max, r, g, b, a)
    r=r or 1
    g=g or 1
    b=b or 1
    a=a or 1
    local center = VecLerp(Min, Max, 0.5)
    local radius = VecDist( {Min[1], 0, Min[3] }, { Max[1], 0, Max[3]}) / 2
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

utils.TWInputDown = function(input)
    if lockInputs then return false end
    return InputDown(input)
end

utils.TWInputPressed = function(input)
    if lockInputs then return false end
    return InputPressed(input)
end