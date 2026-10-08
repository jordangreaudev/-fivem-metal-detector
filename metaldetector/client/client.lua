local detectorHashes = {}
local whitelistedJobs = {}
local detectedItems = {}

local insideDetectorEntity = nil
local lastAlarmAt = 0

local function buildCaches()
    for _, modelName in ipairs(Config.DetectorProps or {}) do
        detectorHashes[#detectorHashes + 1] = GetHashKey(modelName)
    end

    for _, jobName in ipairs(Config.WhitelistedJobs or {}) do
        whitelistedJobs[jobName] = true
    end

    for _, itemName in ipairs(Config.DetectedItems or {}) do
        detectedItems[#detectedItems + 1] = itemName
    end
end

local function isPlayerWhitelisted()
    local jobName = Bridge.GetJob()
    return jobName and whitelistedJobs[jobName] or false
end

local function getItemCount(itemName)
    local result = exports.ox_inventory:Search('count', itemName)

    if type(result) == 'number' then
        return result
    end

    if type(result) ~= 'table' then
        return 0
    end

    local total = 0

    for key, value in pairs(result) do
        if type(value) == 'number' then
            total = total + value
        elseif type(value) == 'table' then
            if type(value.count) == 'number' then
                total = total + value.count
            elseif type(key) == 'number' then
                total = total + 1
            end
        end
    end

    return total
end

local function hasDetectedItem()
    for i = 1, #detectedItems do
        local itemName = detectedItems[i]
        local count = getItemCount(itemName)
        if count > 0 then
            return true, itemName, count
        end
    end

    return false, nil, 0
end

local function playAlarm()
    local soundName = Config.Sound and Config.Sound.name or '10_SEC_WARNING'
    local soundSet = Config.Sound and Config.Sound.set or 'HUD_MINI_GAME_SOUNDSET'
    local repeats = math.max(1, math.floor(Config.SoundRepeatCount or 1))
    local delay = math.max(0, math.floor(Config.SoundRepeatDelay or 0))

    CreateThread(function()
        for i = 1, repeats do
            PlaySoundFrontend(-1, soundName, soundSet, true)
            if i < repeats and delay > 0 then
                Wait(delay)
            end
        end
    end)
end

local function distancePointToSegment(point, segStart, segEnd)
    local abx = segEnd.x - segStart.x
    local aby = segEnd.y - segStart.y
    local abz = segEnd.z - segStart.z
    local apx = point.x - segStart.x
    local apy = point.y - segStart.y
    local apz = point.z - segStart.z

    local abLenSq = (abx * abx) + (aby * aby) + (abz * abz)
    if abLenSq <= 0.0001 then
        return #(point - segStart)
    end

    local t = ((apx * abx) + (apy * aby) + (apz * abz)) / abLenSq
    if t < 0.0 then
        t = 0.0
    elseif t > 1.0 then
        t = 1.0
    end

    local closestPoint = vector3(
        segStart.x + (abx * t),
        segStart.y + (aby * t),
        segStart.z + (abz * t)
    )

    return #(point - closestPoint)
end

local function getDetectorNear(playerCoords, lastPlayerCoords)
    local triggerDistance = Config.TriggerDistance or 1.6

    local center = playerCoords
    local searchRadius = triggerDistance + 1.5
    if lastPlayerCoords then
        center = (playerCoords + lastPlayerCoords) * 0.5
        searchRadius = searchRadius + (#(playerCoords - lastPlayerCoords) * 0.5)
    end

    local closestEntity = nil
    local closestDistance = nil

    for i = 1, #detectorHashes do
        local entity = GetClosestObjectOfType(center.x, center.y, center.z, searchRadius, detectorHashes[i], false, false, false)
        if entity ~= 0 and DoesEntityExist(entity) then
            local entityCoords = GetEntityCoords(entity)
            local dist = #(playerCoords - entityCoords)
            if lastPlayerCoords then
                local segDist = distancePointToSegment(entityCoords, lastPlayerCoords, playerCoords)
                if segDist < dist then dist = segDist end
            end
            if dist <= triggerDistance and (not closestDistance or dist < closestDistance) then
                closestEntity = entity
                closestDistance = dist
            end
        end
    end

    return closestEntity
end

local function tryTriggerAlarm(detectorEntity)
    local now = GetGameTimer()
    if (now - lastAlarmAt) < (Config.AlarmCooldown or 3500) then
        return
    end

    if isPlayerWhitelisted() then
        return
    end

    local found = hasDetectedItem()
    if not found then
        return
    end

    if not detectorEntity or not DoesEntityExist(detectorEntity) then
        return
    end

    lastAlarmAt = now
    local c = GetEntityCoords(detectorEntity)
    TriggerServerEvent('lfMetalDetector:alarmNearby', c.x, c.y, c.z)
end

RegisterNetEvent('lfMetalDetector:clientAlarm', function()
    playAlarm()
end)

local SCAN_INTERVAL_IDLE_MS = 1200

CreateThread(function()
    buildCaches()
    if #detectorHashes == 0 then
        return
    end

    local scanNear = Config.ScanInterval or 250
    local scanIdle = math.max(scanNear, SCAN_INTERVAL_IDLE_MS)
    local lastPlayerCoords = nil

    while true do
        local ped = PlayerPedId()
        local waitMs = scanIdle

        if DoesEntityExist(ped) then
            local playerCoords = GetEntityCoords(ped)
            local closestDetector = getDetectorNear(playerCoords, lastPlayerCoords)

            if closestDetector then
                waitMs = scanNear
                if insideDetectorEntity ~= closestDetector then
                    insideDetectorEntity = closestDetector
                    tryTriggerAlarm(closestDetector)
                end
            else
                insideDetectorEntity = nil
            end

            lastPlayerCoords = playerCoords
        end

        Wait(waitMs)
    end
end)
