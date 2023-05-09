pcall(require, "luarocks.loader")

local _M = {}

_M.root = require("root")
_M.gears = require("gears")
_M.awful = require("awful")
_M.awesome = require("awesome")
_M.naughty = require("naughty")
_M.beautiful = require("beautiful")
_M.screen = _M.awful.screen
_M.client = _M.awful.client

_M.terminal = "alacritty"
_M.editor = "emacs"
_M.editor_cmd = _M.terminal .. " -e " .. _M.editor
_M.keys = {
	mod = "Mod4",
	sup = "Shift",
	ctl = "Control",
}

return _M