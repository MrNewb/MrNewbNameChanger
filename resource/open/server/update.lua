--[[
	Framework-specific character name write. Override for custom multi-char / identity resources.
	Returns true when the live player name was updated.
]]

---@param src number
---@param firstName string
---@param lastName string
---@return boolean
function OpenUpdatePlayerName(src, firstName, lastName)
	local framework = bridge.framework.getResourceName()

	if framework == 'qb-core' then
		local QBCore = exports['qb-core']:GetCoreObject()
		local player = QBCore.Functions.GetPlayer(src)
		if not player then return false end

		local charInfo = player.PlayerData.charinfo or {}
		charInfo.firstname = firstName
		charInfo.lastname = lastName
		player.Functions.SetPlayerData('charinfo', charInfo)
		player.Functions.Save()
		player.Functions.UpdatePlayerData(false)
		TriggerClientEvent('QBCore:Player:UpdatePlayerData', src)
		return true
	end

	if framework == 'qbx_core' then
		local player = exports.qbx_core:GetPlayer(src)
		if not player then return false end

		local charInfo = player.PlayerData.charinfo or {}
		charInfo.firstname = firstName
		charInfo.lastname = lastName
		player.Functions.SetPlayerData('charinfo', charInfo)
		player.Functions.Save()
		player.Functions.UpdatePlayerData(false)
		TriggerClientEvent('QBCore:Player:UpdatePlayerData', src)
		return true
	end

	if framework == 'es_extended' then
		-- probably works?
		local ESX = exports.es_extended:getSharedObject()
		local xPlayer = ESX.GetPlayerFromId(src)
		if not xPlayer then return false end

		xPlayer.setName(('%s %s'):format(firstName, lastName))
		xPlayer.set('firstName', firstName)
		xPlayer.set('lastName', lastName)
		MySQL.update.await('UPDATE users SET firstname = ?, lastname = ? WHERE identifier = ?', {
			firstName,
			lastName,
			xPlayer.identifier,
		})
		return true
	end

	return false
end
