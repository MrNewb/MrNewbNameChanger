fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'MrNewbNameChanger'
author 'MrNewb'
description 'Name change vouchers, marriage certificates, and bad-word filtering'
version '3.0.1'

ui_page 'web/build/index.html'

shared_scripts {
    '@ox_lib/init.lua',
    '@Newb_Bridge/import.lua',
    'configs/config.lua',
    'resource/shared/locale.lua',
    'resource/shared/filter.lua',
}

client_scripts {
    'resource/client/certificate_labels.lua',
    'resource/client/certificate.lua',
    'resource/client/names.lua',
    'resource/client/clerk.lua',
    'resource/client/debug.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'resource/open/server/*.lua',
    'resource/server/names.lua',
    'resource/server/items.lua',
    'resource/server/clerk.lua',
}

files {
    'locales/*.json',
    'web/build/index.html',
    'web/build/**/*',
}

dependencies {
    '/server:6116',
    '/onesync',
    'ox_lib',
    'oxmysql',
    'Newb_Bridge',
}

escrow_ignore {
    'configs/*.lua',
    'locales/*.json',
    'resource/open/**/*',
    'resource/**/*.lua',
    'web/**/*',
}
