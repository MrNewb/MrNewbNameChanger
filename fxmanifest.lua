fx_version 'cerulean'
game 'gta5'
lua54 'yes'
name "MrNewbNameChanger"
author "MrNewb"
version '2.3.1'

shared_scripts {
	'core/init.lua',
	'data/config.lua',
	'modules/**/shared/*.lua',
}

client_scripts {
	'modules/**/client/*.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'modules/**/server/*.lua',
}

files {
	'locales/*.json',
}

dependencies {
    '/server:6116',
    '/onesync',
    'community_bridge',
}

escrow_ignore {
	'**/*.lua',
}