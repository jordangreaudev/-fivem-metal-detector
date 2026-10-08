--[[
    Bridge multi-framework : selon Config.Framework, force ESX / Qbox / QBCore /
    standalone, ou detecte automatiquement ('auto') la resource demarree.

    Expose uniquement Bridge.GetJob(), utilise par client/client.lua pour
    la whitelist par job. En standalone (ou fallback), retourne toujours nil :
    personne n'est whitelist (aucun crash, comportement degrade attendu).
]]

Bridge = {}

local VALID_FRAMEWORKS = { auto = true, esx = true, qbcore = true, qbox = true, standalone = true }

local configured = Config.Framework or 'auto'
if not VALID_FRAMEWORKS[configured] then
    print(('[MetalDetector] Config.Framework invalide ("%s"), utilisation de "auto"'):format(tostring(configured)))
    configured = 'auto'
end

local forced = configured ~= 'auto' and configured or nil

local function resolveFramework()
    if (not forced or forced == 'esx') and GetResourceState('es_extended') == 'started' then
        return 'esx', exports['es_extended']:getSharedObject()
    end
    if (not forced or forced == 'qbox') and GetResourceState('qbx_core') == 'started' then
        return 'qbox', exports['qbx_core']:GetCoreObject()
    end
    if (not forced or forced == 'qbcore') and GetResourceState('qb-core') == 'started' then
        return 'qbcore', exports['qb-core']:GetCoreObject()
    end

    return 'standalone', nil
end

local framework, core = resolveFramework()

if forced and forced ~= framework then
    print(('[MetalDetector] Config.Framework = "%s" mais la resource correspondante n\'est pas demarree, fallback standalone'):format(forced))
end

print(('[MetalDetector] Framework : %s'):format(framework))

function Bridge.GetJob()
    if framework == 'esx' then
        local data = core.GetPlayerData()
        return data and data.job and data.job.name
    elseif framework == 'qbcore' or framework == 'qbox' then
        local data = core.Functions.GetPlayerData()
        return data and data.job and data.job.name
    end

    return nil
end
