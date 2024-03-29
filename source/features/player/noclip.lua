player_NoClip = function(dts)
    if not config_AdvGetBool(fNoclip) then
        noclipbackuppos = {}
        return 
    end

    local trans = GetPlayerTransform(true)

    -- teleport/edge of map/respawn detection
    local delta = VecLength( VecSub(noclipbackuppos, trans.pos) )

    if delta > 1 or #noclipbackuppos == 0 then 
        noclipbackuppos = trans.pos
    end

    trans.pos = noclipbackuppos

    local speed = config_GetSubFloat(fNoclip, fSubSpeed)/10
    if utils_TWInputDown("shift") then 
        speed = config_GetSubFloat(fNoclip, fSubBoost)/10
    end

    -- scale by update rate
    speed = speed * dts

    if utils_IsDirectionalInputDown() then

        local x, y, z = GetQuatEuler(trans.rot) 
        local dir = utils_TransformYawByInput(y)

        trans.rot = QuatEuler(x, dir, z)

        local parentpoint = TransformToParentPoint(trans, Vec(0, 0, -1))

        trans.rot = QuatEuler(x, y, z)
        
        local direction = VecScale(VecNormalize(VecSub(parentpoint, trans.pos)), speed)

        trans.pos[1] = trans.pos[1] + direction[1]
        trans.pos[3] = trans.pos[3] + direction[3]
    end 
    
    if utils_TWInputDown("jump") then
        trans.pos[2] = trans.pos[2] + speed
    end 

    if utils_TWInputDown("crouch") then
        trans.pos[2] = trans.pos[2] - speed
    end 

    SetPlayerTransform(trans, true)
end