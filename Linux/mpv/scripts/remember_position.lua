local mp = require 'mp'
local utils = require 'mp.utils'
-- MD5 had to be manually installed on system
local md5 = require 'md5'

-- Directory where MPV stores `watch_later` files
local state_dir = mp.command_native({"expand-path", "~~state/"})
local watch_later_dir = utils.join_path(state_dir, "watch_later")

-- Function to create a directory if it doesn't exist
local function create_directory(dir)
    -- Check if the directory exists
    local check_dir = os.rename(dir, dir) -- Try to rename to check if it's valid
    if check_dir == nil then
        -- If it doesn't exist, create it
        os.execute("mkdir -p " .. dir)
        mp.msg.info("Created directory: " .. dir)
    else
        mp.msg.info("Directory already exists: " .. dir)
    end
end

-- Create the watch_later directory if it doesn't exist
create_directory(watch_later_dir)

-- Helper function to calculate the MD5 hash of the file path
local function calculate_md5_hash(path)
    -- Compute the MD5 hash of the file path
    local hash = md5.sumhexa(path)  -- Using md5 function to get a hash in hexadecimal format
    hash = string.upper(hash)
    return hash
end

-- Function to load the position from the saved state file
local function load_position()
    local path = mp.get_property("path")
    local hash = calculate_md5_hash(path)
    local position_file = utils.join_path(watch_later_dir, hash)

    -- Check if the position file exists
    local file = io.open(position_file, "r")
    if file then
        local lines = file:read("*a")
        file:close()

        -- Parse the position file contents
        for line in lines:gmatch("[^\r\n]+") do
            local start_pos, sub_pos = line:match("^start=(%S+)")
            if start_pos then
                -- Seek to the saved position
                mp.set_property("time-pos", tonumber(start_pos))
            end
            local sub_position = line:match("^sub%-pos=(%S+)")
            if sub_position then
                -- Seek to the subtitle position
                mp.set_property("sub-pos", tonumber(sub_position))
            end
        end
        mp.msg.info("Loaded position for " .. path)
    else
        mp.msg.warn("No saved position for " .. path)
    end
end

-- Function to save position to a file
local function save_position()
    local path = mp.get_property("path")
    local time = mp.get_property_number("time-pos", 0)
    local sub_pos = mp.get_property_number("sub-pos", 0)  -- Get subtitle position

    if path then
        -- Calculate the MD5 hash of the file path to create a unique file name
        local hash = calculate_md5_hash(path)
        local position_file = utils.join_path(watch_later_dir, hash)

        -- Open the position file for writing
        local file = io.open(position_file, "w")
        if file then
            -- Write the path (starting with #), start position, and subtitle position into the file
            -- file:write("# " .. path .. "\n")
            file:write("start=" .. time .. "\n")
            if sub_pos > 0 then
                file:write("sub-pos=" .. sub_pos .. "\n")
            end
            file:close()
            mp.msg.info("Saved position for " .. path .. ": " .. time)
        else
            mp.msg.warn("Failed to save position for " .. path)
        end
    else
        mp.msg.warn("No valid path to save position.")
    end
end

-- Register event to save position when playback is restarted or a new file is loaded
mp.register_event("playback-restart", save_position)

-- Load position when file is first loaded
-- mp.register_event("file-loaded", load_position)
