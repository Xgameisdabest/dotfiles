-- transition to hyprland.lua

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
local home = os.getenv("HOME")
-- Basic Apps & Rendering
hl.env("TERMINAL", "kitty")
hl.env("WLR_RENDERER", "vulkan")
-- Path & Custom Paths
-- We concatenate strings in Lua using '..'
hl.env("PATH", home .. "/.local/bin:" .. os.getenv("PATH"))
hl.env("CUSTOM_SOUND_PATH", home .. "/.config/dunst/scripts/sounds/")
hl.env("XDG_DATA_DIRS", home .. "/.local/share/flatpak/exports/share:" .. (os.getenv("XDG_DATA_DIRS") or ""))
-- Cursors
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("XCURSOR_SIZE", "24")
-- Firefox (Wayland)
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("MOZ_USE_XINPUT2", "1")
hl.env("MOZ_DISABLE_RDD_SANDBOX", "1")
-- Toolkit Backends
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")
-- Input Methods (fcitx)
hl.env("SDK_IM_MODULE", "fcitx")
hl.env("QT_IM_MODULE", "fcitx")
hl.env("XMODIFIERS", "@im,fcitx")
-- QT Settings
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_CURSOR_THEME", "Bibata-Modern-Ice")
hl.env("QT_CURSOR_SIZE", "24")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
	hl.exec_cmd("systemctl --user stop betterlockscreen@$USER.service")
	hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 24")
	-- Polkit agent, required for graphical apps
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	-- Init the notification daemon
	hl.exec_cmd("dunst")
	-- Usb media notification daemon
	hl.exec_cmd("~/.config/dunst/scripts/usb-watch.sh")
	-- Plug, unplug power source daemon
	hl.exec_cmd("~/.config/dunst/scripts/bat-status-daemon.sh")
	-- Battery low notification daemon
	hl.exec_cmd("~/.config/dunst/scripts/battery-warning.sh")
	-- Notifications
	hl.exec_cmd("~/.config/dunst/volume.sh volume_status")
	hl.exec_cmd("~/.config/dunst/volume.sh brightness_status")
	hl.exec_cmd("~/.config/dunst/bat_status.sh status")
	-- Welcome message
	hl.exec_cmd("~/.config/dunst/scripts/welcome-notif.sh")
	-- Helpful startup tips
	hl.exec_cmd('notify-send -t 2500 "Press 󰖳 + = to open the keybind menu!"')
	hl.exec_cmd('notify-send -t 2500 "Press 󰖳 + i to open the settings menu!"')
	-- Wallpapers
	hl.exec_cmd("waypaper --restore")
	-- KDE Connect daemon
	hl.exec_cmd("kdeconnectd")
	-- Logitech app
	hl.exec_cmd("solaar --window=hide")
	-- Input method
	hl.exec_cmd("fcitx5 -d")
	-- Protonvpn fix if stayed connect after logout and relogin into Hyprland session
	hl.exec_cmd("~/.config/hypr/scripts/protonvpn_check_when_resume.sh")
end)

-----------------------
----- PERMISSIONS -----
-----------------------
hl.config({
	ecosystem = {
		enforce_permissions = true,
	},
})

hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

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

--------------------
---- ANIMATIONS ----
--------------------

hl.config({
	animations = {
		enabled = true,
	},
})

-- Beziers: hl.curve( NAME, { type = "bezier", points = { {X0, Y0}, {X1, Y1} } })
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })
hl.curve("bouncy", { type = "bezier", points = { { 0.05, 0.93 }, { 0.1, 1.03 } } })
hl.curve("fade", { type = "bezier", points = { { 0.65, 0.05 }, { 0.4, 0.6 } } })
hl.curve("default", { type = "bezier", points = { { 0.12, 0.92 }, { 0.08, 1 } } })
hl.curve("overshot", { type = "bezier", points = { { 0.18, 0.95 }, { 0.22, 1.03 } } })
hl.curve("popin", { type = "bezier", points = { { 0, 1.3 }, { 1, 1 } } })
hl.curve("smoothResize", { type = "bezier", points = { { 0, 0 }, { 0, 1.28 } } })

-- hl.animation({ leaf = STRING, enabled = BOOL, speed = FLOAT, curve = STRING, style = STRING })
-- Fading
hl.animation({ leaf = "fade", enabled = true, speed = 1.9, curve = "default" })
-- Windows
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4, curve = "popin", style = "popin 80%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 4, curve = "popin", style = "popin 80%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 3, curve = "smoothResize" })
-- Workspaces
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, curve = "overshot", style = "slide" })
-- Borders
hl.animation({ leaf = "border", enabled = true, speed = 1, curve = "linear" })
hl.animation({ leaf = "borderangle", enabled = false })

----------------
---- LAYOUT ----
----------------
hl.config({
	dwindle = {
		force_split = 2,
		preserve_split = true,
		smart_split = false,
		smart_resizing = true,
		precise_mouse_move = true,
	},

	master = {
		new_status = "master",
	},

	scrolling = {
		fullscreen_on_one_column = true,
	},
})

--------------------------------
----  MISC RENDER ECOSYSTEM ----
--------------------------------

hl.config({
	misc = {
		force_default_wallpaper = 0,
		vrr = 1,
		enable_anr_dialog = true,
		disable_autoreload = true,
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		animate_manual_resizes = false,
		animate_mouse_windowdragging = false,
		mouse_move_enables_dpms = true,
		key_press_enables_dpms = true,
		allow_session_lock_restore = 1,
	},
})

-- Im here

---------------
---- INPUT ----
---------------

hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",

		follow_mouse = 1,

		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

		touchpad = {
			natural_scroll = false,
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
local closeWindowBind = hl.bind(mainMod .. " + C", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(
	mainMod .. " + M",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

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
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },

	move = "20 monitor_h-120",
	float = true,
})
