pcall(require, "luarocks.loader")

local _M = {}

_M.gears = require("gears")
_M.awful = require("awful")
_M.naughty = require("naughty")
_M.beautiful = require("beautiful")

_M.root = _G.root
_M.screen = _G.screen
_M.client = _G.client
_M.awesome = _G.awesome

_M.terminal = "alacritty"
_M.editor = "emacs"
_M.editor_cmd = _M.terminal .. " -e " .. _M.editor
_M.keys = {
	mod = "Mod4",
	sup = "Shift",
	ctl = "Control",
}

return _M