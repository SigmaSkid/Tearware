-- client
clientLastAAsettings = { 
    enabled=false,
    yaw_mode=0,
    yaw_offset=0,
    yaw_speed=0,
    yaw_amp=0,
    pitch_mode=0,
    pitch_offset=0,
    pitch_speed=0,
    pitch_amp=0
}

client_playerAntiAim = function()

    local enabled = config_AdvGetBool(fAntiAim)

    if not enabled and clientLastAAsettings == nil then return end

    local currentAAsettings = { 
        enabled=enabled,
        yaw_mode=config_GetSubInt(fAntiAim, fAntiAimYawModes),
        yaw_offset=config_GetSubFloat(fAntiAim, fSubYawOffset),
        yaw_speed=config_GetSubFloat(fAntiAim, fSubYawSpeed),
        yaw_amp=config_GetSubFloat(fAntiAim, fSubYawAmp),
        pitch_mode=config_GetSubInt(fAntiAim, fAntiAimPitchModes),
        pitch_offset=config_GetSubFloat(fAntiAim, fSubPitchOffset),
        pitch_speed=config_GetSubFloat(fAntiAim, fSubPitchSpeed),
        pitch_amp=config_GetSubFloat(fAntiAim, fSubPitchAmp)
    }

    if utils_tableCompare(currentAAsettings, clientLastAAsettings) then 
        if not enabled then 
            clientLastAAsettings = nil
        end
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

    local time = GetTime()

    -- yaw spin
    -- 0 disabled
    if entry.yaw_mode == 1 then  -- 1 offset
        SetBoneRotation(animator, "Bip001", QuatEuler(-90, 90 + entry.yaw_offset, 0))
    elseif entry.yaw_mode == 2 then -- 2 spin

        local spinSpeed = 360 * entry.yaw_speed
        local spinAngle = (time * spinSpeed) % 360

        SetBoneRotation(animator, "Bip001", QuatEuler(-90, spinAngle + entry.yaw_offset, 0))
    elseif entry.yaw_mode == 3 then -- 3 oscillate

        local spinAngle = math.sin(time * math.abs(entry.yaw_speed) * 10) * entry.yaw_amp
        
        SetBoneRotation(animator, "Bip001", QuatEuler(-90, 90 + spinAngle + entry.yaw_offset, 0))
    elseif entry.yaw_mode == 4 then -- 4 jitter

        local speed = math.abs(entry.yaw_speed)
        local snap = math.sin(time * speed * 20) >= 0 and 1 or -1
        local spinAngle = snap * entry.yaw_amp

        SetBoneRotation(animator, "Bip001", QuatEuler(-90, 90 + spinAngle + entry.yaw_offset, 0))
    elseif entry.yaw_mode == 5 then -- 5 jitter spin
        local speed = math.abs(entry.yaw_speed)
        local snap = math.sin(time * speed * 20) >= 0 and 1 or -1
        local spinAngle = (snap * entry.yaw_amp) + ((time * 45 * entry.yaw_speed) % 360)

        SetBoneRotation(animator, "Bip001", QuatEuler(-90, spinAngle + entry.yaw_offset, 0))
    end

    -- pitch
    -- 0 disabled
    if entry.pitch_mode == 1 then  -- 1 static

        local pitch_scale = utils_Clamp(entry.pitch_offset/90.0, -1.0, 1.0)

        SetBoneRotation(animator, "stomach", QuatEuler(0, 0, 25 * pitch_scale))
        SetBoneRotation(animator, "chest", QuatEuler(0, 0, 25 * pitch_scale))
        SetBoneRotation(animator, "neck", QuatEuler(0, 0, 20 * pitch_scale))
        SetBoneRotation(animator, "head", QuatEuler(0, 0, 20 * pitch_scale))
    elseif entry.pitch_mode == 2 then  -- 2 oscillate

        local speed = math.abs(entry.pitch_speed)
        local angle = math.sin(time * speed * 10) * entry.pitch_amp
        local pitch_scale = utils_Clamp((entry.pitch_offset + angle) / 90.0, -1.0, 1.0)

        SetBoneRotation(animator, "stomach", QuatEuler(0, 0, 25 * pitch_scale))
        SetBoneRotation(animator, "chest",   QuatEuler(0, 0, 25 * pitch_scale))
        SetBoneRotation(animator, "neck",    QuatEuler(0, 0, 20 * pitch_scale))
        SetBoneRotation(animator, "head",    QuatEuler(0, 0, 20 * pitch_scale))

    elseif entry.pitch_mode == 3 then  -- 3 jitter

        local speed = math.abs(entry.pitch_speed)
        local snap = math.sin(time * speed * 20) >= 0 and 1 or -1
        local angle = snap * entry.pitch_amp
        local pitch_scale = utils_Clamp((entry.pitch_offset + angle) / 90.0, -1.0, 1.0)

        SetBoneRotation(animator, "stomach", QuatEuler(0, 0, 25 * pitch_scale))
        SetBoneRotation(animator, "chest",   QuatEuler(0, 0, 25 * pitch_scale))
        SetBoneRotation(animator, "neck",    QuatEuler(0, 0, 20 * pitch_scale))
        SetBoneRotation(animator, "head",    QuatEuler(0, 0, 20 * pitch_scale))
    end
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