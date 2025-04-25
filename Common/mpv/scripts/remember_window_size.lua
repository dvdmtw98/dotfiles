local utils = require 'mp.utils'

local state_dir = mp.command_native({"expand-path", "~~state/"})
local config_path = utils.join_path(state_dir, "window_size.conf")

local default_geometry = "800x600" -- Fallback geometry if none is available

-- Debug function for logging (only enabled when there's an issue)
local debug_enabled = false -- Set to true to enable debugging

local function debug_log(message)
    if debug_enabled then
        local log_path = utils.join_path(state_dir, "mpv_debug.log")
        local log_file = io.open(log_path, "a")
        if log_file then
            log_file:write(message .. "\n")
            log_file:close()
        end
    end
end

-- Function to save window geometry to a config file
local function save_window_size()
    local osd_width = mp.get_property("osd-width")
    local osd_height = mp.get_property("osd-height")

    if osd_width and osd_height then
        local window_geometry = string.format("%dx%d", osd_width, osd_height)
        debug_log("Saving window size: " .. window_geometry)

        local file = io.open(config_path, "w")
        if file then
            file:write(window_geometry)
            file:close()
        else
            debug_log("Failed to open config file for writing.")
        end
    else
        debug_log("OSD width and height are unavailable, falling back to default.")
        local window_geometry = default_geometry
        local file = io.open(config_path, "w")
        if file then
            file:write(window_geometry)
            file:close()
        else
            debug_log("Failed to write fallback window size.")
        end
    end
end

-- Function to restore window geometry from the config file
local function restore_window_size()
    local file = io.open(config_path, "r")
    if file then
        local window_geometry = file:read("*all")
        file:close()
        if window_geometry and window_geometry ~= "" then
            debug_log("Restoring window size: " .. window_geometry)
            mp.set_property("geometry", window_geometry)
        else
            debug_log("Window geometry in config file is empty.")
        end
    else
        debug_log("Config file does not exist.")
    end
end

-- Hook functions
mp.register_event("shutdown", save_window_size)
mp.register_event("start-file", restore_window_size)
