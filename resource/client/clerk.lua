if not Config.RecordsClerk or not Config.RecordsClerk.Enabled then return end

local activeClerkInteractions = {}
local nameChangeCooldownEndsAt = 0
local nameChangeInProgress = false

local function getNameChangeCooldownRemaining()
    if nameChangeCooldownEndsAt == 0 then return 0 end

    local remainingSeconds = math.ceil((nameChangeCooldownEndsAt - GetGameTimer()) / 1000)
    if remainingSeconds <= 0 then
        nameChangeCooldownEndsAt = 0
        return 0
    end
    return remainingSeconds
end

local function setNameChangeCooldown(remainingSeconds)
    if type(remainingSeconds) ~= 'number' or remainingSeconds <= 0 then
        nameChangeCooldownEndsAt = 0
        return
    end
    nameChangeCooldownEndsAt = GetGameTimer() + math.ceil(remainingSeconds) * 1000
end

local function startClerkNameChange(locationId)
    if nameChangeInProgress then return end
    if getNameChangeCooldownRemaining() > 0 then return end
    if not Config.RecordsClerk.Locations[locationId] then return end

    nameChangeInProgress = true

    local firstName, lastName = ShowCertificate('namechange', {
        allowInput = true,
        menuType = 'ped',
    })

    if firstName and lastName then
        local cooldownRemaining = lib.callback.await('MrNewbNameChanger:Callback:PedNameChange', false, locationId, firstName, lastName)
        if type(cooldownRemaining) == 'number' and cooldownRemaining > 0 then
            setNameChangeCooldown(cooldownRemaining)
        end
    end

    nameChangeInProgress = false
end

function CreateRecordsClerkLocations()
    for locationId, location in pairs(Config.RecordsClerk.Locations or {}) do
        if not activeClerkInteractions[locationId] and type(location) == 'table' and location.Coords then
            local interactionId = ('MrNewbNameChanger:clerk:%s'):format(locationId)
            exports[bridge.name]:AddInteraction(interactionId, {
                model = location.Model or 's_m_m_judge_01',
                coords = vector3(location.Coords.x, location.Coords.y, location.Coords.z),
                heading = location.Coords.w or 0.0,
                radius = location.SpawnRadius or 50.0,
                scenario = location.Scenario or 'WORLD_HUMAN_CLIPBOARD',
                options = {
                    {
                        name = interactionId,
                        label = location.Label or locale('PedNameChange.TargetLabel'),
                        icon = location.Icon or 'fa-solid fa-id-card',
                        distance = location.InteractDistance or 2.5,
                        canInteract = function()
                            return not nameChangeInProgress and getNameChangeCooldownRemaining() <= 0
                        end,
                        onSelect = function()
                            startClerkNameChange(locationId)
                        end,
                    },
                },
            })
            activeClerkInteractions[locationId] = interactionId
        end
    end
end

function RemoveRecordsClerkLocations()
    for locationId, interactionId in pairs(activeClerkInteractions) do
        exports[bridge.name]:RemoveInteraction(interactionId)
        activeClerkInteractions[locationId] = nil
    end
end

AddEventHandler('Newb_Bridge:client:playerLoad', CreateRecordsClerkLocations)
AddEventHandler('Newb_Bridge:client:playerUnload', function()
    nameChangeInProgress = false
    nameChangeCooldownEndsAt = 0
    RemoveRecordsClerkLocations()
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    RemoveRecordsClerkLocations()
end)

CreateThread(function()
    Wait(500)
    if next(activeClerkInteractions) then return end
    CreateRecordsClerkLocations()
end)
