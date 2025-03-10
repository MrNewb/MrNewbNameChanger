fx_version 'cerulean'
game 'gta5'
lua54 'yes'
name "MrNewbNameChanger"
author "MrNewb"
version '2.0.1'

shared_scripts {
	'@ox_lib/init.lua',
	'src/shared/init.lua',
	'src/shared/config.lua'
}

client_scripts {
	'src/client/*.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'src/server/*.lua'
}

files {
	'locales/*.json',
}

dependencies {
    '/server:6116',
    '/onesync',
    'ox_lib',
    'community_bridge',
}