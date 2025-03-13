-- ==============================
--  Module Imports
-- ==============================

local mp = require 'mp'
local utils = require 'mp.utils'
-- MD5 had to be manually installed on system
local md5 = require 'md5'

-- ==============================
--  Global Configurations
-- ==============================

local config = {
    debug = "no", -- Enable debug messages (yes/no)
    timer_interval = 6, -- Interval in seconds for periodic save
    disable_periodic_save = "no", -- Disable periodic save function (yes/no)
    restart_on_end = "yes", -- Restart video if near the end (yes/no)
    fuzz_amount = 5, -- Fuzz amount in seconds to detect near-end
    enable_cleanup = "yes", -- Enable cleanup of old watch_later files (yes/no)
    cleanup_days = 90 -- Number of days before files are deleted
}

local state_dir = mp.command_native({"expand-path", "~~state/"})
local watch_later_dir = utils.join_path(state_dir, "watch_later")

-- ==============================
--  Helper Functions
-- ==============================

-- Function to load options from a .conf file
local function load_config()
    local home_dir = mp.command_native({"expand-path", "~~home/"})
    local conf_file = utils.join_path(home_dir, "remember_position.conf")
    local file = io.open(conf_file, "r")
    if file then
        for line in file:lines() do
            local key, value = line:match("^%s*(.-)%s*=%s*(.-)%s*$")
            if key and value and config[key] ~= nil then
                config[key] = tonumber(value) or value
            end
        end
        file:close()
    end
end

-- Function to log messages based on debug mode
local function log_debug(msg)
    if config.debug == "yes" then
        mp.msg.info(msg)
    end
end

-- Function to create a directory if it doesn't exist
local function create_directory(dir)
    local check_dir = os.rename(dir, dir)
    if check_dir == nil then
        os.execute("mkdir -p " .. dir)
        log_debug("Created directory: " .. dir)
    else
        log_debug("Directory already exists: " .. dir)
    end
end

-- Helper function to calculate the MD5 hash of the file path
local function calculate_md5_hash(path)
    local hash = md5.sumhexa(path)
    hash = string.upper(hash)
    return hash
end

-- Helper function to get file modification time
local function get_file_mod_time(file)
    local attr = utils.file_info(file)
    if attr then
        return attr.mtime
    else
        return nil
    end
end

-- ==============================
--  Main Logic Functions
-- ==============================

-- Function to clean up old files in the watch_later directory
local function cleanup_watch_later()
    if config.enable_cleanup == "yes" then
        local threshold_time = os.time() - (config.cleanup_days * 24 * 60 * 60)
        local removed_count = 0

        -- Iterate through files in the watch_later directory
        for file in utils.readdir(watch_later_dir) or {} do
            local file_path = utils.join_path(watch_later_dir, file)
            local mod_time = get_file_mod_time(file_path)

            if mod_time and mod_time < threshold_time then
                os.remove(file_path)
                removed_count = removed_count + 1
                log_debug("Removed old file: " .. file_path)
            end
        end

        log_debug("Cleanup completed. Removed " .. removed_count .. " files.")
    else
        log_debug("Cleanup is disabled.")
    end
end

-- Function to save position to a file
local function save_position()
    local path = mp.get_property("path")
    local time = mp.get_property_number("time-pos", 0)
    local sub_pos = mp.get_property_number("sub-pos", 0)

    if path then
        local hash = calculate_md5_hash(path)
        local position_file = utils.join_path(watch_later_dir, hash)

        local file = io.open(position_file, "w")
        if file then
            if mp.get_property_bool("write-filename-in-watch-later-config", false) then
                file:write("# " .. path .. "\n")
            end
            file:write("start=" .. time .. "\n")
            if sub_pos > 0 then
                file:write("sub-pos=" .. sub_pos .. "\n")
            end
            file:close()
            log_debug("Saved position for " .. path .. ": " .. time)
        else
            log_debug("Failed to save position for " .. path)
        end
    else
        log_debug("No valid path to save position.")
    end
end

-- Function to check if playback is near the end
local function check_near_end()
    if config.restart_on_end == "yes" then
        local time = mp.get_property_number("time-pos", 0)
        local length = mp.get_property_number("duration", 0)

        if length > 0 and (length - time) <= config.fuzz_amount then
            log_debug("Near end detected. Restarting video.")
            mp.set_property("time-pos", 0) -- Restart from the beginning
        else
            log_debug("Playback not near end; no action taken.")
        end
    end
end

-- Save position periodically
local function periodic_save()
    if config.disable_periodic_save == "no" then
        save_position()
    else
        log_debug("Periodic save is disabled.")
    end
end

-- ==============================
--  Initialization
-- ==============================

-- Load user configuration
load_config()

-- Create the watch_later directory if it doesn't exist
create_directory(watch_later_dir)

-- Register event to check near-end on file load (not on seeking)
mp.register_event("file-loaded", check_near_end)

-- Register event to save position when playback is restarted
mp.register_event("playback-restart", save_position)

-- Add periodic timer for saving position
mp.add_periodic_timer(tonumber(config.timer_interval), periodic_save)

-- Cleanup old files in the watch_later directory on MPV shutdown
mp.register_event("shutdown", cleanup_watch_later)
