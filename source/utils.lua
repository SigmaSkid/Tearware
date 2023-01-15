-- tearware on top

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

function IsDirectionalInputDown() 
    return InputDown("up") or InputDown("down") or InputDown("left") or InputDown("right")
end

-- local direction, camera = GetForwardDirection()
function GetForwardDirection() 
	local camera = GetCameraTransform()
	local parentpoint = TransformToParentPoint(camera, Vec(0, 0, 1))
    return VecNormalize(VecSub(camera.pos, parentpoint)), camera
end

function GetPosWeAreLookingAt()
    local direction, camera = GetForwardDirection() 
    local hit, dist = QueryRaycast(camera.pos, direction, 666)

    if hit then 
        return TransformToParentPoint(camera, Vec(0, 0, -dist))
    end

    return nil 
end

function GetObjectWeAreLookingAt()
    local direction, camera = GetForwardDirection() 
    local hit, dist, normal, shape = QueryRaycast(camera.pos, direction, 666)

    if hit then 
        return GetShapeBody(shape), dist
    end

    return nil 
end

function seedToRGB(y)
    local rgb = {} 
    
    rgb.R = math.sin(y + 0) * 0.5 + 0.5;
    rgb.G = math.sin(y + 2) * 0.5 + 0.5;
    rgb.B = math.sin(y + 4) * 0.5 + 0.5;

    return rgb 
end

function GetBodyCenter(body)
    local min, max = GetBodyBounds(body)
    return VecLerp(min, max, 0.5)
end

function MathRound(value)
    return math.floor(value+0.5)
end

function Clamp(a, x, y) 
    if a < x then a = x end 
    if a > y then a = y end 
    return a
end