lib.locale()

lib.callback.register('MrNewbNameChanger:Callback:NameFlow', function(flowType)
    local menuType = flowType == 'marriage' and 'marriage' or 'personal'
    local documentType = flowType == 'marriage' and 'marriage' or 'namechange'

    local firstName, lastName = ShowCertificate(documentType, {
        allowInput = true,
        menuType = menuType,
    })

    if not firstName or not lastName then
        return '', ''
    end

    return firstName, lastName
end

lib.callback.register('MrNewbNameChanger:Callback:ShowCertificate', function(documentType, firstName, lastName, allowConfirm)
    local confirmedFirst, confirmedLast = ShowCertificate(documentType, {
        firstName = firstName,
        lastName = lastName,
        allowConfirm = allowConfirm ~= false,
        allowInput = false,
    })

    return confirmedFirst and confirmedLast and true or false
end)
