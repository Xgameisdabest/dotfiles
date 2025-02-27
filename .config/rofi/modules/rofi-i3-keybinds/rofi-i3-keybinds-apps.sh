#!/bin/bash

goback="Back 󰌍 "
script_name=$0
script_full_path=$(dirname "$0")

OPTIONS=$(python3 "$script_full_path/parser.py" ~/.config/i3/i3-config-modules/keybinds)

SELECTED=$(echo -e "$OPTIONS\n$goback" | rofi -dmenu -i -p '   App Launch Keybinds ' -theme-str "listview {columns: 1; layout: vertical;}" )

case $SELECTED in
	$goback)
		~/.config/rofi/modules/rofi-i3-keybinds/rofi-i3-keybinds
		;;
	*)
		notify-send "$SELECTED"
		;;
esac
