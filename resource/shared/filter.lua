local function trimName(value)
    if type(value) ~= 'string' then return '' end
    return value:gsub('^%s*(.-)%s*$', '%1')
end

local function isLettersOnly(name)
    return name:match('^[A-Za-z]+$') ~= nil
end

local function hasBadWord(name)
    local words = Config.NameFilter and Config.NameFilter.BadWords or {}
    local lowered = name:lower()

    for i = 1, #words do
        local word = words[i]
        if type(word) == 'string' and word ~= '' and lowered:find(word:lower(), 1, true) then
            return true
        end
    end

    return false
end

function ParsePlayerName(firstName, lastName)
    firstName = trimName(firstName)
    lastName = trimName(lastName)
    if firstName == '' or lastName == '' then return end

    local maxLength = Config.NameFilter and Config.NameFilter.MaxLength or 32
    if #firstName > maxLength or #lastName > maxLength then return end
    if not isLettersOnly(firstName) or not isLettersOnly(lastName) then return end
    if hasBadWord(firstName) or hasBadWord(lastName) then return end

    return firstName, lastName
end
