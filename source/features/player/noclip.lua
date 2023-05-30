function NoClip(dts)
    if not AdvGetBool(fNoclip) then
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

    local speed = GetSubFloat(fNoclip, fSubSpeed)/10
    if TWInputDown("shift") then 
        speed = GetSubFloat(fNoclip, fSubBoost)/10
    end

    -- scale by update rate
    speed = speed * dts

    if IsDirectionalInputDown() then

        local x, y, z = GetQuatEuler(trans.rot) 
        local dir = TransformYawByInput(y)

        trans.rot = QuatEuler(x, dir, z)

        local parentpoint = TransformToParentPoint(trans, Vec(0, 0, -1))

        trans.rot = QuatEuler(x, y, z)
        
        local direction = VecScale(VecNormalize(VecSub(parentpoint, trans.pos)), speed)

        trans.pos[1] = trans.pos[1] + direction[1]
        trans.pos[3] = trans.pos[3] + direction[3]
    end 
    
    if TWInputDown("jump") then
        trans.pos[2] = trans.pos[2] + speed
    end 

    if TWInputDown("crouch") then
        trans.pos[2] = trans.pos[2] - speed
    end 

    SetPlayerTransform(trans, true)
end