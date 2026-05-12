-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,
		border_size = 3,
		gaps_workspaces = 15,
		col = {
			active_border = "rgba(b4befeff)",
			inactive_border = "rgba(16161dff)",
		},
		resize_on_border = true,
		resize_corner = false,
		allow_tearing = false,
	},

	decoration = {
		rounding = 5,
		active_opacity = 1.0,
		inactive_opacity = 0.95,
		fullscreen_opacity = 1,
		dim_inactive = false,
		dim_strength = 0.15,
		shadow = {
			enabled = false,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},
		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},
})
