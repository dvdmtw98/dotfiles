local utils = require 'mp.utils'
local msg = require 'mp.msg'

local os_name = package.config:sub(1, 1) == '\\' and "windows" or "unix"

local screenshot_path = ""

if os_name == "windows" then
    screenshot_path = "F:/Images/Screenshots/MPV"
elseif os_name == "unix" then
    screenshot_path = "/media/shared/Images/Screenshots/MPV"
end

mp.set_property("screenshot-directory", screenshot_path)
msg.info("Screenshot Directory: " .. screenshot_path)
