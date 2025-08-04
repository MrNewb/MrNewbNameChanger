Bridge = exports.community_bridge:Bridge()

function locale(message, ...)
    return Bridge.Language.Locale(message, ...)
end

TableContains = Bridge.Tables.TableContains

if not IsDuplicityVersion() then return end

SendNotify = Bridge.Notify.SendNotify

RemoveItem = Bridge.Inventory.RemoveItem

AddItem = Bridge.Inventory.AddItem

function RegisterUsableItems()
    Bridge.Framework.RegisterUsableItem(Config.Items.FilledCertificate, function(src, itemData)
        local metadata = itemData.metadata
        if not metadata.firstname or not metadata.lastname then return end
        if itemData.metadata.firstname == '' or itemData.metadata.lastname == '' then return end
        ChangeName(src, itemData.metadata.firstname, itemData.metadata.lastname, Config.Items.FilledCertificate, itemData.slot)
    end)

    Bridge.Framework.RegisterUsableItem(Config.Items.MarriageCertificate, function(src, itemData)
        if Config.JobLockedItem then
            local jobname, _, __, ___ = Bridge.Framework.GetPlayerJob(src)
            if not TableContains(Config.AllowedJobNames, jobname) then return SendNotify(src, locale("JobRequired.YouDoNotHaveTheJob"), "success", 6000) end
        end
        local firstname, lastname = Bridge.Callback.Trigger("MrNewbNameChanger:callback:openInput", src, "marriage")
        if not firstname or not lastname then return print("No return value") end
        GenerateFilledCertificate(src, firstname, lastname)
    end)

    Bridge.Framework.RegisterUsableItem(Config.Items.NameChangeVoucher, function(src, itemData)
        local firstname, lastname = Bridge.Callback.Trigger("MrNewbNameChanger:callback:openInput", src, "personal")
        if not firstname or not lastname then return end
        ChangeName(src, firstname, lastname, Config.Items.NameChangeVoucher)
    end)
end

AddEventHandler('onResourceStart', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    RegisterUsableItems()
    Bridge.Version.VersionChecker("MrNewb/patchnotes", false, true, "MrNewbNameChanger", "MrNewb/MrNewbNameChanger")
end)