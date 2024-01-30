fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name "MrNewbNameChanger"
author "MrNewb"
description 'Easy and free way to change names in qb without relog'

shared_scripts {
	'@ox_lib/init.lua',
	'config.lua'
}

client_scripts {
	'client/*.lua',
}

server_scripts {
	'server/*.lua'
}