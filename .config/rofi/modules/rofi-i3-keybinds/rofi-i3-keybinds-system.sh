#!/bin/bash

goback="Back 󰌍 "
script_name=$0
script_full_path=$(dirname "$0")

window_height=500px
window_width=1575px

OPTIONS=$(python3 "$script_full_path/parser.py" ~/.config/i3/i3-config-modules/i3_system_keybinds && python3 "$script_full_path/parser.py" ~/.config/i3/i3-config-modules/special_keys_keybinds)

SELECTED=$(echo -e "$OPTIONS\n$goback" | rofi -dmenu -i -p '   System Keybinds ' -theme-str "listview {columns: 1; layout: vertical;}" -theme-str "window {width: $window_width; height: $window_height;}" )

case $SELECTED in
	$goback)
		~/.config/rofi/modules/rofi-i3-keybinds/rofi-i3-keybinds
		;;
	*)
		notify-send "$SELECTED"
		;;
esac
