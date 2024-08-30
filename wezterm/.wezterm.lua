-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = {}

-- This is where you actually apply your config choices
config.default_prog = { "pwsh" }
config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 16
config.color_scheme = "Catppuccin Mocha"

-- and finally, return the configuration to wezterm
return config
