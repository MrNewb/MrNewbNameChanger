local function changeNameFromItem(src, firstName, lastName, itemName, slot, metadata)
    firstName, lastName = ParsePlayerName(firstName, lastName)
    if not firstName or not lastName then return end
    if bridge.inventory.getItemCount(src, itemName) <= 0 then return end

    if not bridge.inventory.removeItem(src, itemName, 1, metadata, slot) then return end

    if not ChangePlayerName(src, firstName, lastName) then
        bridge.inventory.addItem(src, itemName, 1, metadata)
        bridge.notifications.notify(src, { description = locale('PedNameChange.Failed'), type = 'error' })
        return
    end

    bridge.notifications.notify(src, { description = locale('Notifications.NameChangeSuccess', firstName, lastName), type = 'success', })
end

bridge.framework.registerItemUse(Config.Items.FilledCertificate, function(src, item)
    local ped = GetPlayerPed(src)
    if ped == 0 or not DoesEntityExist(ped) then return end

    local metadata = item.metadata or item.info
    if type(metadata) ~= 'table' then return end

    local firstName, lastName = ParsePlayerName(metadata.firstname, metadata.lastname)
    if not firstName or not lastName then return end

    local confirmed = lib.callback.await('MrNewbNameChanger:Callback:ShowCertificate', src, 'marriage', firstName, lastName, true)
    if not confirmed then return end

    changeNameFromItem(src, firstName, lastName, Config.Items.FilledCertificate, item.slot, metadata)
end)

local function playerMeetsMarriageJob(src)
    if not Config.Marriage or not Config.Marriage.RequireJob then return true end

    local jobs = Config.Marriage.AllowedJobs or {}
    for jobIndex = 1, #jobs do
        if bridge.framework.hasJob(src, jobs[jobIndex]) then return true end
    end

    bridge.notifications.notify(src, { description = locale('JobRequired.YouDoNotHaveTheJob'), type = 'error' })
    return false
end

local function issueFilledCertificate(src, firstName, lastName)
    local blankItem = Config.Items.MarriageCertificate
    if bridge.inventory.getItemCount(src, blankItem) <= 0 then return false end

    if not bridge.inventory.canCarryItem(src, Config.Items.FilledCertificate, 1) then
        bridge.notifications.notify(src, { description = locale('Notifications.CannotCarryCertificate'), type = 'error' })
        return false
    end

    if not bridge.inventory.removeItem(src, blankItem, 1) then return false end

    if not bridge.inventory.addItem(src, Config.Items.FilledCertificate, 1, {
        firstname = firstName,
        lastname = lastName,
        description = locale('FilledCertificate.Description', firstName, lastName),
    }) then
        bridge.inventory.addItem(src, blankItem, 1)
        return false
    end

    bridge.notifications.notify(src, { description = locale('Notifications.CertificateCreated', firstName, lastName), type = 'success', })
    return true
end

bridge.framework.registerItemUse(Config.Items.MarriageCertificate, function(src)
    local ped = GetPlayerPed(src)
    if ped == 0 or not DoesEntityExist(ped) then return end
    if not playerMeetsMarriageJob(src) then return end

    local firstName, lastName = lib.callback.await('MrNewbNameChanger:Callback:NameFlow', src, 'marriage')
    firstName, lastName = ParsePlayerName(firstName, lastName)
    if not firstName or not lastName then return end

    issueFilledCertificate(src, firstName, lastName)
end)

bridge.framework.registerItemUse(Config.Items.NameChangeVoucher, function(src, item)
    local ped = GetPlayerPed(src)
    if ped == 0 or not DoesEntityExist(ped) then return end

    local firstName, lastName = lib.callback.await('MrNewbNameChanger:Callback:NameFlow', src, 'personal')
    firstName, lastName = ParsePlayerName(firstName, lastName)
    if not firstName or not lastName then return end

    changeNameFromItem(src, firstName, lastName, Config.Items.NameChangeVoucher, item.slot)
end)
