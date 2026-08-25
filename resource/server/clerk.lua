if not Config.RecordsClerk or not Config.RecordsClerk.Enabled then return end

local allowedAccounts = {
    cash = true,
    bank = true,
}

local clerkCooldowns = {}

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
    if not identifier then return 0 end

    local lastChange = clerkCooldowns[identifier]
    if not lastChange then return 0 end

    local remaining = (Config.RecordsClerk.Cooldown or 86400) - (os.time() - lastChange)
    if remaining <= 0 then
        clerkCooldowns[identifier] = nil
        return 0
    end
    return remaining
end

local function getClerkLocation(locationId)
    if type(locationId) ~= 'string' or locationId == '' or #locationId > 64 then return end
    local location = Config.RecordsClerk.Locations and Config.RecordsClerk.Locations[locationId]
    if not location or not location.Coords then return end
    return location
end

local function isNearClerkLocation(ped, location)
    local coords = location.Coords
    local maxDistance = (location.InteractDistance or 2.5) + 1.0
    return #(GetEntityCoords(ped) - vector3(coords.x, coords.y, coords.z)) <= maxDistance
end

local function chargeClerkNameChange(src, identifier)
    local clerk = Config.RecordsClerk
    local previousChange = clerkCooldowns[identifier]
    clerkCooldowns[identifier] = os.time()

    local price = clerk.Price or 10000
    if type(price) ~= 'number' or price < 0 then price = 10000 end

    local account = clerk.Account or 'cash'
    if not allowedAccounts[account] then account = 'cash' end

    local balance = bridge.framework.getMoney(src, account)
    if balance < 0 then
        clerkCooldowns[identifier] = previousChange
        return false, bridge.notifications.notify(src, { description = locale('PedNameChange.NotEnoughMoney', price), type = 'error', duration = 6000 })
    end
    if balance < price then
        clerkCooldowns[identifier] = previousChange
        return false, bridge.notifications.notify(src, { description = locale('PedNameChange.NotEnoughMoney', price), type = 'error', duration = 6000 })
    end

    if not bridge.framework.removeMoney(src, account, price) then
        clerkCooldowns[identifier] = previousChange
        return false
    end

    return true, account, price, previousChange
end

lib.callback.register('MrNewbNameChanger:Callback:PedNameChange', function(src, locationId, firstName, lastName)
    local ped = GetPlayerPed(src)
    if ped == 0 or not DoesEntityExist(ped) then return false end

    local location = getClerkLocation(locationId)
    if not location then return false end

    firstName, lastName = ParsePlayerName(firstName, lastName)
    if not firstName or not lastName then
        bridge.notifications.notify(src, { description = locale('NameFilter.InvalidName'), type = 'error' })
        return false
    end

    if not isNearClerkLocation(ped, location) then
        bridge.notifications.notify(src, { description = locale('PedNameChange.TooFar'), type = 'error' })
        return false
    end

    local identifier = bridge.framework.getIdentifier(src)
    if not identifier then return false end

    local remaining = getPedCooldownRemaining(identifier)
    if remaining > 0 then
        bridge.notifications.notify(src, { description = locale('PedNameChange.OnCooldown', formatCooldown(remaining)), type = 'error', duration = 6000 })
        return remaining
    end

    local charged, account, price, previousChange = chargeClerkNameChange(src, identifier)
    if not charged then return false end

    if not ChangePlayerName(src, firstName, lastName) then
        clerkCooldowns[identifier] = previousChange
        bridge.framework.addMoney(src, account, price)
        bridge.notifications.notify(src, { description = locale('PedNameChange.Failed'), type = 'error', duration = 6000 })
        return false
    end

    bridge.notifications.notify(src, { description = locale('Notifications.NameChangeSuccess', firstName, lastName), type = 'success', duration = 6000 })
    return getPedCooldownRemaining(identifier)
end)
