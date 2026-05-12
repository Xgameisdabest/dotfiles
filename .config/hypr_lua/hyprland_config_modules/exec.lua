------------------------
---- AUTOSTART/EXEC ----
------------------------

local home = os.getenv("HOME")
local user = os.getenv("USER")

hl.exec_cmd(home .. "/.config/hypr/scripts/monitor.sh")

hl.on("hyprland.start", function()
	hl.exec_cmd("systemctl --user stop betterlockscreen@" .. user .. ".service")
	hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 24")
	-- Polkit agent, required for graphical apps
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	-- Waybar
	hl.exec_cmd(home .. "/.config/waybar/startup.sh")
	-- Hyprsunset
	hl.exec_cmd(home .. "/.config/hypr/scripts/hyprsunset_launch.sh")
	-- Animations option on/off
	hl.exec_cmd(home .. "/.config/hypr/scripts/decorations_options.sh")
	-- For layouts
	hl.exec_cmd(home .. "/.config/hypr/scripts/layout.sh")
	-- Set cava as background, using hyprwinwrap plugin
	hl.exec_cmd(home .. "/.config/hypr/scripts/cavabg/cavabg-launch.sh")
	-- Gestures
	hl.exec_cmd("libinput-gestures-setup restart")
	-- Auto sleep
	hl.exec_cmd(home .. "/.config/hypr/scripts/auto_sleep.sh")
	-- Inactive Opacity Change
	hl.exec_cmd(home .. "/.config/hypr/scripts/transparent_window_when_unfocus.sh")
	-- Init the notification daemon
	hl.exec_cmd("dunst")
	-- Usb media notification daemon
	hl.exec_cmd(home .. "/.config/dunst/scripts/usb-watch.sh")
	-- Plug, unplug power source daemon
	hl.exec_cmd(home .. "/.config/dunst/scripts/bat-status-daemon.sh")
	-- Battery low notification daemon
	hl.exec_cmd(home .. "/.config/dunst/scripts/battery-warning.sh")
	-- Notifications
	hl.exec_cmd(home .. "/.config/dunst/volume.sh volume_status")
	hl.exec_cmd(home .. "/.config/dunst/volume.sh brightness_status")
	hl.exec_cmd(home .. "/.config/dunst/bat_status.sh status")
	-- Welcome message
	hl.exec_cmd(home .. "/.config/dunst/scripts/welcome-notif.sh")
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
	hl.exec_cmd(home .. "/.config/hypr/scripts/protonvpn_check_when_resume.sh")
end)

-- Waybar
hl.exec_cmd(home .. "/.config/waybar/startup.sh")
-- Hyprsunset
hl.exec_cmd(home .. "/.config/hypr/scripts/hyprsunset_launch.sh")
-- Animations option on/off
hl.exec_cmd(home .. "/.config/hypr/scripts/decorations_options.sh")
-- For layouts
hl.exec_cmd(home .. "/.config/hypr/scripts/layout.sh")
-- Set cava as background, using hyprwinwrap plugin
hl.exec_cmd(home .. "/.config/hypr/scripts/cavabg/cavabg-launch.sh")
-- Gestures
hl.exec_cmd("libinput-gestures-setup restart")
-- Auto sleep
hl.exec_cmd(home .. "/.config/hypr/scripts/auto_sleep.sh")
-- Inactive Opacity Change
hl.exec_cmd(home .. "/.config/hypr/scripts/transparent_window_when_unfocus.sh")
