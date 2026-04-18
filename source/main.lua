#include "ui/ui_helpers.lua"
#include "utils/local.lua"
#include "utils/globals.lua"
#include "utils/config.lua"
#include "utils/utils.lua"
#include "utils/security.lua"
#include "utils/sync.lua"
#include "update.lua"
#include "tick.lua"
#include "draw.lua"

-- entrypoint
function client.init()
    config_GenerateConfig()
    utils_ghostMode()

    isLocalPlayerTheHost = IsPlayerHost(GetLocalPlayer())
    isSessionMultiplayer = GetMaxPlayers() > 1
    isSessionCampagin = HasKey("level.campaign")

    --[[
    DebugPrint("[TEARWARE INIT] "..
        "Host: " .. utils_boolStr(isLocalPlayerTheHost) .. 
        ", MP: " .. utils_boolStr(isSessionMultiplayer) .. 
        ", Campaign: " .. utils_boolStr(isSessionCampagin))
    ]]

    ServerCall("server.issueUUID", GetLocalPlayer())
end