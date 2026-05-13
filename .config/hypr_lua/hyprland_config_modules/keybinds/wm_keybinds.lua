local mod = "SUPER"
local alt = "ALT"
local home = os.getenv("HOME")

---------------------------------
---- WINDOW MANAGER KEYBINDS ----
---------------------------------

hl.bind(mod .. " + SHIFT + r", hl.dsp.exec_cmd('notify-send "Hyprland Manually Reloaded!" && hyprctl reload'))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Lock screen via hyprlock
hl.bind(
	mod .. "+ q",
	hl.dsp.exec_cmd(
		"bash -c '! pidof -x hyprlock_current_bg.sh > /dev/null &&"
			.. home
			.. "/.config/hypr/scripts/hyprlock_current_bg.sh'"
	)
)

-- Screensaver
hl.bind(alt .. "+ q", hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/hyprland_screensaver.sh"))

-- Window lists
hl.bind(mod .. "+ Tab", hl.dsp.exec_cmd(home .. "/.config/hypr_lua/rofi-window-list.sh"))

-- Kill window
hl.bind(mod .. " + x", hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/kill_window.sh"))

-- Toggle fullscreen/float (HUGE HUGE THANKS TO Mountain-Ride-6361 to help me on the r/hyprland subreddit)
-- Link: https://www.reddit.com/r/hyprland/comments/1tbmon2/how_to_convert_resize_percentage_to_lua/
hl.bind(mod .. " + v ", function()
	hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
	local monitor = hl.get_active_monitor()
	if not monitor then
		return
	end
	local height = monitor.height * 0.7
	local width = monitor.width * 0.7
	hl.dispatch(hl.dsp.window.resize({ x = width, y = height }))
end)

hl.bind(mod .. " + f", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind("F11", hl.dsp.window.fullscreen({ action = "toggle" }))

-- Hide/Unhide window
hl.bind(mod .. "+ d", hl.dsp.exec_cmd(home .. "/.config/hypr_lua/hide_unhide_window.sh h"))
hl.bind(mod .. "+ SHIFT + d", hl.dsp.exec_cmd(home .. "/.config/hypr_lua/hide_unhide_window.sh s"))

-- Launch web search
hl.bind(mod .. "+ s", hl.dsp.exec_cmd(home .. "/.config/rofi/modules/rofi-web-search"))

-- Launch user settings
hl.bind(mod .. " + i ", hl.dsp.exec_cmd(home .. "/.config/rofi/modules/rofi-user-settings"))

-- Launch keybinds menu
hl.bind(
	mod .. "+ equal",
	hl.dsp.exec_cmd(home .. "/.config/hypr/rofi_hyprland/rofi-hyprland-keybinds/rofi-hypr-keybinds")
)

-- Toggle waybar visibility
hl.bind(
	mod .. "+ minus",
	hl.dsp.exec_cmd('pkill -USR1 waybar && notify-send -t 2300 "Waybar Visibility Toggled!" "Press Mod+- to toggle"')
)

-- Cycle between workspace previously
hl.bind(alt .. "+ Tab", hl.dsp.focus({ workspace = "previous" }))

-- Laptop lid
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("systemctl suspend"), { locked = true })
hl.bind(
	"switch:off:Lid Switch",
	hl.dsp.exec_cmd(
		"bash -c '! pidof -x hyprlock_current_bg.sh > /dev/null &&"
			.. home
			.. "/.config/hypr/scripts/hyprlock_current_bg.sh'"
	),
	{ locked = true }
)

-- Window switch
hl.bind(mod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Workspace switch and move window to workspace
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "-1" }))

-- Reposition window in a workspace
hl.bind(mod .. "+ SHIFT + left", hl.dsp.window.move({ direction = "l" }))
hl.bind(mod .. "+ SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mod .. "+ SHIFT + up", hl.dsp.window.move({ direction = "u" }))
hl.bind(mod .. "+ SHIFT + down", hl.dsp.window.move({ direction = "d" }))

-- Move window to neighbouring workspace
hl.bind("CTRL + " .. mod .. " + left ", hl.dsp.window.move({ workspace = "-1", follow = false }))
hl.bind("CTRL + " .. mod .. " + right ", hl.dsp.window.move({ workspace = "+1", follow = false }))

-- Menu window switcher
hl.bind(
	mod .. "+ SHIFT + grave",
	hl.dsp.exec_cmd(home .. "/.config/hypr/rofi_hyprland/rofi-window-ws-switch/workspace_input_number_window_switch.sh")
)
hl.bind(
	mod .. "+ grave",
	hl.dsp.exec_cmd(home .. "/.config/hypr/rofi_hyprland/rofi-window-ws-switch/workspace_input_number_switch.sh")
)

-- Move to next workspace focus via keyboard
hl.bind("CTRL + " .. alt .. " + right", hl.dsp.focus({ workspace = "+1" }))
hl.bind("CTRL + " .. alt .. " + left", hl.dsp.focus({ workspace = "-1" }))
