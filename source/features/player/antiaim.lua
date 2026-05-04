-- shared
shared_applyAntiAim = function(playerID, entry)
    if entry == nil then return end

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
    elseif entry.yaw_mode == 6 then -- hitbox debug.
        local spinSpeed = 360 * entry.yaw_speed
        local spinAngle = (time * spinSpeed) % 360

        SetBoneRotation(animator, "Bip001", QuatEuler(90, -90, 0))
        SetBoneRotation(animator, "stomach", QuatEuler(0, -180, 0))
        SetBoneRotation(animator, "pelvis", QuatEuler(90, 90, 0))
        SetBoneRotation(animator, "chest", QuatEuler(0, -180, 0))
        
        SetBoneRotation(animator, "neck", QuatEuler(0, -180, 0))
        SetBoneRotation(animator, "head", QuatEuler(0, -180, 0))

        SetBoneRotation(animator, "shoulder_l", QuatEuler(0, -180, 0))
        SetBoneRotation(animator, "arm_upper_l", QuatEuler(0, -180, 0))
        SetBoneRotation(animator, "arm_lower_l", QuatEuler(0, -180, 0))
        SetBoneRotation(animator, "hand_l", QuatEuler(0, -180, 0))

        SetBoneRotation(animator, "shoulder_r", QuatEuler(0, -180, 0))
        SetBoneRotation(animator, "arm_upper_r", QuatEuler(0, -180, 0))
        SetBoneRotation(animator, "arm_lower_r", QuatEuler(0, -180, 0))
        SetBoneRotation(animator, "hand_r", QuatEuler(0, -180, 0))

        SetBoneRotation(animator, "leg_upper_l", QuatEuler(0, 0, 0))
        SetBoneRotation(animator, "leg_lower_l", QuatEuler(0, -180, 0))
        SetBoneRotation(animator, "foot_l", QuatEuler(0, -180, 0))
        SetBoneRotation(animator, "toes_l", QuatEuler(0, -180, 0))

        SetBoneRotation(animator, "leg_upper_r", QuatEuler(0, 0, 0))
        SetBoneRotation(animator, "leg_lower_r", QuatEuler(0, -180, 0))
        SetBoneRotation(animator, "foot_r", QuatEuler(0, -180, 0))
        SetBoneRotation(animator, "toes_r", QuatEuler(0, -180, 0))
        return -- don't let pitch override debug mode.
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

-- server
server_playerAntiAim = function(playerID, dt)
    local e = syncedPlayerSetting[playerID]
    if not e then return nil end


    local enabled = server.getPlayerConfigValue(playerID, config_getKey(fAntiAim))
    if not enabled then return nil end

    local entry = 
    {
        yaw_mode    = server.getPlayerConfigValue(playerID, config_getSubKey(fAntiAim, fAntiAimYawModes)),
        yaw_offset   = server.getPlayerConfigValue(playerID, config_getSubKey(fAntiAim, fSubYawOffset)),
        yaw_speed    = server.getPlayerConfigValue(playerID, config_getSubKey(fAntiAim, fSubYawSpeed)),
        yaw_amp      = server.getPlayerConfigValue(playerID, config_getSubKey(fAntiAim, fSubYawAmp)),

        pitch_mode   = server.getPlayerConfigValue(playerID, config_getSubKey(fAntiAim, fAntiAimPitchModes)),
        pitch_offset = server.getPlayerConfigValue(playerID, config_getSubKey(fAntiAim, fSubPitchOffset)),
        pitch_speed  = server.getPlayerConfigValue(playerID, config_getSubKey(fAntiAim, fSubPitchSpeed)),
        pitch_amp    = server.getPlayerConfigValue(playerID, config_getSubKey(fAntiAim, fSubPitchAmp))
    }

    shared_applyAntiAim(playerID, entry)
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