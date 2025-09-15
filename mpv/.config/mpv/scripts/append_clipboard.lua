local mp = require 'mp'
local utils = require 'mp.utils'

-- function to get clipboard text
local function get_clipboard()
    -- try wl-paste (Wayland)
    local res = utils.subprocess({ args = { "wl-paste", "-n" }, cancellable = false })
    if res.status == 0 and res.stdout ~= "" then
        return res.stdout:gsub("%s+$", "")
    end

    -- try xclip (X11)
    res = utils.subprocess({ args = { "xclip", "-selection", "clipboard", "-o" }, cancellable = false })
    if res.status == 0 and res.stdout ~= "" then
        return res.stdout:gsub("%s+$", "")
    end

    return nil
end

local function append_from_clipboard()
    local clip = get_clipboard()
    if not clip then
        mp.osd_message("Clipboard empty or unavailable")
        return
    end
    mp.commandv("loadfile", clip, "append-play")
    mp.osd_message("Queued: " .. clip)
end

-- expose to input.conf
mp.add_key_binding(nil, "append-clipboard", append_from_clipboard)

