lib.locale()

local certificateResult

local monthNames = {
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
}

local menuPrefixes = {
    marriage = 'MarriageMenu',
    personal = 'NameChangeMenu',
    ped = 'PedNameChangeMenu',
}

local function formatIssuedDate()
    local year, month, day = GetLocalTime()
    return ('%s %d, %d'):format(monthNames[month] or 'Unknown', day, year)
end

local function formatCertificateDateStamp()
    local year, month, day = GetLocalTime()
    return ('%04d%02d%02d'):format(year, month, day)
end

local function buildInputLabels(menuType)
    local prefix = menuPrefixes[menuType] or menuPrefixes.personal
    return {
        firstName = locale(prefix .. '.FirstName'),
        lastName = locale(prefix .. '.LastName'),
        firstNameHint = locale(prefix .. '.DescriptionFirstName'),
        lastNameHint = locale(prefix .. '.DescriptionLastName'),
    }
end

local function buildLabels(documentType, allowInput)
    local prefix = documentType == 'marriage' and 'Certificate.Marriage' or 'Certificate.NameChange'
    return {
        issuer = locale('Certificate.Issuer'),
        title = locale(prefix .. '.Title'),
        subtitle = locale('Certificate.Subtitle'),
        lead = allowInput and locale('Certificate.Petitions') or locale('Certificate.Certifies'),
        body = allowInput and locale(prefix .. '.PetitionBody') or locale(prefix .. '.Body'),
        issuedOn = locale('Certificate.IssuedOn'),
        certificateNo = locale('Certificate.CertificateNo'),
        registrar = locale('Certificate.Registrar'),
        confirm = locale('Certificate.Confirm'),
        close = locale('Certificate.Close'),
        fileHint = locale('Certificate.FileHint'),
        invalidName = locale('NameFilter.InvalidName'),
    }
end

local function buildCertificateNo(documentType)
    local prefix = documentType == 'marriage' and 'MC' or 'NC'
    return ('%s-%s-%s'):format(prefix, formatCertificateDateStamp(), lib.string.random('AAAA1111'))
end

RegisterNUICallback('certificateResult', function(data, cb)
    if type(data) ~= 'table' then
        cb({ ok = false })
        return
    end

    if data.confirmed == true then
        local firstName, lastName = ParsePlayerName(data.firstName, data.lastName)
        if not firstName or not lastName then
            cb({ ok = false })
            return
        end
        certificateResult = {
            confirmed = true,
            firstName = firstName,
            lastName = lastName,
        }
    else
        certificateResult = { confirmed = false }
    end

    SetNuiFocus(false, false)
    cb({ ok = true })
end)

function ShowCertificate(documentType, options)
    options = options or {}

    local allowInput = options.allowInput == true
    local allowConfirm = options.allowConfirm ~= false
    local menuType = options.menuType or (documentType == 'marriage' and 'marriage' or 'personal')

    certificateResult = nil

    SendNUIMessage({
        action = 'openCertificate',
        documentType = documentType,
        firstName = options.firstName or '',
        lastName = options.lastName or '',
        allowConfirm = allowConfirm,
        allowInput = allowInput,
        issuedDate = formatIssuedDate(),
        certificateNo = buildCertificateNo(documentType),
        labels = buildLabels(documentType, allowInput),
        inputLabels = allowInput and buildInputLabels(menuType) or nil,
    })

    SetNuiFocus(true, true)

    while certificateResult == nil do
        Wait(50)
    end

    if not certificateResult.confirmed then
        return nil, nil
    end

    local firstName = certificateResult.firstName
    local lastName = certificateResult.lastName

    if allowInput and (firstName == '' or lastName == '') then
        return nil, nil
    end

    if allowInput then
        return ParsePlayerName(firstName, lastName)
    end

    return ParsePlayerName(options.firstName, options.lastName)
end

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    SetNuiFocus(false, false)
    if certificateResult == nil then
        certificateResult = { confirmed = false }
    end
end)
