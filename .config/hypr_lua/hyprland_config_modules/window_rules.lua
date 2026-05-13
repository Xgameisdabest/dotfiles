--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- Layer rules also return a handle.
local overlayLayerRule = hl.layer_rule({
	name = "no-anim-overlay",
	match = { namespace = "^my-overlay$" },
	no_anim = true,
})
overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },

	move = "20 monitor_h-120",
	float = true,
})

-- Rofi
hl.window_rule({
	name = "rofi",
	match = { class = "Rofi" },
	stay_focused = true,
	float = true,
	pin = true,
})

-- Steam
hl.window_rule({
	match = { class = "^(steam)$", title = "^()$"},
	min_size = {1,1},
	stay_focused = true,
})

-- idle inhibit classes
local idle_inhibit_classes = {
	"^(.*celluloid.*)$",
	"^(.*mpv.*)$",
	"^(.*vlc.*)$",
	"^(.*[Ss]potify.*)$",
	"^(.*LibreWolf.*)$",
	"^(.*floorp.*)$",
	"^(.*brave-browser.*)$",
	"^(.*firefox.*)$",
	"^(.*chromium.*)$",
	"^(.*zen.*)$",
	"^(.*vivaldi.*)$",
}

-- Float windows based on windows' classes
local float_classes = {
	"^(wdisplays)$",
	"^(vlc)$",
	"^(solaar)$",
	"^(kvantummanager)$",
	"^(qt5ct)$",
	"^(qt6ct)$",
	"^(nwg-look)$",
	"^(org.kde.ark)$",
	"^(org.pulseaudio.pavucontrol)$",
	"^(blueman-manager)$",
	"^(nm-applet)$",
	"^(nm-connection-editor)$",
	"^(org.kde.polkit-kde-authentication-agent-1)$",
	"^([Xx]dg-desktop-portal-gtk)$",
	"^(.*dialog.*)$",
}

-- Float windows based on title
local float_titles = {
	"^(Open)$",
	"^(Authentication Required)$",
	"^(Add Folder to Workspace)$",
	"^(Open File)$",
	"^(Choose Files)$",
	"^(Save As)$",
	"^(Confirm to replace files)$",
	"^(File Operation Progress)$",
	"^(File Upload)(.*)$",
	"^(Choose wallpaper)(.*)$",
	"^(Library)(.*)$",
	"^(.*dialog.*)$",
}

-- Fullscreen
local fullscreen_titles = {
	"^SuperTuxKart$",
	"^Waydroid$",
}

-- Apply rules for Classes
for _, class_pattern in ipairs(float_classes) do
	hl.window_rule({
		name = "float_by_class",
		match = { class = class_pattern },
		float = true,
	})
end

-- Apply rules for Titles
for _, title_pattern in ipairs(float_titles) do
	hl.window_rule({
		name = "float_by_title",
		match = { title = title_pattern },
		float = true,
	})
end

-- Apply rules for inhibit idle
for _, class_pattern in ipairs(idle_inhibit_classes) do
	hl.window_rule({
		name = "inhibit_idle",
		match = { class = class_pattern },
		idle_inhibit = "fullscreen",
	})
end

-- Apply rules for Fullscreen
for _, title_pattern in ipairs(fullscreen_titles) do
	hl.window_rule({
		name = "force_fullscreen",
		match = { title = title_pattern },
		fullscreen = true,
	})
end
