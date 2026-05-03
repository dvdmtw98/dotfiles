local function reset_all()
    mp.command("set brightness 0")
    mp.command("set contrast 0")
    mp.command("set gamma 0")
    mp.command("set saturation 0")
    -- Move Video Location
    mp.command("set video-pan-x 0")
    mp.command("set video-pan-y 0")
    -- Video Zoom
    mp.command("set video-zoom 0")
    mp.command("set panscan 0")
    
    mp.osd_message("Video Settings Reset")
end

mp.add_key_binding("r", "reset-all", reset_all)
