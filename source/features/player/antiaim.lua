-- client
clientLastAAsettings = { enabled=false }

antiAimSettingCompare = function(A, B)
    if A.enabled ~= B.enabled then return false end

    return true
end

client_playerAntiAim = function()

    local enabled = config_AdvGetBool(fAntiAim)

    if not enabled and clientLastAAsettings == nil then return end

    local currentAAsettings = { enabled=enabled }

    if antiAimSettingCompare(currentAAsettings, clientLastAAsettings) then 
        return
    end

    ServerCall("server.toggleAntiAim", GetLocalPlayer(), localUUID, currentAAsettings)
    clientLastAAsettings = currentAAsettings
end

-- server. 
playersAntiAiming = {}

server.toggleAntiAim = function(playerID, UUID, AAsettings)

    if not serverVerify(playerID, UUID) then return end

    DebugPrint("server.toggleAntiAim " .. playerID .. "-" .. GetPlayerName(playerID) .. " enabled: " .. utils_boolStr(AAsettings.enabled))

    if AAsettings.enabled then 
        playersAntiAiming[playerID] = AAsettings
    else 
        playersAntiAiming[playerID] = nil
    end
end

server_playerAntiAim = function(playerID, dt)

    local entry = playersAntiAiming[playerID]
    if entry == nil then return end
    if not entry.enabled then 
        playersAntiAiming[playerID] = nil
        return
    end

    local animator = GetPlayerAnimator(playerID)
    if animator == 0 then return end

    local spinSpeed = 360 -- degree/second
    local spinAngle = (GetTime() * spinSpeed) % 360

    -- yaw spin
    SetBoneRotation(animator, "Bip001", QuatEuler(-90, spinAngle, 0))

    -- pitch down 
    SetBoneRotation(animator, "stomach", QuatEuler(0, 0, 25))
    SetBoneRotation(animator, "chest", QuatEuler(0, 0, 25))
    SetBoneRotation(animator, "neck", QuatEuler(0, 0, 20))
    SetBoneRotation(animator, "head", QuatEuler(0, 0, 20))
end

--[[ 
    Bip001      (QuatEuler(-90, -90, 0) for default - rotates entire model relative to model origin. BEST OPTION FOR ANTIAIMING YAW.
    pelvis      (QuatEuler(-90, -90, 0) for default - rotates entire player model relative to.. idk?. spinning x breaks legs inverse kinematics during crouch)
    stomach     (QuatEuler(0, 0, 0)     for default - makes upper body spin relatively to pelvis  (z for leaning forwards/backwards)
    chest       (QuatEuler(0, 0, 0)     for default - makes upper body spin relatively to stomach  (z for leaning fowards/backwards)
    neck
    head
    shoulder_l
    arm_upper_l 
    arm_lower_l
    hand_l
    leg_upper_l
    leg_lower_l
    foot_l
    toes_l
--]]