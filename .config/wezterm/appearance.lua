-- We almost always start by importing the wezterm module
local wezterm = require("wezterm")

local module = {}
function module.is_dark()
	-- return true if wezterm.gui is not defined
	if wezterm.gui then
		return wezterm.gui.get_appearance():find("Dark")
	end
	return true
end

return module
