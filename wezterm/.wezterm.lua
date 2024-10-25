-- Pull in the wezterm API
local wezterm = require "wezterm"

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_scheme = "Dracula (Official)"
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.font_size = 10.0

-- and finally, return the configuration to wezterm
return config
