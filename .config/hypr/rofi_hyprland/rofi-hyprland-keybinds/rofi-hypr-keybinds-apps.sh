#!/bin/bash

source ~/.config/dtf-config/config
rofi_theme=${rofi_theme:-black}

if [[ $rofi_theme == "white" ]]; then
	path_to_theme="~/.config/rofi/rofi_theme/white/white.rasi"
else
	path_to_theme="~/.config/rofi/rofi_theme/black/black.rasi"
fi

goback="Back 󰌍 "
script_name=$0
script_full_path=$(dirname "$0")

window_height=500px
window_width=1550px

OPTIONS=$("$script_full_path/parser.sh" ~/.config/hypr/hyprland_config_modules/keybinds/app_keybinds.conf)

SELECTED=$(echo -e "$OPTIONS\n$goback" | rofi -dmenu -i -p '   App Launch Keybinds ' -theme-str "listview {columns: 1; layout: vertical;}" -theme-str "window {width: $window_width; height: $window_height;}" -theme $path_to_theme)

case $SELECTED in
$goback)
	~/.config/hypr/rofi_hyprland/rofi-hyprland-keybinds/rofi-hypr-keybinds
	;;
"")
	exit 0
	;;
*)
	notify-send "$SELECTED"
	;;
esac
