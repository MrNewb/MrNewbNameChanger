lib.locale()

local clientPoints = {}

local function formatCooldown(seconds)
    seconds = math.ceil(seconds)
    if seconds >= 3600 then
        local hours = math.floor(seconds / 3600)
        local minutes = math.ceil((seconds % 3600) / 60)
        return ('%s h %s m'):format(hours, minutes)
    end

    if seconds >= 60 then
        return ('%s m'):format(math.ceil(seconds / 60))
    end

    return ('%s s'):format(seconds)
end

local function openPedNameChange(locationId)
    local locations = Config.RecordsClerk and Config.RecordsClerk.Locations
    if not locations or not locations[locationId] then return end

    local remaining = lib.callback.await('MrNewbNameChanger:Callback:GetPedCooldown', false)
    if remaining and remaining > 0 then
        bridge.notifications.notify({
            description = locale('PedNameChange.OnCooldown', formatCooldown(remaining)),
            type = 'error',
            duration = 6000,
        })
        return
    end

    local firstName, lastName = ShowCertificate('namechange', {
        allowInput = true,
        menuType = 'ped',
    })
    if not firstName or not lastName then return end

    TriggerServerEvent('MrNewbNameChanger:Server:PedNameChange', locationId, firstName, lastName)
end

local function createRecordsClerkPoint(id, data)
    local point = {
        id = id,
        coords = data.Coords,
        model = data.Model or 's_m_m_judge_01',
        label = data.Label or locale('PedNameChange.TargetLabel'),
        icon = data.Icon or 'fa-solid fa-id-card',
        scenario = data.Scenario or 'WORLD_HUMAN_CLIPBOARD',
        spawnRadius = data.SpawnRadius or 50.0,
        interactDistance = data.InteractDistance or 2.5,
        interactionId = nil,
    }

    function point.register()
        if not point.coords then return end

        point.interactionId = ('mrnewb_namechange_%s'):format(point.id:gsub('%s+', '_'):lower())

        exports[bridge.name]:AddInteraction(point.interactionId, {
            model = point.model,
            coords = vector3(point.coords.x, point.coords.y, point.coords.z),
            heading = point.coords.w or 0.0,
            radius = point.spawnRadius,
            scenario = point.scenario,
            options = {
                {
                    name = ('NameChangePed_%s'):format(point.id),
                    label = point.label,
                    icon = point.icon,
                    distance = point.interactDistance,
                    onSelect = function()
                        openPedNameChange(point.id)
                    end,
                },
            },
        })
    end

    function point.destroy()
        if point.interactionId then
            exports[bridge.name]:RemoveInteraction(point.interactionId)
            point.interactionId = nil
        end
    end

    return point
end

function CreatePedNameChangeLocations()
    local clerkConfig = Config.RecordsClerk
    if not clerkConfig or not clerkConfig.Enabled then return end

    for id, entry in pairs(clerkConfig.Locations or {}) do
        if not clientPoints[id] then
            clientPoints[id] = createRecordsClerkPoint(id, entry)
            clientPoints[id]:register()
        end
    end
end

function RemovePedNameChangeLocations()
    for id, point in pairs(clientPoints) do
        point:destroy()
        clientPoints[id] = nil
    end
end

AddEventHandler('Newb_Bridge:client:playerLoad', function()
    Wait(1000)
    CreatePedNameChangeLocations()
end)

AddEventHandler('Newb_Bridge:client:playerUnload', function()
    RemovePedNameChangeLocations()
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    RemovePedNameChangeLocations()
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    CreateThread(function()
        Wait(500)
        CreatePedNameChangeLocations()
    end)
end)
