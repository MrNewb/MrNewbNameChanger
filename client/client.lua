RegisterNetEvent("newbsnamechange:client:openName", function()
	SubmitName()
end)

function SubmitName()
	if Config.ox_lib then
		local input = lib.inputDialog('Name Change Application', {'First Name', 'Last Name'})
		if not input then return end
		local submittedfirstname = input[1]
		local submittedlastname = input[2]
		lib.notify({ title = 'Name Change Application', description = 'Successfully Changed Name To '..submittedfirstname.."  "..submittedlastname , type = 'success' })
		TriggerServerEvent("MrNewbNameChanger:change", submittedfirstname, submittedlastname)
	else
        local qbnameinput = exports['qb-input']:ShowInput({
            header = "Name Change Application",
            submitText = "Confirm",
            inputs = {
                {
                    type = 'text',
                    isRequired = true,
                    text = "First Name",
                    name = 'submittedfirstname',
                },
                {
                    type = 'text',
                    isRequired = true,
                    text = "Last Name",
                    name = 'submittedlastname',
                }
            }
        })
        local namemenu = qbnameinput and qbnameinput.submittedfirstname and qbnameinput.submittedlastname or nil
        if namemenu then
            TriggerServerEvent("MrNewbNameChanger:change", qbnameinput.submittedfirstname, qbnameinput.submittedlastname)
        end
	end
end