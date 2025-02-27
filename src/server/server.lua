local function updatePlayerData(src, submittedfirstname, submittedlastname)
	local frameworkName = Bridge.Framework.GetFrameworkName()
	local oldFirst, oldLast = Bridge.Framework.GetPlayerName(src)
	Bridge.Logs.Send(src, locale("LogMessages.NameChangeSubmitted")..tostring(src).." "..submittedfirstname.." "..submittedlastname.." "..oldFirst.." "..oldLast)
	if frameworkName == "qb-core" then
		local QBCore = exports['qb-core']:GetCoreObject()
		local Player = QBCore.Functions.GetPlayer(src)
		local charInfo = Player.PlayerData.charinfo
		charInfo.firstname = charInfo.firstname ~= '' and submittedfirstname
		charInfo.lastname = charInfo.lastname ~= '' and submittedlastname
		Player.Functions.SetPlayerData("charinfo", charInfo)

		Player.Functions.Save()
		Player.Functions.UpdatePlayerData(false)
		TriggerClientEvent('QBCore:Player:UpdatePlayerData', src)
	elseif frameworkName == "qbx_core" then
		local QBox = exports.qbx_core
		local Player = QBox:GetPlayer(src)
		local charInfo = Player.PlayerData.charinfo
		charInfo.firstname = charInfo.firstname ~= '' and submittedfirstname
		charInfo.lastname = charInfo.lastname ~= '' and submittedlastname
		Player.Functions.SetPlayerData("charinfo", charInfo)

		Player.Functions.Save()
		Player.Functions.UpdatePlayerData(false)
		TriggerClientEvent('QBCore:Player:UpdatePlayerData', src)
	elseif frameworkName == "es_extended" then
		local ESX = exports['es_extended']:getSharedObject()
		local xPlayer = ESX.GetPlayerFromId(src)
		if not xPlayer then return end
		xPlayer.setName(('%s %s'):format(submittedfirstname, submittedlastname))
		xPlayer.set('firstName', submittedfirstname)
		xPlayer.set('lastName', submittedlastname)
		MySQL.query.await("UPDATE users SET firstname = ?, lastname = ? WHERE identifier = ?", { submittedfirstname, submittedlastname, xPlayer.identifier })
	end
end

local function isABadWord(name)
	if not name:match("^[%a]+$") then
		return true
	end
	for _, badWord in ipairs(Config.BadWords) do
		if name:lower():find(badWord) then
			return true
		end
	end
	return false
end

function ChangeName(src, submittedfirstname, submittedlastname, itemname)
	local itemCount = Bridge.Inventory.GetItemCount(src, itemname, nil)
	if itemCount == 0 then return end
	local firstName = submittedfirstname
	local lastName = submittedlastname
	if isABadWord(firstName) or isABadWord(lastName) then return Bridge.Notify.SendNotify(src, locale("BadWordFilter.FailedFilter").." "..firstName.." "..lastName, "error", 6000) end
	updatePlayerData(src, firstName, lastName)
	Bridge.Notify.SendNotify(src, locale("Notifications.NameChangeSuccess")..firstName.."  "..lastName, "success", 6000)
	Bridge.Inventory.RemoveItem(src, itemname, 1, nil, nil)
end

function GenerateFilledCertificate(src, submittedfirstname, submittedlastname)
	local itemCount = Bridge.Inventory.GetItemCount(src, Config.Items.MarriageCertificate, nil)
	if itemCount == 0 then return end
	local firstName = submittedfirstname
	local lastName = submittedlastname
	if isABadWord(firstName) or isABadWord(lastName) then return Bridge.Notify.SendNotify(src, locale("BadWordFilter.FailedFilter").." "..firstName.." "..lastName, "error", 6000) end
	Bridge.Inventory.RemoveItem(src, Config.Items.MarriageCertificate, 1, nil, nil)
	Bridge.Inventory.AddItem(src, Config.Items.FilledCertificate, 1, nil, { firstname = firstName, lastname = lastName, description = locale("ItemDescription.DescriptionField")..firstName.."  "..lastName })
	Bridge.Notify.SendNotify(src, locale("Notifications.CertificateCreated")..firstName.." "..lastName, "success", 6000)
end