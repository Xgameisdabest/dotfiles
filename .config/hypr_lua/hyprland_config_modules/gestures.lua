local home = os.getenv("HOME")
local user = os.getenv("USER")

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

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({
	fingers = 3,
	direction = "up",
	action = show_window,
})
hl.gesture({
	fingers = 3,
	direction = "down",
	action = hide_window,
})
hl.gesture({ fingers = 4, direction = "right", action = movetoright })
hl.gesture({ fingers = 4, direction = "left", action = movetoleft })
hl.gesture({ fingers = 4, direction = "up", action = open_rofi })
hl.gesture({ fingers = 4, direction = "down", action = close_rofi })
