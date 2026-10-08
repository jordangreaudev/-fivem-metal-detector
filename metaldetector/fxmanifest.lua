fx_version 'cerulean'
game 'gta5'
lua54 'yes'
name 'MetalDetector'
author 'Jordan Greau'
description 'Portiques detecteurs de metaux via props'
version '1.0.0'

dependency 'ox_inventory'

shared_scripts {
    'config.lua'
}

client_scripts {
    'bridge/client.lua',
    'client/client.lua'
}

server_scripts {
    'server/server.lua'
}
