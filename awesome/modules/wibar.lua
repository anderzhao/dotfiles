local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local menubar = require("menubar")
local beautiful = require("beautiful")
local constants = require("modules.constants")

editor_cmd = constants.editor_cmd

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

        local unfocus_icon = ""
	local unfocus_color = "#585b70"

	local empty_icon = "\f"
	local empty_color = "#585b70"

	local focus_icon = ""
	local focus_color = "#b4befe"

	local update_tags = function(self, c3)
		local tagicon = self:get_children_by_id('icon_role')[1]
		if c3.selected then
			tagicon.text = focus_icon
			self.fg = focus_color
		elseif #c3:clients() == 0 then
			tagicon.text = empty_icon
			self.fg = empty_color
		else
			tagicon.text = unfocus_icon
			self.fg = unfocus_color
		end
	end
      
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
	widget_template = {
	   {
	      {
		 id = 'icon_role',
		 font = "Font Awesome 5 Font 12",
		 widget = wibox.widget.textbox
	      },
	      id = 'margin_role',
	      top = 0,
	      bottom = 0,
	      left = 2,
	      right = 2,
	      widget = wibox.container.margin
	   },
	   id = 'background_role',
	   widget = wibox.container.background,

	   create_callback = function(self, c3, index, objects)
		update_tags(self, c3)
	   end,

	   update_callback = function(self, c3, index, objects)
	        update_tags(self, c3)
	   end
	},
	
    }

    -- Create the wibox
    s.wibox = awful.wibar(
        { 
            position = "top",
            screen = s,
            -- height = beautiful.bar_height,
	    height = 16,
            type = "dock",
		    bg = "#000000",

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
