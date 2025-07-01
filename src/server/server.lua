local function updatePlayerData(src, submittedfirstname, submittedlastname)
	local frameworkName = Bridge.Framework.GetFrameworkName()
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
	if not name:match("^[%a]+$") then return true end
	for _, badWord in ipairs(Config.BadWords) do
		if name:lower():find(badWord) then return true end
	end
	return false
end

function ChangeName(src, submittedfirstname, submittedlastname, itemname, slot)
	local itemCount = Bridge.Inventory.GetItemCount(src, itemname, nil)
	if itemCount <= 0 then return end
	if isABadWord(submittedfirstname) or isABadWord(submittedlastname) then return SendNotify(src, string.format(locale("BadWordFilter.FailedFilter"), submittedfirstname, submittedlastname), "error", 6000) end
	updatePlayerData(src, submittedfirstname, submittedlastname)
	SendNotify(src, string.format(locale("Notifications.NameChangeSuccess"), submittedfirstname, submittedlastname), "success", 6000)
	RemoveItem(src, itemname, 1, slot, nil)
end

function GenerateFilledCertificate(src, submittedfirstname, submittedlastname)
	local itemCount = Bridge.Inventory.GetItemCount(src, Config.Items.MarriageCertificate, nil)
	if itemCount <= 0 then return end
	if isABadWord(submittedfirstname) or isABadWord(submittedlastname) then return SendNotify(src, string.format(locale("BadWordFilter.FailedFilter"), submittedfirstname, submittedlastname), "error", 6000) end
	RemoveItem(src, Config.Items.MarriageCertificate, 1, nil, nil)
	AddItem(src, Config.Items.FilledCertificate, 1, nil, {firstname = submittedfirstname, lastname = submittedlastname, description = string.format(locale("FilledCertificate.Description"), submittedfirstname, submittedlastname)})
	SendNotify(src, string.format(locale("Notifications.CertificateCreated"), submittedfirstname, submittedlastname), "success", 6000)
end