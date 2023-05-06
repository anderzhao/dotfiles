local init = require("modules.init")

local awful = init.awful
local gears = init.gears
local beautiful = init.beautiful

client.connect_signal("manage", function(c)
    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

client.connect_signal("property::fullscreen", function(c)
    if c.fullscreen then
        c.shape = gears.shape.rectangle
    else
        c.shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, 15)
        end
    end
end)

-- beautiful.useless_gap = 4