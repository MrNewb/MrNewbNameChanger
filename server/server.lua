local QBCore = exports['qb-core']:GetCoreObject()

function saveData(src, charInfo)
    local Player = QBCore.Functions.GetPlayer(src)
    
    -- Retrieve current (old) character data before updating
    local oldCharInfo = Player.PlayerData.charinfo
    local oldFirstName = oldCharInfo.firstname
    local oldLastName = oldCharInfo.lastname
    local citizenId = Player.PlayerData.citizenid

    -- Update character data
    Player.Functions.SetPlayerData("charinfo", charInfo)
    Player.Functions.SetMetaData("firstname", charInfo.firstname)
    Player.Functions.SetMetaData("lastname", charInfo.lastname)

    -- Save and update player data
    Player.Functions.Save()
    Player.Functions.UpdatePlayerData(false)
    TriggerClientEvent('QBCore:Player:UpdatePlayerData', src)

    -- Log the old and new names with Citizen ID
    logs(src, oldFirstName .. " " .. oldLastName .. " (" .. citizenId .. ") | Has changed names to " .. charInfo.firstname .. " " .. charInfo.lastname)
end

function ReceivedName(Player, submittedfirstname, submittedlastname)
	if not Player then return end
	local charInfo = Player.PlayerData.charinfo
	if Config.debugprints then print("Received Data from Client | firstname: ", submittedfirstname, " | lastname: ", submittedlastname) end
	charInfo.firstname = charInfo.firstname ~= '' and submittedfirstname
	charInfo.lastname = charInfo.lastname ~= '' and submittedlastname

	saveData(source, charInfo)

	if Config.debugprints then print("Player Name Changed To | ", charInfo.firstname, " | ", charInfo.lastname) end
end

function logs(src, msg)
	if not Config.logs_enabled then 
		return 
	end
	
    if Config.ox_lib_logging then
        lib.logger(src, 'MrNewbNameChanger', msg)
        return
    end

    if Config.qb_logging then
        TriggerEvent('qb-log:server:CreateLog', 'namechangelog', 'MrNewbNameChanger', 'red', msg)
    end

end

function notifyPlayer(src, msg, status)
    if Config.ox_lib_notification then
        TriggerClientEvent('ox_lib:notify', src, { title = "Name Change", description = msg, duration = 10000, type = status })
        return
    end

    if Config.qb_notification then
        TriggerClientEvent('QBCore:Notify', src, msg, status)
    end

end

RegisterNetEvent("MrNewbNameChanger:change", function(submittedfirstname, submittedlastname)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local item = Config.namechangeitem

	if not Player then return end

	if Config.ox_inventory then
	    local items = exports.ox_inventory:Search(src, 'count', item)
		if items >= 1 then
			ReceivedName(Player, submittedfirstname, submittedlastname)
			notifyPlayer(src, 'Successfully Changed Name To '..submittedfirstname.."  "..submittedlastname, 'success')
			exports.ox_inventory:RemoveItem(src, item, 1)
			if Config.debugprints then print("item removed | ", item, " | from ID| # ", src) end
		end
	else
		local namechangeitem = Player.Functions.GetItemByName(item)
		if namechangeitem ~= nil then
			if Player.Functions.RemoveItem(item, 1, item.slot) then
				ReceivedName(Player, submittedfirstname, submittedlastname)
				notifyPlayer(src, 'Successfully Changed Name To '..submittedfirstname.."  "..submittedlastname, 'success')
				
				if Config.debugprints then print("item removed | ", item, " | from ID| # ", src) end
			end
		end
	end
end)

RegisterNetEvent("MrNewbNameChanger:metaItem", function(submittedfirstname, submittedlastname)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local item = Config.marriagecertificate
	local filleditem = Config.filledcertificate

	if not Player then return end

	if Config.ox_inventory then
	    local items = exports.ox_inventory:Search(src, 'count', item)
		if items >= 1 then
			exports.ox_inventory:RemoveItem(src, item, 1)
			local metadata = { firstname = submittedfirstname, lastname = submittedlastname,
				description = "Certificate for legal name change to "..submittedfirstname.."  "..submittedlastname 
			}
			exports.ox_inventory:AddItem(src, filleditem, 1, metadata)
		end
	else
		local namechangeitem = Player.Functions.GetItemByName(item)
		if namechangeitem ~= nil then
			if Player.Functions.RemoveItem(item, 1, item.slot) then 
				local info = { firstname = submittedfirstname, lastname = submittedlastname, }
				Player.Functions.AddItem(filleditem, 1, nil, info)
			end
		end
	end
	notifyPlayer(src, 'Successfully Created Certificate for '..submittedfirstname.." "..submittedlastname, 'success')
	logs(src, " | Has created name change certificate for "..submittedfirstname..submittedlastname)
end)

QBCore.Functions.CreateUseableItem(Config.filledcertificate, function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local charInfo = Player.PlayerData.charinfo
    if not Player then return end

	if Config.ox_inventory then
		charInfo.firstname = charInfo.firstname ~= '' and item.metadata.firstname
		charInfo.lastname = charInfo.lastname ~= '' and item.metadata.lastname

		exports.ox_inventory:RemoveItem(src, item, 1)
	else
		charInfo.firstname = charInfo.firstname ~= '' and item.info.firstname
		charInfo.lastname = charInfo.lastname ~= '' and item.info.lastname
		
		Player.Functions.RemoveItem(Config.filledcertificate, 1, item.slot)
	end
	saveData(src, charInfo)
	notifyPlayer(src, 'Successfully Changed Name To '..charInfo.firstname.."  "..charInfo.lastname, 'success')
	if Config.debugprints then print("Player Name Changed To | ", charInfo.firstname, " | ", charInfo.lastname) end
end)

QBCore.Functions.CreateUseableItem(Config.namechangeitem, function(source, item)
    TriggerClientEvent('newbsnamechange:client:openName', source, false)
end)

QBCore.Functions.CreateUseableItem(Config.marriagecertificate, function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

	if Config.joblock then
		if not Player.PlayerData.job.name == Config.jobname then return end
	end
	TriggerClientEvent('newbsnamechange:client:openName', src, Config.joblock)
end)
