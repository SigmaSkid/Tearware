#include "ui/ui_helpers.lua"
#include "utils/local.lua"
#include "utils/globals.lua"
#include "utils/config.lua"
#include "utils/utils.lua"
#include "utils/security.lua"
#include "update.lua"
#include "tick.lua"
#include "draw.lua"

-- entrypoint
function client.init()
    config_GenerateConfig()
    utils_ghostMode()

    isLocalPlayerTheHost = IsPlayerHost(GetLocalPlayer())

    ServerCall("server.issueUUID", GetLocalPlayer())
end