-- =====================================
--     https://discord.gg/ec7rmMHPTG
--               hexz.0.7
-- =====================================

fx_version 'cerulean'
game 'gta5'

author 'Hexz.0.7'
description 'Advanced Fishing System'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client/client.lua'
}

server_scripts {
    'server/server.lua'
}

lua54 'yes'

dependencies {
    'ox_lib'
}
