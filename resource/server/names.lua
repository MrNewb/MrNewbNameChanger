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

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    exports[bridge.name]:VersionCheck('MrNewb/patchnotes', resourceName)
end)
