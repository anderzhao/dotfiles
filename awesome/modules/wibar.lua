local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local menubar = require("menubar")
local beautiful = require("beautiful")
local constants = require("modules.constants")

editor_cmd = constants.editor_cmd

-- {{{ Menu
-- Create a launcher widget and a main menu
awesomemenu = {
    { "edit config", editor_cmd .. " " .. awesome.conffile },
    { "quit", function() awesome.quit() end },
 }

mainmenu = awful.menu({ items = { { "awesome", awesomemenu, beautiful.awesome_icon },
                                   { "open terminal", terminal }
                                 }
                        })

launcher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                    menu = mainmenu })

 -- Menubar configuration
 menubar.utils.terminal = constants.terminal -- Set the terminal for applications that require it
 -- }}}

-- {{{ Wibar

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a taglist widget
    s.taglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        layout = {
            layout = wibox.layout.fixed.horizontal,
            spacing = beautiful.spacing,
        },
        style = {
            shape = gears.shape.circle
        }
    }

    -- Create the wibox
    s.wibox = awful.wibar(
        { 
            position = "top",
            screen = s,
            height = beautiful.bar_height,
            type = "dock",
		    bg = "#00000000",

        })

    -- Add widgets to the wibox
    s.wibox:setup({
		{
			layout = wibox.layout.stack,
			{
				layout = wibox.layout.align.horizontal,
				{ -- Left widgets
					layout = wibox.layout.fixed.horizontal,
					s.taglist,
				},
				nil,
				{ -- Right widgets
					layout = wibox.layout.fixed.horizontal,
					spacing = beautiful.spacing,
					wibox.widget.systray(),
					wibox.widget.textclock()
				},
				widget = wibox.container.margin,
			}
		},
		left = beautiful.useless_gap * 2,
		right = beautiful.useless_gap * 2,
		top = beautiful.useless_gap * 2,
		widget = wibox.container.margin,
	})
end)
-- }}}
