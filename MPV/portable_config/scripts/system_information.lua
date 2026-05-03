local mp = require 'mp'
local utils = require 'mp.utils'

--  Global Configurations

local display_duration = 5
local old_align_x = mp.get_property("osd-align-x")
local old_align_y = mp.get_property("osd-align-y")
local old_margin_y = mp.get_property("osd-margin-y")

--  Helper Functions

local function reset_osd_position()
    mp.set_property("osd-align-x", old_align_x)
    mp.set_property("osd-align-y", old_align_y)
    mp.set_property_number("osd-margin-y", old_margin_y)
end

local function set_osd_position()
    mp.set_property("osd-align-x", "right")
    mp.set_property("osd-align-y", "top")
    mp.set_property_number("osd-margin-y", 50)
end

local function os_name()
    return package.config:sub(1, 1) == '\\' and "windows" or "unix"
end

--  Date Time Functions

local function get_datetime()
    local date = os.date("%a, %d %B %y")
    local time = os.date("%I:%M %p")

    return date, time
end

--  Battery Info Functions

local function get_battery_windows()
    local command = utils.subprocess({
        args = {"cmd", "/C", "WMIC PATH Win32_Battery Get EstimatedChargeRemaining,BatteryStatus /FORMAT:LIST"},
        cancellable = false
    })

    local state = "Unknown"
    local percent = command.stdout:match("EstimatedChargeRemaining=(%d+)")
    local status = command.stdout:match("BatteryStatus=(%d+)")

    if status == "1" then
        state = "Discharging"
    elseif status == "2" then
        state = "Charging"
    end

    return percent, state
end

local function get_battery_linux()
    local base_path = "/sys/class/power_supply/"

    for _, directory in ipairs(utils.readdir(base_path) or {}) do
        local battery_directory = base_path .. directory
        local capacity = utils.file_info(battery_directory .. "/capacity")
        local state = utils.file_info(battery_directory .. "/status")

        if capacity and state then
            local percent = io.open(battery_directory .. "/capacity", "r"):read("*l")
            local state = io.open(battery_directory .. "/status", "r"):read("*l")
            return tonumber(percent), state
        end
    end

    return nil, nil
end

-- Main Function

local function main()
    local date, time, percent, state, battery

    date, time = get_datetime()

    if os_name() == "windows" then
        percent, state = get_battery_windows()
    else
        percent, state = get_battery_linux()
    end

    if percent then
        battery = percent .. "% (" .. state .. ")"
    else
        battery = "Battery Info Unavailable"
    end

    local system_information = date .. "\n" .. time .. "\n" .. battery
    set_osd_position()

    mp.osd_message(system_information, display_duration)

    mp.add_timeout(display_duration + 1, reset_osd_position)
end

mp.add_key_binding("Ctrl+i", "show-system-info", main)
