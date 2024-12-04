--		___  ___       _   _                  _      _____              _         _        		
--		|  \/  |      | \ | |                | |    /  ___|            (_)       | |       		
--		| .  . | _ __ |  \| |  ___ __      __| |__  \ `--.   ___  _ __  _  _ __  | |_  ___ 		
--		| |\/| || '__|| . ` | / _ \\ \ /\ / /| '_ \  `--. \ / __|| '__|| || '_ \ | __|/ __|		
--		| |  | || |   | |\  ||  __/ \ V  V / | |_) |/\__/ /| (__ | |   | || |_) || |_ \__ \		
--		\_|  |_/|_|   \_| \_/ \___|  \_/\_/  |_.__/ \____/  \___||_|   |_|| .__/  \__||___/		
--                                                                  | |              			
--                                                                  |_|              			
--		  Need support? Join our Discord server for help: https://discord.gg/mrnewbscripts		

Config = {
	ox_lib = true,										-- set this to true if using ox_lib, if false comment it out in the manifest
	ox_inventory = true,         						-- set this to true if using ox_inventory
	ox_lib_notification = true,  						-- set this to true if you want to use ox_lib notifications
	qb_notification = false,  							-- set this to true if you want to use qb notifications
	logs_enabled = false,  	 							-- set this to true if you want to logging
	ox_lib_logging = false,  	 						-- set this to true if you want to use ox_lib logging, do not run this at the same time as qb logging
	qb_logging = false,  	 	 						-- set this to true if you want to use qb-logging, do not run this at the same time as ox_lib logging
	debugprints = false,          						-- set this to turn on prints
	namechangeitem = "namechangevoucher",               -- set this to usable item name (could be good for monetizations?)
	marriagecertificate = "blankmarriagecertificate",   -- set this to item for a judge or someone like a pastor to give an item to change name on use
	filledcertificate = "filledcertificate",       		-- set this to item for a filled certificate to apply on use (by a judge or something)
	joblock = true,             						-- set this to true to prevent any job from randomly creating these, I can't imagine the chaos that would come otherwise
	jobname = "police",           						-- set this to a desired job name that can use this item, to use this Config.joblock must be set to true
	paymentType = "none",         						-- set this to the payment type, can be "item", "cash", "bank", or "none"
	namechangeprice = 1000,        						-- set this to the price of the name change
	currencyItem = "cash",         						-- set this to the item name if paymentType is set to "item"


	-- Language Configuration

	lang = {
		namechange_title = "Name Change Application",
		firstname = "First Name",
		lastname = "Last Name",
	}

}
