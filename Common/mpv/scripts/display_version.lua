local mp = require 'mp'
local msg = require 'mp.msg'

msg.info("Lua version: " .. _VERSION)
msg.info("MPV version: " .. mp.get_property_native("mpv-version"))
msg.info("Platform: " .. mp.get_property_native("platform"))