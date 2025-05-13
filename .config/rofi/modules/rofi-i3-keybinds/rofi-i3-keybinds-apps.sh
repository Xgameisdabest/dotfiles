#!/bin/bash

goback="Back 󰌍 "
script_name=$0
script_full_path=$(dirname "$0")

window_height=500px
window_width=1550px

OPTIONS=$(python3 "$script_full_path/parser.py" ~/.config/i3/i3-config-modules/keybinds)

SELECTED=$(echo -e "$OPTIONS\n$goback" | rofi -dmenu -i -p '   App Launch Keybinds ' -theme-str "listview {columns: 1; layout: vertical;}" -theme-str "window {width: $window_width; height: $window_height;}" )

case $SELECTED in
	$goback)
		~/.config/rofi/modules/rofi-i3-keybinds/rofi-i3-keybinds
		;;
	"")
		exit 0
		;;
	*)
		notify-send "$SELECTED"
		;;
esac
