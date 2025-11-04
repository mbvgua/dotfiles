-- pull the wezterm API
local wezterm = require("wezterm")
local appearance = require("appearance")
local projects = require("projects")

local config = wezterm.config_builder()
local act = wezterm.action

-- ############################### --
-- general
-- ############################### --

-- set the leader key
config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 3000 }

-- show when leader key is active
wezterm.on("update-right-status", function(window, _)
	local SOLID_LEFT_ARROW = ""
	local ARROW_FOREGROUND = { Foreground = { Color = "#c6a0f6" } }
	local prefix = ""

	if window:leader_is_active() then
		prefix = " " .. utf8.char(0x1F3A9) -- utf8 unicode for the mad hatter!!
		SOLID_LEFT_ARROW = utf8.char(0xe0b2)
	end

	if window:active_tab():tab_id() ~= 1 then
		ARROW_FOREGROUND = { Foreground = { Color = "#1e2030" } }
	end -- arrow color based on if tab is first pane

	window:set_left_status(wezterm.format({
		{ Background = { Color = "#b7bdf8" } },
		{ Text = prefix },
		ARROW_FOREGROUND,
		{ Text = SOLID_LEFT_ARROW },
	}))
end)

-- moving between panes
local function move_pane(key, direction)
	return {
		key = key,
		mods = "LEADER",
		action = act.ActivatePaneDirection(direction),
	}
end

-- resizing panes
local function resize_pane(key, direction, size)
	return {
		key = key,
		mods = "ALT",
		action = act.AdjustPaneSize({ direction, size }),
	}
end

config.keys = {
	-- create pane horizontally with \, wanted to use the | without shift
	{ key = "\\", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	-- create pane vertically
	{ key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	-- rotate through panes
	{ key = "r", mods = "ALT", action = act.RotatePanes("Clockwise") },
	-- move through panes like vim{h,j,k,l}
	move_pane("k", "Up"),
	move_pane("j", "Down"),
	move_pane("l", "Right"),
	move_pane("h", "Left"),
	-- change pane sizes{Up,Down,Right,Left}
	resize_pane("UpArrow", "Up", 5),
	resize_pane("DownArrow", "Down", 5),
	resize_pane("RightArrow", "Right", 5),
	resize_pane("LeftArrow", "Left", 5),
	-- close pane
	{ key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = false }) },
	-- create new tab
	{ key = "t", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	-- cycle tabs
	{ key = "l", mods = "ALT", action = act.ActivateTabRelative(1) },
	{ key = "h", mods = "ALT", action = act.ActivateTabRelative(-1) },
	-- close tab
	{ key = "w", mods = "LEADER", action = act.CloseCurrentTab({ confirm = true }) },
	-- cycling through projects
	{ key = "p", mods = "LEADER", action = projects.choose_project() },
	-- Present a list of existing workspaces
	{ key = "f", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
}

-- cycle through tabs
for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = act.ActivateTab(i - 1),
	})
end

-- ############################### --
-- themes & layout
-- ############################### --

config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.font_size = 13.3 -- increase font size. My eyes!!!
config.window_background_opacity = 0.85

-- set appearance
if appearance.is_dark() then
	config.color_scheme = "Kibble (Gogh)"
else
	config.color_scheme = "lovelace"
end

-- remove uneccessary padding on window.
-- no scrollbar, since its set 0 to the left and right. More RealEstate!
-- also real hackers don't use scrollbars for navigation!
config.window_padding = {
	left = 4,
	right = 2,
	top = 0,
	bottom = 0,
}

-- return the configuration to wezterm for changes to work on save
-- if not, use Ctrl+Shift+R to force reload
return config
