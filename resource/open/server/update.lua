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
		return true
	end

	if framework == 'qbx_core' then
		if not exports.qbx_core:GetPlayer(src) then return false end

		exports.qbx_core:SetCharInfo(src, 'firstname', firstName)
		exports.qbx_core:SetCharInfo(src, 'lastname', lastName)
		exports.qbx_core:Save(src)
		return true
	end

	if framework == 'es_extended' then
		local ESX = exports.es_extended:getSharedObject()
		local xPlayer = ESX.GetPlayerFromId(src)
		if not xPlayer then return false end

		if type(xPlayer.setName) == 'function' then
			xPlayer.setName(('%s %s'):format(firstName, lastName))
		end

		xPlayer.set('firstName', firstName)
		xPlayer.set('lastName', lastName)

		local affected = MySQL.update.await('UPDATE users SET firstname = ?, lastname = ? WHERE identifier = ?', {
			firstName,
			lastName,
			xPlayer.identifier,
		})
		return (affected or 0) > 0
	end

	return false
end
