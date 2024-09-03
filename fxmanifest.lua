--- discord https://discord.gg/757EUQFaSp

fx_version 'adamant'
game 'gta5'
lua54 'yes'

description 'Ko_pesulat'
author 'Karvelooo'
version '1.0.0'

client_scripts {
    'Ko_pesulat_cl/cl.lua'
}

server_scripts {
    'Ko_pesulat_sv/sv.lua'
}
shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    '@es_extended/locale.lua',
}
dependencies {
    'es_extended'
}