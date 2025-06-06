-- pull the wezterm API
local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- ############################### --
-- keybindings --
-- ############################### --

-- set the leader key to match my tmux config
config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 3000 }

-- common functionalities ill need:
config.keys = {
	-- create pane horizontally with \, wanted to use the | without shift
	-- but dont know how to set it up here :(
	{
		key = "\\",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	-- create pane vertically
	{
		key = "-",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	-- rotate through panes
	{
		key = "r",
		mods = "ALT",
		-- only set clockwise. same difference to anti-*
		action = wezterm.action.RotatePanes("Clockwise"),
	},
	-- move through panes like vim{h,j,k,l}
	{
		mods = "LEADER",
		key = "h",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		mods = "LEADER",
		key = "j",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		mods = "LEADER",
		key = "k",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		mods = "LEADER",
		key = "l",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	-- change pane sizes{Up,Down,Right,Left}
	{
		mods = "ALT",
		key = "LeftArrow",
		action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
	},
	{
		mods = "ALT",
		key = "RightArrow",
		action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
	},
	{
		mods = "ALT",
		key = "DownArrow",
		action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
	},
	{
		mods = "ALT",
		key = "UpArrow",
		action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
	},
	-- create tab in same domain as current window
	{
		key = "t",
		mods = "LEADER",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	-- close tab
	{
		key = "c",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentTab({ confirm = true }),
	},
}

-- cycle through tabs
for i = 0, 9 do
	-- leader + number to activate that tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i),
	})
end

-- show when leader key is active
wezterm.on("update-right-status", function(window, _)
	local SOLID_LEFT_ARROW = ""
	local ARROW_FOREGROUND = { Foreground = { Color = "#c6a0f6" } }
	local prefix = ""

	if window:leader_is_active() then
		prefix = " " .. utf8.char(0x1F3A9) -- utf8 unicode for the mad hatter!!
		SOLID_LEFT_ARROW = utf8.char(0xe0b2)
	end

	if window:active_tab():tab_id() ~= 0 then
		ARROW_FOREGROUND = { Foreground = { Color = "#1e2030" } }
	end -- arrow color based on if tab is first pane

	window:set_left_status(wezterm.format({
		{ Background = { Color = "#b7bdf8" } },
		{ Text = prefix },
		ARROW_FOREGROUND,
		{ Text = SOLID_LEFT_ARROW },
	}))
end)

-- ############################### --
-- fonts,themes,layout and colours
-- ############################### --

config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true

-- increase font size. My eyes!!!
config.font_size = 16

-- the OG colour scheme
config.color_scheme = "Kibble (Gogh)"
-- remove uneccessary padding on window.
-- no scrollbar, since its set 0 to the left and right. More RealEstate!
-- also real hackers don't use scrollbars for navigation!
config.window_padding = {
	left = 4,
	right = 4,
	top = 0,
	bottom = 0,
}

-- return the configuration to wezterm for changes to work on save
-- if not, use Ctrl+Shift+R to force reload
return config
