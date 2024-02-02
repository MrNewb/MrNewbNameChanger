RegisterNetEvent("newbsnamechange:client:openName", function(status)
	SubmitName(status)
end)

function SubmitName(status)
	if Config.ox_lib then
		local input = lib.inputDialog(Config.lang.namechange_title, {Config.lang.firstname, Config.lang.lastname})
		if not input then return end
		local submittedfirstname, submittedlastname = input[1], input[2]
		if not status then
			TriggerServerEvent("MrNewbNameChanger:change", submittedfirstname, submittedlastname)
		else
			TriggerServerEvent("MrNewbNameChanger:metaItem", submittedfirstname, submittedlastname)
		end
	else
        local qbnameinput = exports['qb-input']:ShowInput({
            header = Config.lang.namechange_title,
            submitText = "Confirm",
            inputs = {
                { type = 'text', isRequired = true, text = Config.lang.firstname, name = 'submittedfirstname',},
                { type = 'text', isRequired = true, text = Config.lang.lastname, name = 'submittedlastname',}
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