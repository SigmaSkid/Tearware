client.objectGrabTarget = nil
client.objectGrabDist = 0
client.lastTool = nil

client.playerSuperStrength = function()
    if not config_GetLocalFeatureState(fSuperStrength) then
        return 
    end

    local pressed = client.utils_Input(InputPressed, "rmb")

    if client.utils_Input(InputPressed, "rmb") then
        if client.objectGrabTarget == nil then 
            client.objectGrabTarget, client.objectGrabDist = utils_GetObjectWeAreLookingAt(GetLocalPlayer())
            if not IsHandleValid(client.objectGrabTarget) or not IsBodyDynamic(client.objectGrabTarget) then 
                -- DebugPrint("Client SuperStrength, tried grabbing invalid object.")
                client.objectGrabTarget = nil
                return
            end

            client.lastTool = GetString("game.player.tool")
            SetString("game.player.tool", "tearware_grab")
        else
            client.objectGrabTarget = nil
            client.objectGrabDist = 0
            SetString("game.player.tool", client.lastTool)
            client.lastTool = nil
        end
        ServerCall("server.mrServerIWantThisObjectPlease", GetLocalPlayer(), localUUID, client.objectGrabTarget, client.objectGrabDist)
    end

    -- DebugWatch("GRAB?", client.objectGrabTarget ~= nil)
    if client.objectGrabTarget == nil then 
        if client.lastTool then
            SetString("game.player.tool", client.lastTool)
            client.lastTool = nil
        end
        return 
    end

    SetString("game.player.tool", "tearware_grab")
    DrawBodyOutline(client.objectGrabTarget, 1, 1, 1, 1)

    local scrollPos = client.utils_Input(InputValue, "mousewheel")

    if scrollPos ~= 0 then 
        if client.utils_Input(InputDown, "shift") then
            scrollPos = scrollPos * 5
        end
        client.objectGrabDist = client.objectGrabDist + scrollPos
        if client.objectGrabDist < 1 then 
            client.objectGrabDist = 1
        end
    end

    ServerCall("server.mrServerIWantThisObjectPlease", GetLocalPlayer(), localUUID, client.objectGrabTarget, client.objectGrabDist)
end

client.grabRelease = function()
    client.objectGrabTarget = nil
end

server.objectGrabTarget = {}
server.objectGrabDist = {}

server.mrServerIWantThisObjectPlease = function(playerID, UUID, object, dist)
    if not serverVerify(playerID, UUID) then 
        server.ImpolitelyReject(playerID, "super strength object grab")
        return 
    end

    server.objectGrabTarget[playerID] = object
    server.objectGrabDist[playerID] = dist

    -- DebugPrint("Player " .. playerID .. " grabbed object.")
end

server.playerSuperStrength = function(playerID)
    local e = syncedPlayerSetting[playerID]
    if not e then 
        return 
    end

    local enabled = server.getPlayerConfigValue(playerID, config_getKey(fSuperStrength))
    if not enabled then 
        return
    end

    if server.objectGrabTarget[playerID] == nil then 
        return 
    end

    ReleasePlayerGrab(playerID)

    if not IsHandleValid(server.objectGrabTarget[playerID]) then 
        server.objectGrabTarget[playerID] = nil
        ClientCall(playerID, "client.grabRelease")
        return
    end

    if not IsBodyDynamic(server.objectGrabTarget[playerID]) then 
        server.objectGrabTarget[playerID] = nil
        ClientCall(playerID, "client.grabRelease")
        return
    end

    if server.utils_Input(InputDown, "lmb", playerID) then
        -- LAUNCH!
        local dir = utils_GetForwardDirection(playerID)
        local velocity = GetBodyVelocity(server.objectGrabTarget[playerID])
        
        velocity = VecAdd(velocity, VecScale(dir, 50))  
        SetBodyVelocity(server.objectGrabTarget[playerID], velocity)
        server.objectGrabTarget[playerID] = nil
        ClientCall(playerID, "client.grabRelease")
        return
    end

    local direction, camera = utils_GetForwardDirection(playerID)
    local targetLocation = VecAdd(camera.pos, VecScale(direction, server.objectGrabDist[playerID]))

    local vel = VecSub(targetLocation, utils_GetBodyCenter(server.objectGrabTarget[playerID]))
    vel = VecScale(vel, VecLength(vel))
    SetBodyVelocity(server.objectGrabTarget[playerID], vel)

    -- angular velocity is cringe
    SetBodyAngularVelocity(server.objectGrabTarget[playerID], {0,0,0} )
end