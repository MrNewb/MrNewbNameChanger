local function buildNameChangeMenu(menuType)
	local prefix = menuType == "marriage" and "MarriageMenu" or "NameChangeMenu"

	local data = {
		{
			type = 'input',
			label = locale(prefix .. ".FirstName"),
			description = locale(prefix .. ".DescriptionFirstName"),
			placeholder = locale(prefix .. ".FirstName"),
			required = true,
		},
		{
			type = 'input',
			label = locale(prefix .. ".LastName"),
			description = locale(prefix .. ".DescriptionLastName"),
			placeholder = locale(prefix .. ".LastName"),
			required = true,
		},
	}

	local inputData = Bridge.Input.Open(locale(prefix .. ".Title"), data, false, locale(prefix .. ".Submit"))
	if inputData and inputData[1] and inputData[2] then
		return inputData[1], inputData[2]
	end
	return false, false
end

Bridge.Callback.Register('MrNewbNameChanger:callback:openInput', function(_type)
	return buildNameChangeMenu(_type)
end)