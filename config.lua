Config = {
	ox_lib = true,               -- set this to true if using ox_lib, if false comment it out in the manifest
	ox_inv = true,               -- set this to true if using ox_inv
	debugprints = true,          -- set this to turn on prints
	namechangeitem = "namechangevoucher",               -- set this to usable item name (could be good for monetizations?)
	marriagecertificate = "blankmarriagecertificate",   -- set this to item for a judge or someone like a pastor to give an item to change name on use
	filledcertificate = "filledcertificate",       -- set this to item for a filled certificate to apply on use (by a judge or something)
	jobcheck = true,             -- set this to true to prevent any job from randomly creating these, I can't imagine the chaos that would come otherwise
	jobname = "police"           -- set this to a desired job name that can use this item, to use this Config.jobcheck must be set to true
}