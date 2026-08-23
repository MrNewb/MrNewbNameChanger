if not Config.Debug then return end

AddEventHandler('onClientResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end

    Wait(2000)
    RemovePedNameChangeLocations()
    CreatePedNameChangeLocations()
    print('[MrNewbNameChanger][Debug] Records clerk locations reloaded.')
end)
