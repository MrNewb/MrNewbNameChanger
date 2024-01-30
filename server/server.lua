local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("MrNewbNameChanger:change", function(submittedfirstname, submittedlastname)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local item = Config.itemname

	if not Player then print("Player not found!") return end

	if Config.ox_inv then
	    local items = exports.ox_inventory:Search(src, 'count', item)
		--print(items)
		if items >= 1 then
			ReceivedName(Player, submittedfirstname, submittedlastname)
			exports.ox_inventory:RemoveItem(src, item, 1)
		end
	else
		local namechangeitem = Player.Functions.GetItemByName(item)
		if namechangeitem ~= nil then
			ReceivedName(Player, submittedfirstname, submittedlastname)
			Player.Functions.RemoveItem(item, 1)
			if not Config.ox_lib then
				TriggerClientEvent('QBCore:Notify', src, 'Successfully Changed Name To '..submittedfirstname.."  "..submittedlastname, 'success')
			end
		end
	end
end)

function ReceivedName(Player, submittedfirstname, submittedlastname)
	if Config.debugprints then
		print("Received Data from Client | firstname: ", submittedfirstname, " | lastname: ", submittedlastname)
	end
	
	local charInfo = Player.PlayerData.charinfo

	charInfo.firstname = charInfo.firstname ~= '' and submittedfirstname
	charInfo.lastname = charInfo.lastname ~= '' and submittedlastname

	Player.Functions.SetPlayerData("charinfo", charInfo)
	Player.Functions.SetMetaData("firstname", charInfo.firstname)
	Player.Functions.SetMetaData("lastname", charInfo.lastname)

	Player.Functions.Save()
	Player.Functions.UpdatePlayerData(false)
	TriggerClientEvent('QBCore:Player:UpdatePlayerData', source)

	if Config.debugprints then
		print("Player Name Changed To | ", charInfo.firstname, " | ", charInfo.lastname)
		print("Player Data Update Passed To Client")
	end
end

QBCore.Functions.CreateUseableItem(Config.itemname, function(source, item)
    TriggerClientEvent('newbsnamechange:client:openName', source, item)
end)