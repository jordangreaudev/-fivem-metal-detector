local lastAlarmBySource = {}

RegisterNetEvent('lfMetalDetector:alarmNearby', function(x, y, z)
    local src = source
    if type(x) ~= 'number' or type(y) ~= 'number' or type(z) ~= 'number' then
        return
    end

    local ped = GetPlayerPed(src)
    if not ped or ped == 0 then
        return
    end

    local pcoords = GetEntityCoords(ped)
    local origin = vector3(x, y, z)
    local maxAuth = (Config.TriggerDistance or 1.6) + 5.0
    if #(pcoords - origin) > maxAuth then
        return
    end

    local now = GetGameTimer()
    local cooldown = Config.AlarmCooldown or 3500
    local last = lastAlarmBySource[src]
    if last and (now - last) < cooldown then
        return
    end
    lastAlarmBySource[src] = now

    local range = Config.SoundHearDistance or 28.0

    for _, sid in ipairs(GetPlayers()) do
        local tid = tonumber(sid)
        if tid then
            local tped = GetPlayerPed(tid)
            if tped and tped ~= 0 then
                local tc = GetEntityCoords(tped)
                if #(tc - origin) <= range then
                    TriggerClientEvent('lfMetalDetector:clientAlarm', tid)
                end
            end
        end
    end
end)

AddEventHandler('playerDropped', function()
    lastAlarmBySource[source] = nil
end)
