local gfs = require("gears.filesystem")

local _M = {}

_M.terminal = "alacritty"
_M.editor = "emacs"
_M.editor_cmd = _M.terminal .. " -e " .. _M.editor
_M.mods = {
	m = "Mod4",
	s = "Shift",
	c = "Control",
}
_M.wallpapers = gfs.get_configuration_dir() .. "../wallpapers/"

return _M