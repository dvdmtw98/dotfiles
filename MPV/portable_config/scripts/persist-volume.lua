local utils = require 'mp.utils'

local state_dir = mp.command_native({ "expand-path", "~~state/" })
local config_path = utils.join_path(state_dir, "volume.conf")

local DEFAULT_VOLUME = 75
local debug_enabled = true

local saving_enabled = false
local first_volume_notification = true
local load_generation = 0


-- Debug logging
local function debug_log(message)
    if not debug_enabled then
        return
    end

    local log_path = utils.join_path(state_dir, "mpv_volume_debug.log")

    local file = io.open(log_path, "a")
    if file then
        file:write(message .. "\n")
        file:close()
    end
end


-- Read the global volume from volume.conf
local function read_volume()
    local file, err = io.open(config_path, "r")

    if not file then
        debug_log("Could not read volume.conf: " .. tostring(err))
        return nil
    end

    local contents = file:read("*all")
    file:close()

    local volume = tonumber(contents)

    if volume ~= nil and volume >= 0 then
        debug_log("Read saved volume: " .. tostring(volume))
        return volume
    end

    debug_log("Volume config is missing a valid number.")
    return nil
end


-- Write the global volume to volume.conf
local function save_volume(volume)
    if type(volume) ~= "number" then
        return false
    end

    local file, err = io.open(config_path, "w")

    if not file then
        debug_log("Failed to write volume.conf: " .. tostring(err))
        return false
    end

    local ok, write_err = file:write(tostring(volume), "\n")
    local close_ok, close_err = file:close()

    if not ok then
        debug_log("Volume write failed: " .. tostring(write_err))
        return false
    end

    if not close_ok then
        debug_log("Volume file close failed: " .. tostring(close_err))
        return false
    end

    debug_log("Saved volume: " .. tostring(volume))
    return true
end


-- Obtain the authoritative volume, using 75% as the fallback.
local function get_saved_or_default_volume()
    local volume = read_volume()

    if volume == nil then
        volume = DEFAULT_VOLUME
        debug_log("Using fallback volume: 75%")
    end

    return volume
end


-- Apply the global volume when a video finishes loading.
mp.register_event("file-loaded", function()
    local generation = load_generation
    saving_enabled = false

    local volume = get_saved_or_default_volume()

    mp.set_property_number("volume", volume)
    save_volume(volume)

    debug_log(
        "Applied volume after file-loaded: "
        .. tostring(volume)
    )

    -- Reapply after a short delay to override any per-file
    -- volume restoration that occurs during loading.
    mp.add_timeout(0.3, function()
        if generation ~= load_generation then
            return
        end

        local latest_volume = get_saved_or_default_volume()

        mp.set_property_number("volume", latest_volume)
        save_volume(latest_volume)

        saving_enabled = true

        debug_log("Volume enforcement complete: " .. tostring(latest_volume)
        )
    end)
end)


-- Disable saving while another video is loading.
mp.register_event("start-file", function()
    load_generation = load_generation + 1
    saving_enabled = false

    debug_log("New file starting; volume saving paused.")
end)


-- Save manual volume changes during normal playback.
mp.observe_property("volume", "number", function(_, volume)
    -- Ignore the observer's initial notification.
    if first_volume_notification then
        first_volume_notification = false
        return
    end

    -- Do not save temporary values during file loading.
    if not saving_enabled then
        return
    end

    if type(volume) == "number" then
        save_volume(volume)
    end
end)


-- Save the final volume when MPV exits.
mp.register_event("shutdown", function()
    if not saving_enabled then
        return
    end

    local volume = mp.get_property_number("volume")

    if volume ~= nil then
        save_volume(volume)
    end
end)
