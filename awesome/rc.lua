-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

local gears = require("gears")
local beautiful = require("beautiful")

beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
require("modules.error")
require("modules.layout")
require("modules.wibar")
require("modules.bindings")
require("modules.rules")
require("modules.signals")

-- Gaps
beautiful.useless_gap = 5

-- Autostart
awful.spawn.with_shell("picom")
