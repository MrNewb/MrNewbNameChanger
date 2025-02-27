lib.callback.register('MrNewbNameChanger:callback:openInput', function()
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
	if inputData and inputData[1] and inputData[2] then
		return inputData[1], inputData[2]
	else
		return nil, nil
	end
end)

