name "cards"
author "KamuiKody"
description "Enhanced by Jimathy"
fx_version "cerulean"
game "gta5"

ui_page 'ui/ui.html'

files {
	'ui/ui.html',
	'ui/assets/css/*.css',
	'ui/assets/js/*.js',
	'ui/assets/img/*.png',
	"html/index.html",
	"html/index.js",
	"html/index.css",
	"html/reset.css",
	"html/bttn.min.css",
	'html/*.png',
	'html/*.gif'
}

client_scripts {
    '@menuv/menuv.lua',
    'client.lua',
	'gl_client.lua',
    'config.lua'
}
server_script {
    'server.lua',
	'gl_server.lua'
}
server_script "config.lua"

