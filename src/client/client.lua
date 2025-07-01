local function buildMarriageCertificateMenu()
	local data = {
		{
			type = 'input',
			label = locale("MarriageMenu.FirstName"),
			description = locale("MarriageMenu.DescriptionFirstName"),
			placeholder = locale("MarriageMenu.FirstName"),
			required = true,
		},
		{
			type = 'input',
			label = locale("MarriageMenu.LastName"),
			description = locale("MarriageMenu.DescriptionLastName"),
			placeholder = locale("MarriageMenu.LastName"),
			required = true,
		},
	}
	local inputData = Bridge.Input.Open(locale("MarriageMenu.Title"), data, false, locale("MarriageMenu.Submit"))
	if inputData and inputData[1] and inputData[2] then return inputData[1], inputData[2] end
	return false, false
end

local function buildPersonalNameChange()
	local data = {
		{
			type = 'input',
			label = locale("NameChangeMenu.FirstName"),
			description = locale("NameChangeMenu.DescriptionFirstName"),
			placeholder = locale("NameChangeMenu.FirstName"),
			required = true,
		},
		{
			type = 'input',
			label = locale("NameChangeMenu.LastName"),
			description = locale("NameChangeMenu.DescriptionLastName"),
			placeholder = locale("NameChangeMenu.LastName"),
			required = true,
		},
	}
	local inputData = Bridge.Input.Open(locale("NameChangeMenu.Title"), data, false, locale("NameChangeMenu.Submit"))
	if inputData and inputData[1] and inputData[2] then return inputData[1], inputData[2] end
	return false, false
end

Bridge.Callback.Register('MrNewbNameChanger:callback:openInput', function(_type)
	if _type == "marriage" then
		local return1, return2 = buildMarriageCertificateMenu()
		return return1, return2
	elseif _type == "personal" then
		local return1, return2 = buildPersonalNameChange()
		return return1, return2
	end
	return false, false
end)