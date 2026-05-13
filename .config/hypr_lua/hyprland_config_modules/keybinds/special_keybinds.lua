local mod = "SUPER"
local alt = "ALT"
local home = os.getenv("HOME")

------------------------------
---- Special Key keybinds ----
------------------------------

-- Caps lock and numlock bind
hl.bind("Caps_Lock", hl.dsp.exec_cmd(home .. "/.config/dunst/scripts/key_notif/capslock_notify.sh"))
hl.bind("Num_Lock", hl.dsp.exec_cmd(home .. "/.config/dunst/scripts/key_notif/numlock_notify.sh"))

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd(home .. "/.config/dunst/scripts/volume.sh volume_up"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd(home .. "/.config/dunst/scripts/volume.sh volume_down"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd(home .. "/.config/dunst/scripts/volume.sh volume_mute"),
	{ locked = true, repeating = false }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd(home .. "/.config/dunst/scripts/volume.sh mic_toggle"),
	{ locked = true, repeating = false }
)
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd(home .. "/.config/dunst/scripts/volume.sh brightness_up"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd(home .. "/.config/dunst/scripts/volume.sh brightness_down"),
	{ locked = true, repeating = true }
)

-- Open pavucontrol
hl.bind(mod .. "+ XF86AudioMute", hl.dsp.exec_cmd("pavucontrol"))
hl.bind(mod .. "+ XF86AudioMicMute", hl.dsp.exec_cmd("pavucontrol --tab=4"))

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Airplane mode
hl.bind("XF86RFKill", hl.dsp.exec_cmd(home .. "/.config/dunst/scripts/noti-airplane.sh"), { locked = true })

-- Display settings
hl.bind("XF86Display", hl.dsp.exec_cmd("wdisplays"))

-- Screenshot
hl.bind("print", hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/screenshot.sh screen"))
hl.bind(mod .. "+ print", hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/screenshot.sh window"))
hl.bind("SHIFT + print", hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/screenshot.sh select"))
