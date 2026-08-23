if not Config.Debug then return end
if not Config.RecordsClerk or not Config.RecordsClerk.Enabled then return end

AddEventHandler('onClientResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end

    Wait(2000)
    RemoveRecordsClerkLocations()
    CreateRecordsClerkLocations()
    print('[MrNewbNameChanger][Debug] Records clerk locations reloaded.')
end)
