local certificateResult
local awaitingCertificate = false
local uiAcknowledged = false

local readyTimeoutMs = 2000
local resultTimeoutMs = 300000

local monthNames = {
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
}

local function formatIssuedDate()
    local year, month, day = GetLocalTime()
    return ('%s %d, %d'):format(monthNames[month] or 'Unknown', day, year)
end

local function formatCertificateDateStamp()
    local year, month, day = GetLocalTime()
    return ('%04d%02d%02d'):format(year, month, day)
end

local function buildCertificateNo(documentType)
    local prefix = documentType == 'marriage' and 'MC' or 'NC'
    return ('%s-%s-%s'):format(prefix, formatCertificateDateStamp(), lib.string.random('AAAA1111'))
end

local function finishCertificate(result)
    if not awaitingCertificate then return end

    SetNuiFocus(false, false)
    certificateResult = result
    awaitingCertificate = false
end

local function openCertificateUi(documentType, options, allowInput, allowConfirm, maxLength, labels, inputLabels)
    certificateResult = nil
    awaitingCertificate = true
    uiAcknowledged = false

    SendNUIMessage({
        action = 'openCertificate',
        documentType = documentType,
        firstName = options.firstName or '',
        lastName = options.lastName or '',
        allowConfirm = allowConfirm,
        allowInput = allowInput,
        maxLength = maxLength,
        issuedDate = formatIssuedDate(),
        certificateNo = buildCertificateNo(documentType),
        labels = labels,
        inputLabels = inputLabels,
    })

    SetNuiFocus(true, true)
end

local function waitForCertificateReady()
    local deadline = GetGameTimer() + readyTimeoutMs
    while awaitingCertificate and not uiAcknowledged and GetGameTimer() < deadline do
        Wait(50)
    end

    if awaitingCertificate and not uiAcknowledged then
        finishCertificate({ confirmed = false })
        bridge.notifications.notify({ description = locale('Certificate.Unavailable'), type = 'error' })
        return false
    end

    return true
end

local function waitForCertificateResult()
    local deadline = GetGameTimer() + resultTimeoutMs
    while awaitingCertificate and GetGameTimer() < deadline do
        Wait(50)
    end

    if awaitingCertificate then
        finishCertificate({ confirmed = false })
        bridge.notifications.notify({ description = locale('Certificate.Unavailable'), type = 'error' })
        return false
    end

    return true
end

local function resolveCertificateNames(options, allowInput)
    if not certificateResult or not certificateResult.confirmed then
        return nil, nil
    end

    if not allowInput then
        return ParsePlayerName(options.firstName, options.lastName)
    end

    return ParsePlayerName(certificateResult.firstName, certificateResult.lastName)
end

RegisterNUICallback('certificateReady', function(_, cb)
    uiAcknowledged = true
    cb(1)
end)

RegisterNUICallback('certificateResult', function(data, cb)
    if not awaitingCertificate or type(data) ~= 'table' then
        cb({ ok = false })
        return
    end

    if data.confirmed ~= true then
        finishCertificate({ confirmed = false })
        cb({ ok = true })
        return
    end

    local firstName, lastName = ParsePlayerName(data.firstName, data.lastName)
    if not firstName or not lastName then
        cb({ ok = false })
        return
    end

    finishCertificate({ confirmed = true, firstName = firstName, lastName = lastName })
    cb({ ok = true })
end)

function ShowCertificate(documentType, options)
    if awaitingCertificate then return end

    options = options or {}

    local allowInput = options.allowInput == true
    local allowConfirm = options.allowConfirm ~= false
    local menuType = options.menuType or (documentType == 'marriage' and 'marriage' or 'personal')
    local maxLength = Config.NameFilter and Config.NameFilter.MaxLength or 32
    local labels, inputLabels = BuildCertificateLabels(documentType, allowInput, maxLength, menuType)

    openCertificateUi(documentType, options, allowInput, allowConfirm, maxLength, labels, inputLabels)
    if not waitForCertificateReady() then return end
    if not waitForCertificateResult() then return end

    return resolveCertificateNames(options, allowInput)
end

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    finishCertificate({ confirmed = false })
    SetNuiFocus(false, false)
end)
