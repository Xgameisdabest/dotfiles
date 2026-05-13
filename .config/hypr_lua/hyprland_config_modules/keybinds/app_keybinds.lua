local mod = "SUPER"
local alt = "ALT"
local home = os.getenv("HOME")

---------------------
---- APP KEYBINDS ---
---------------------

-- Launch the terminal (Kitty)
hl.bind(mod .. " + t", hl.dsp.exec_cmd("$(which kitty)"))

-- Open the default web browser via xdg
hl.bind(mod .. " + c", hl.dsp.exec_cmd("xdg-open https://"))

-- Open the default file manager via xdg
hl.bind(mod .. " + e", hl.dsp.exec_cmd("xdg-open ."))

-- Launching menu (rofi)
hl.bind(mod .. "+ g", hl.dsp.exec_cmd(home .. "/.config/rofi/scripts/fullscreen-game.sh"))
hl.bind(mod .. "+ r", hl.dsp.exec_cmd(home .. "/.config/rofi/scripts/fullscreen.sh"))
hl.bind(alt .. "+ r", hl.dsp.exec_cmd(home .. "/.config/rofi/scripts/drun.sh"))
hl.bind(alt .. "+ space", hl.dsp.exec_cmd(home .. "/.config/rofi/scripts/drun.sh"))

-- Connect to android phone via scrcpy (Deprecreated, dont use it since waydroid exists)
hl.bind(
	alt .. "+ p",
	hl.dsp.exec_cmd('notify-send "CONNECTING TO PHONE " && scrcpy -Sw --video-codec=h265 --keyboard=uhid')
)

-- Launch rofi power menu/escape menu
hl.bind(mod .. "+ escape", hl.dsp.exec_cmd(home .. "/.config/rofi/modules/rofi-power-menu"))

-- Launch waypaper
hl.bind(mod .. "+ m", hl.dsp.exec_cmd("waypaper"))

-- Launch waydroid
hl.bind(mod .. "+ w", hl.dsp.exec_cmd("waydroid show-full-ui"))

-- Launch rofimoji (emoji picker using rofi)
hl.bind(mod .. "+ slash", hl.dsp.exec_cmd(home .. "/.config/rofi/scripts/emoji_picker.sh"))
