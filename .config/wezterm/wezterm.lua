local wezterm = require("wezterm")
return {
	font                      = wezterm.font("FiraCode Nerd Font",{weight="Regular",italic=false}),
	window_background_opacity = 0.7,
	default_cursor_style      = "BlinkingBar",
	exit_behavior             = "Close",
	enable_tab_bar            = false,
	
	window_padding = {
		left = 10,
		right = 10,
		top = 10,
		bottom = 3,
	},
	
	colors={
		foreground    = "#d0d0d0",
		background    = "#000000",
		cursor_bg     = "#ffffff",
		cursor_border = "#d0d0d0",
		selection_fg  = "#000000",
		selection_bg  = "#ffffff",

		-- Slightly modified Isotope dark
		--          Black      Red        Green      Yellow     Blue       Purple     Cyan       White
		ansi    = {"#000000", "#ee0000", "#22ee00", "#ee0088", "#0055ee", "#bb00ee", "#00eeee", "#d0d0d0"},
		brights = {"#808080", "#ff0000", "#33ff00", "#ff0099", "#0066ff", "#cc00ff", "#00ffff", "#ffffff"}
	}
}
