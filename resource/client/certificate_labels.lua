local function buildInputLabels(menuType)
    if menuType == 'marriage' then
        return {
            firstName = locale('MarriageMenu.FirstName'),
            lastName = locale('MarriageMenu.LastName'),
            firstNameHint = locale('MarriageMenu.DescriptionFirstName'),
            lastNameHint = locale('MarriageMenu.DescriptionLastName'),
        }
    end

    if menuType == 'ped' then
        return {
            firstName = locale('PedNameChangeMenu.FirstName'),
            lastName = locale('PedNameChangeMenu.LastName'),
            firstNameHint = locale('PedNameChangeMenu.DescriptionFirstName'),
            lastNameHint = locale('PedNameChangeMenu.DescriptionLastName'),
        }
    end

    return {
        firstName = locale('NameChangeMenu.FirstName'),
        lastName = locale('NameChangeMenu.LastName'),
        firstNameHint = locale('NameChangeMenu.DescriptionFirstName'),
        lastNameHint = locale('NameChangeMenu.DescriptionLastName'),
    }
end

local function buildLabels(documentType, allowInput, maxLength)
    local isMarriage = documentType == 'marriage'
    return {
        issuer = locale('Certificate.Issuer'),
        title = isMarriage and locale('Certificate.Marriage.Title') or locale('Certificate.NameChange.Title'),
        subtitle = locale('Certificate.Subtitle'),
        lead = allowInput and locale('Certificate.Petitions') or locale('Certificate.Certifies'),
        body = allowInput
            and (isMarriage and locale('Certificate.Marriage.PetitionBody') or locale('Certificate.NameChange.PetitionBody'))
            or (isMarriage and locale('Certificate.Marriage.Body') or locale('Certificate.NameChange.Body')),
        issuedOn = locale('Certificate.IssuedOn'),
        certificateNo = locale('Certificate.CertificateNo'),
        registrar = locale('Certificate.Registrar'),
        confirm = locale('Certificate.Confirm'),
        close = locale('Certificate.Close'),
        fileHint = locale('Certificate.FileHint', maxLength),
        invalidName = locale('NameFilter.InvalidName'),
    }
end

function BuildCertificateLabels(documentType, allowInput, maxLength, menuType)
    return buildLabels(documentType, allowInput, maxLength), allowInput and buildInputLabels(menuType) or nil
end
