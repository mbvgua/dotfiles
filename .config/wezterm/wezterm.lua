-- pull the wezterm API
local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- not using it as a multiplexer anymore. Tmux for the win!
config.enable_tab_bar = false
-- config.tab_bar_at_bottom = true
-- config.use_fancy_tab_bar = false

config.font_size = 14 -- increase font size. My eyes!!!
config.color_scheme = "Monokai (base16)"
-- remove uneccessary padding on window. More RealEstate!
config.window_padding = {
	left = 2,
	right = 2,
	top = 0,
	bottom = 0,
}

-- return the configuration to wezterm for changes to work on save
return config
