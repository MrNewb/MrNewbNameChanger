RegisterNetEvent("newbsnamechange:client:openName", function(status)
	SubmitName(status)
end)

function SubmitName(status)
	if Config.ox_lib then
		local input = lib.inputDialog('Name Change Application', {'First Name', 'Last Name'})
		if not input then return end
		local submittedfirstname, submittedlastname = input[1], input[2]
		if not status then
			lib.notify({ title = 'Name Change Application', description = 'Successfully Changed Name To '..submittedfirstname.."  "..submittedlastname , type = 'success' })
			TriggerServerEvent("MrNewbNameChanger:change", submittedfirstname, submittedlastname)
		else
			lib.notify({ title = 'Name Change Application', description = 'Successfully Created Certificate for '..submittedfirstname.."  "..submittedlastname , type = 'success' })
			TriggerServerEvent("MrNewbNameChanger:metaItem", submittedfirstname, submittedlastname)
		end
	else
        local qbnameinput = exports['qb-input']:ShowInput({
            header = "Name Change Application",
            submitText = "Confirm",
            inputs = {
                { type = 'text', isRequired = true, text = "First Name", name = 'submittedfirstname',},
                { type = 'text', isRequired = true, text = "Last Name", name = 'submittedlastname',}
            }
        })
        local namemenu = qbnameinput and qbnameinput.submittedfirstname and qbnameinput.submittedlastname or nil
        if namemenu then
			if not status then
				TriggerServerEvent("MrNewbNameChanger:change", qbnameinput.submittedfirstname, qbnameinput.submittedlastname)
			else
				TriggerServerEvent("MrNewbNameChanger:metaItem", qbnameinput.submittedfirstname, qbnameinput.submittedlastname)
			end
        end
	end
end