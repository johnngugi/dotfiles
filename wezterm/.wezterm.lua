-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
-- config.default_prog = { "pwsh" }
config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 18
config.color_scheme = "Catppuccin Mocha"

config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = {
	{
		key = "c",
		mods = "LEADER",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "x",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		key = "p",
		mods = "LEADER",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		key = "n",
		mods = "LEADER",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		key = "|",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "-",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "h",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "k",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		key = "LeftArrow",
		mods = "LEADER",
		action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "RightArrow",
		mods = "LEADER",
		action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
	},
	{
		key = "DownArrow",
		mods = "LEADER",
		action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
	},
	{
		key = "UpArrow",
		mods = "LEADER",
		action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
	},
	{
		key = "w",
		mods = "LEADER",
		action = wezterm.action.ShowTabNavigator,
	},
	{
		key = "W",
		mods = "LEADER",
		action = wezterm.action.ShowLauncher,
	},
}

for i = 0, 8 do
	-- leader + number to activate that tab
	table.insert(config.keys, {
		key = tostring(i + 1),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i),
	})
end

-- tab bar
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false

-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

---@diagnostic disable-next-line: unused-local
wezterm.on("format-tab-title", function(tab, tabs, panes, conf, hover, max_width)
	local pane = tab.active_pane
	local cwd = pane.current_working_dir

	local title
	if not cwd then
		title = tab.tab_title
	else
		title = tab.tab_index + 1 .. " " .. basename(cwd.path)
	end

	return {
		{ Text = " " .. title .. " " },
	}
end)
-- and finally, return the configuration to wezterm
return config
