local home = os.getenv("HOME")

-- Functions

function movetoleft()
	hl.dispatch(hl.dsp.window.move({ workspace = "-1", follow = false }))
end

function movetoright()
	hl.dispatch(hl.dsp.window.move({ workspace = "+1", follow = false }))
end

function open_rofi()
	hl.dispatch(hl.dsp.exec_cmd(home .. "/.config/rofi/scripts/fullscreen.sh"))
end

function close_rofi()
	hl.dispatch(hl.dsp.exec_cmd("killall rofi"))
end

function show_window()
	hl.dispatch(hl.dsp.exec_cmd("~/.config/hypr_lua/hide_unhide_window.sh s"))
end

function hide_window()
	hl.dispatch(hl.dsp.exec_cmd("~/.config/hypr_lua/hide_unhide_window.sh h"))
end

-- Workspace swipe via 3 fingers
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
-- Show hidden window via 3 fingers swipe up
hl.gesture({ fingers = 3, direction = "up", action = show_window })
-- Hide window via 3 fingers swipe down
hl.gesture({ fingers = 3, direction = "down", action = hide_window })
-- Move focused window to the right workspace via 4 fingers swipe right
hl.gesture({ fingers = 4, direction = "right", action = movetoright })
-- Move focused window to the left workspace via 4 fingers swipe left
hl.gesture({ fingers = 4, direction = "left", action = movetoleft })
-- Open rofi fullscreen via 4 fingers swipe up
hl.gesture({ fingers = 4, direction = "up", action = open_rofi })
-- Close all rofi windows via 4 fingers swipe down
hl.gesture({ fingers = 4, direction = "down", action = close_rofi })
