-- tearware on top

-- accepts euler yaw[float]
-- returns modified euler yaw[float] based on inputs
-- ex. local newyaw = TransformYawByInput(oldyaw)
-- context ex. changing direction of velocity
function TransformYawByInput(y)
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
function IsDirectionalInputDown() 
    return InputDown("up") or InputDown("down") or InputDown("left") or InputDown("right")
end

-- returns direction[vec3] and camera[table]
-- ex. local direction, camera = GetForwardDirection()
function GetForwardDirection() 
	local camera = GetCameraTransform()
	local parentpoint = TransformToParentPoint(camera, Vec(0, 0, 1))
    return VecNormalize(VecSub(camera.pos, parentpoint)), camera
end

-- returns ray hit[vec3]
-- ex. local endpos = GetPosWeAreLookingAt()
function GetPosWeAreLookingAt()
    local direction, camera = GetForwardDirection() 
    local hit, dist = QueryRaycast(camera.pos, direction, 666)
    if hit then 
        return TransformToParentPoint(camera, Vec(0, 0, -dist))
    end
    return nil 
end

-- returns body[handle] and distance[float]
-- ex. local body, dist = GetObjectWeAreLookingAt()
function GetObjectWeAreLookingAt()
    local direction, camera = GetForwardDirection() 
    local hit, dist, normal, shape = QueryRaycast(camera.pos, direction, 666)

    if hit then 
        return GetShapeBody(shape), dist
    end
    return nil 
end

-- accepts offset[float], ex. GetTime()
-- returns rgb[table] with R G B [float] values
-- ex. local rainbow = seedToRGB(GetTime())
function seedToRGB(y)
    local rgb = {}
    rgb.R = math.sin(y + 0) * 0.5 + 0.5
    rgb.G = math.sin(y + 2) * 0.5 + 0.5
    rgb.B = math.sin(y + 4) * 0.5 + 0.5
    return rgb 
end

-- accepts body[handle]
-- returns center of body[vec3]
function GetBodyCenter(body)
    local min, max = GetBodyBounds(body)
    return VecLerp(min, max, 0.5)
end

-- accepts pointA[vec3] pointB[vec3]
-- returns a [float]
function VecDist(vecA, vecB)
    local delta = VecSub(vecA, vecB)
    return math.sqrt(delta[1]^2 + delta[2]^2 + delta[3]^2)
end

-- accepts a [float]
-- returns closest [int]
function MathRound(value)
    return math.floor(value+0.5)
end

-- accepts 3 values, either [float] or [int]
-- returns a [float] or [int]
function Clamp(a, x, y) 
    if a < x then a = x end 
    if a > y then a = y end 
    return a
end

-- accepts a dvd[table] and delta time[float]
-- returns updated frame of dvd[table]
function animateDvd(dvd, dt)
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
function DirtyWriteAccessCheck(key)
    local d = GetString(key)
    -- attempt to change the key value
    SetString(key, "tearware")

    -- successfully changed key value
    if GetString(key) == "tearware" then
        SetString(key, d)
        return true
    end

    -- we failed to change key value, no need to restore
    return false
end

-- accepts an input[char]
-- can pass input[string] as unmodified [string], after wasting cpu cycles
-- returns modified [char]
function InputCapitalization(input)
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

-- accepts a [string]
-- returns a modified [string]
-- todo:
-- add a cursor to it, so you don't need to rewrite strings
function ModifyString(base)
    local input = InputLastPressedKey()
    -- not a single char
    if #input > 1 then
        if input == "space" then
            base = base .. " "
        end
    elseif input ~= nil and input ~= "" then
        base = base .. InputCapitalization(input)
    else
        for i=1, #keysNotInLastPressedKey do
            if InputPressed(keysNotInLastPressedKey[i][1]) then
                if InputDown("shift") then
                    base = base .. keysNotInLastPressedKey[i][3]
                else
                    base = base .. keysNotInLastPressedKey[i][2]
                end
            end
        end

        if InputDown("backspace") then
            if #base > 0 then
                if inputStringBackspaceTimer <= GetTime() then
                    base = base:sub(1, -2)
                    inputStringBackspaceTimer = GetTime() + 0.1
                end
            end
        end
    end
    return base
end

-- accepts Min[vec3] Max[vec3]
-- optionally accepts R, G, B, A
function DebugDrawCube(Min, Max, r, g, b, a)
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
-- optionally accepts R, G, B, A
function DebugDrawCylinder(Min, Max, r, g, b, a)
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