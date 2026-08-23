lib.locale()

local pedCooldowns = {}

local allowedFunds = {
    cash = true,
    bank = true,
}

---@param src number
---@param firstName string
---@param lastName string
---@return boolean
function ChangePlayerName(src, firstName, lastName)
    if type(src) ~= 'number' then return false end

    local ped = GetPlayerPed(src)
    if ped == 0 or not DoesEntityExist(ped) then return false end

    firstName, lastName = ParsePlayerName(firstName, lastName)
    if not firstName or not lastName then return false end

    if not OpenUpdatePlayerName(src, firstName, lastName) then return false end

    TriggerEvent('MrNewbNameChanger:Server:NameChanged', src, bridge.framework.getIdentifier(src), firstName, lastName)
    return true
end

exports('ChangePlayerName', ChangePlayerName)

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

local function getPedCooldownRemaining(identifier)
    local clerk = Config.RecordsClerk
    if not clerk or not clerk.Enabled or not identifier then return 0 end

    local lastChange = pedCooldowns[identifier]
    if not lastChange then return 0 end

    local remaining = (clerk.Cooldown or 86400) - (os.time() - lastChange)
    return remaining > 0 and remaining or 0
end

local function changeName(src, firstName, lastName, itemName, slot, metadata)
    firstName, lastName = ParsePlayerName(firstName, lastName)
    if not firstName or not lastName then return end
    if bridge.inventory.getItemCount(src, itemName) <= 0 then return end
    if not bridge.inventory.removeItem(src, itemName, 1, nil, slot) then return end

    if not ChangePlayerName(src, firstName, lastName) then
        bridge.inventory.addItem(src, itemName, 1, metadata)
        return
    end

    bridge.notifications.notify(src, {
        description = locale('Notifications.NameChangeSuccess', firstName, lastName),
        type = 'success',
    })
end

local function generateFilledCertificate(src, firstName, lastName)
    firstName, lastName = ParsePlayerName(firstName, lastName)
    if not firstName or not lastName then return end

    local blankItem = Config.Items.MarriageCertificate
    if bridge.inventory.getItemCount(src, blankItem) <= 0 then return end

    if not bridge.inventory.canCarryItem(src, Config.Items.FilledCertificate, 1) then
        bridge.notifications.notify(src, {
            description = locale('Notifications.CannotCarryCertificate'),
            type = 'error',
        })
        return
    end

    if not bridge.inventory.removeItem(src, blankItem, 1) then return end

    if not bridge.inventory.addItem(src, Config.Items.FilledCertificate, 1, {
        firstname = firstName,
        lastname = lastName,
        certificateType = 'marriage',
        description = locale('FilledCertificate.Description', firstName, lastName),
    }) then
        bridge.inventory.addItem(src, blankItem, 1)
        return
    end

    bridge.notifications.notify(src, {
        description = locale('Notifications.CertificateCreated', firstName, lastName),
        type = 'success',
    })
end

bridge.framework.registerItemUse(Config.Items.FilledCertificate, function(src, item)
    local ped = GetPlayerPed(src)
    if ped == 0 or not DoesEntityExist(ped) then return end

    local metadata = item.metaData or item.metadata
    if type(metadata) ~= 'table' then return end

    local firstName, lastName = ParsePlayerName(metadata.firstname, metadata.lastname)
    if not firstName or not lastName then return end

    local confirmed = lib.callback.await('MrNewbNameChanger:Callback:ShowCertificate', src, 'marriage', firstName, lastName, true)
    if not confirmed then return end

    changeName(src, firstName, lastName, Config.Items.FilledCertificate, item.slot, metadata)
end)

