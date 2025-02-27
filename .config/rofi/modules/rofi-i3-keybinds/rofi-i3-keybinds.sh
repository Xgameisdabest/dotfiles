#!/bin/bash

script_name=$0
script_full_path=$(dirname "$0")

OPTIONS=$(python3 "$script_full_path/parser.py" ~/.config/i3/i3-config-modules/i3_system_keybinds && python3 "$script_full_path/parser.py" ~/.config/i3/i3-config-modules/special_keys_keybinds python3 && python3 "$script_full_path/parser.py" ~/.config/i3/i3-config-modules/keybinds)

SELECTED=$(echo "${OPTIONS/, \n}" | rofi -dmenu -i -p '   System Keybinds ' -theme-str "listview {columns: 1; layout: vertical;}" )
notify-send "$SELECTED"
