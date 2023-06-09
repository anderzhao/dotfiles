local init = require("modules.init")

local root = init.root
local awful = init.awful
local gears = init.gears
local client = init.client
local modkey = init.keys.mod
local awesome = init.awesome

local _M = {}

--- Global keys ---
_M.global_keys = gears.table.join(

    awful.key({ modkey }, "Left", awful.tag.viewprev),
    awful.key({ modkey }, "Right", awful.tag.viewnext),
    awful.key({ modkey }, "Escape", awful.tag.history.restore),
    awful.key({ modkey }, "j", function() awful.client.focus.byidx( 1) end),
    awful.key({ modkey }, "k", function() awful.client.focus.byidx(-1) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx( 1) end),
    awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end),
    awful.key({ modkey, "Control" }, "j", function() awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end),
    -- awful.key({ modkey }, "space", function () awful.layout.inc( 1) end),
    -- awful.key({ modkey, "Shift" }, "space", function () awful.layout.inc(-1) end),
    awful.key({ modkey }, "Tab", function()
        awful.client.focus.history.previous()
        if client.focus then
            client.focus:raise()
        end
    end),

    -- Standard program
    awful.key({ modkey }, "l", function() awful.tag.incmwfact( 0.05) end),
    awful.key({ modkey }, "h", function() awful.tag.incmwfact(-0.05) end),
    awful.key({ modkey, "Shift" }, "h", function() awful.tag.incnmaster( 1, nil, true) end),
    awful.key({ modkey, "Shift" }, "l", function() awful.tag.incnmaster(-1, nil, true) end),
    awful.key({ modkey, "Control" }, "h", function() awful.tag.incncol( 1, nil, true) end),
    awful.key({ modkey, "Control" }, "l", function() awful.tag.incncol(-1, nil, true) end),

    --- System controls ---
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift" }, "q", awesome.quit),
    -- awful.key({ modkey, "Shift" }, "s", function() awful.util.spawn("shutdown now") end),
    -- awful.key({ modkey, "Shift" }, "r", function() awful.util.spawn("reboot") end),

    --- Media ---
    awful.key({}, "XF86AudioRaiseVolume", function() awful.util.spawn("pactl set-sink-volume @DEFAULT_SINK@ +2%") end),
    awful.key({}, "XF86AudioLowerVolume", function() awful.util.spawn("pactl set-sink-volume @DEFAULT_SINK@ -2%") end),
    awful.key({}, "XF86AudioMute", function() awful.util.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle") end),
    awful.key({}, "XF86AudioPlay", function() awful.util.spawn("playerctl play-pause") end),
    awful.key({}, "XF86AudioNext", function() awful.util.spawn("playerctl next") end),
    awful.key({}, "XF86AudioPrev", function() awful.util.spawn("playerctl previous") end),

    --- Other ---
    awful.key({ modkey, "Control" }, "n", function ()
        local c = awful.client.restore()
        if c then
            c:emit_signal("request::activate", "key.unminimize", {raise = true})
        end
    end),

    --- Appplications ---
    awful.key({ modkey }, "Return", function() awful.spawn(init.terminal) end),
    awful.key({ modkey }, "r", function() awful.util.spawn("rofi -show drun") end),
    awful.key({ modkey }, "w", function() awful.util.spawn("rofi -show window") end),
    awful.key({ modkey }, "b", function() awful.util.spawn("firefox") end),
    awful.key({ modkey }, "e", function() awful.util.spawn("emacs") end),
    awful.key({ modkey }, "t", function() awful.util.spawn("telegram-desktop") end)
)

--- Client keys ---
_M.client_keys = gears.table.join(
    awful.key({ modkey }, "f", function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end),
    awful.key({ modkey }, "q", function(c) c:kill() end),
    awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle),
    awful.key({ modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey }, "o", function(c) c:move_to_screen() end),
    awful.key({ modkey }, "t", function(c) c.ontop = not c.ontop end),
    -- awful.key({ modkey }, "n", function (c) c.minimized = true end),
    awful.key({ modkey }, "m", function(c)
        c.maximized = not c.maximized
        c:raise()
    end),
    awful.key({ modkey, "Control" }, "m", function(c)
        c.maximized_vertical = not c.maximized_vertical
        c:raise()
    end),
    awful.key({ modkey, "Shift" }, "m", function(c)
        c.maximized_horizontal = not c.maximized_horizontal
        c:raise()
    end)
)

for i = 1, 9 do
    _M.global_keys = gears.table.join(_M.global_keys,
        awful.key({ modkey }, "#" .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
                tag:view_only()
            end
        end),
        awful.key({ modkey, "Control" }, "#" .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end)
    )
end

_M.client_buttons = gears.table.join(
    awful.button({ }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

--- set keys ---
root.keys(_M.global_keys)

--- set mouse ---
root.buttons(gears.table.join(
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

return _M