bridge.framework.registerItemUse(Config.Items.MarriageCertificate, function(src, item)
    local ped = GetPlayerPed(src)
    if ped == 0 or not DoesEntityExist(ped) then return end

    if Config.Marriage and Config.Marriage.RequireJob then
        local allowed = false
        local jobs = Config.Marriage.AllowedJobs or {}
        for i = 1, #jobs do
            if bridge.framework.hasJob(src, jobs[i]) then
                allowed = true
                break
            end
        end
        if not allowed then
            bridge.notifications.notify(src, { description = locale('JobRequired.YouDoNotHaveTheJob'), type = 'error' })
            return
        end
    end

    local firstName, lastName = lib.callback.await('MrNewbNameChanger:Callback:NameFlow', src, 'marriage')
    firstName, lastName = ParsePlayerName(firstName, lastName)
    if not firstName or not lastName then return end

    generateFilledCertificate(src, firstName, lastName)
end)

bridge.framework.registerItemUse(Config.Items.NameChangeVoucher, function(src, item)
    local ped = GetPlayerPed(src)
    if ped == 0 or not DoesEntityExist(ped) then return end

    local firstName, lastName = lib.callback.await('MrNewbNameChanger:Callback:NameFlow', src, 'personal')
    firstName, lastName = ParsePlayerName(firstName, lastName)
    if not firstName or not lastName then return end

    changeName(src, firstName, lastName, Config.Items.NameChangeVoucher, item.slot)
end)

lib.callback.register('MrNewbNameChanger:Callback:GetPedCooldown', function(src)
    local ped = GetPlayerPed(src)
    if ped == 0 or not DoesEntityExist(ped) then return 0 end

    return getPedCooldownRemaining(bridge.framework.getIdentifier(src))
end)

RegisterNetEvent('MrNewbNameChanger:Server:PedNameChange', function(locationId, firstName, lastName)
    local src = source
    local ped = GetPlayerPed(src)
    if ped == 0 or not DoesEntityExist(ped) then return end

    local clerk = Config.RecordsClerk
    if not clerk or not clerk.Enabled then return end
    if type(locationId) ~= 'string' or locationId == '' or #locationId > 64 then return end

    local location = clerk.Locations and clerk.Locations[locationId]
    if not location or not location.Coords then return end

    firstName, lastName = ParsePlayerName(firstName, lastName)
    if not firstName or not lastName then
        bridge.notifications.notify(src, { description = locale('NameFilter.InvalidName'), type = 'error' })
        return
    end

    local coords = location.Coords
    local maxDistance = (location.InteractDistance or 2.5) + 1.0
    if #(GetEntityCoords(ped) - vector3(coords.x, coords.y, coords.z)) > maxDistance then
        bridge.notifications.notify(src, { description = locale('PedNameChange.TooFar'), type = 'error' })
        return
    end

    local identifier = bridge.framework.getIdentifier(src)
    if not identifier then return end

    local remaining = getPedCooldownRemaining(identifier)
    if remaining > 0 then
        bridge.notifications.notify(src, {
            description = locale('PedNameChange.OnCooldown', formatCooldown(remaining)),
            type = 'error',
            duration = 6000,
        })
        return
    end

    local price = clerk.Price or 10000
    if type(price) ~= 'number' or price < 0 then price = 10000 end

    local account = clerk.Account or 'cash'
    if not allowedFunds[account] then account = 'cash' end

    if bridge.framework.getMoney(src, account) < price then
        bridge.notifications.notify(src, {
            description = locale('PedNameChange.NotEnoughMoney', price),
            type = 'error',
            duration = 6000,
        })
        return
    end

    if not bridge.framework.removeMoney(src, account, price) then return end

    if not ChangePlayerName(src, firstName, lastName) then
        bridge.framework.addMoney(src, account, price)
        bridge.notifications.notify(src, { description = locale('PedNameChange.Failed'), type = 'error', duration = 6000 })
        return
    end

    pedCooldowns[identifier] = os.time()
    bridge.notifications.notify(src, {
        description = locale('Notifications.NameChangeSuccess', firstName, lastName),
        type = 'success',
        duration = 6000,
    })
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    exports[bridge.name]:VersionCheck('MrNewb/patchnotes', resourceName)
end)
