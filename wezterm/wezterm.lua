local wezterm = require("wezterm")
local config = {}

config.keys = {
	{
		key = "d",
		mods = "ALT",
		action = wezterm.action.SplitPane({
			direction = "Down",

			size = { Percent = 40 },
		}),
	},
	{
		key = "j",
		mods = "ALT",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},

	{
		key = "k",
		mods = "ALT",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
}

-- Resto de tu config...
config.color_scheme = "Kanagawa (Gogh)"
config.window_padding = { bottom = 0, top = 0, right = 0, left = 0 }

config.font = wezterm.font("JetBrainsMono Nerd Font")

config.hide_tab_bar_if_only_one_tab = true
config.max_fps = 240
config.enable_kitty_graphics = true
config.win32_system_backdrop = "Acrylic"
config.macos_window_background_blur = 20
config.window_background_opacity = 0.85
config.font_size = 16.5
config.enable_scroll_bar = false

return config
