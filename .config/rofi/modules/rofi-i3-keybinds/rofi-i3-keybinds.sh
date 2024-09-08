#!/bin/bash

script_name=$0
script_full_path=$(dirname "$0")

OPTIONS=$(python3 "$script_full_path/parser.py" ~/.config/i3/config)
LAUNCHER="rofi -dmenu -i -theme ~/.config/rofi/modules/rofi-i3-keybinds/theme -p '  "

SELECTED=$(echo "${OPTIONS/, \n}" | $LAUNCHER)
notify-send "$SELECTED"
