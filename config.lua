Config = {
	ox_lib = true,										-- set this to true if using ox_lib, if false comment it out in the manifest
	ox_inventory = true,         						-- set this to true if using ox_inventory
	ox_lib_notification = true,  						-- set this to true if you want to use ox_lib notifications, false will be qb-core
	ox_lib_logging = true,  	 						-- set this to true if you want to use ox_lib logging, do not run this at the same time as qb logging
	qb_logging = false,  	 	 						-- set this to true if you want to use qb-logging, do not run this at the same time as ox_lib logging
	debugprints = true,          						-- set this to turn on prints
	namechangeitem = "namechangevoucher",               -- set this to usable item name (could be good for monetizations?)
	marriagecertificate = "blankmarriagecertificate",   -- set this to item for a judge or someone like a pastor to give an item to change name on use
	filledcertificate = "filledcertificate",       		-- set this to item for a filled certificate to apply on use (by a judge or something)
	joblock = true,             						-- set this to true to prevent any job from randomly creating these, I can't imagine the chaos that would come otherwise
	jobname = "police"           						-- set this to a desired job name that can use this item, to use this Config.joblock must be set to true
}