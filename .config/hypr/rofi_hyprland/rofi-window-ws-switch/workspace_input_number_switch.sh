#!/usr/bin/bash

source ~/.config/dtf-config/config
rofi_theme=${rofi_theme:-black}

if [[ $rofi_theme == "white" ]]; then
	path_to_theme="~/.config/rofi/rofi_theme/white/white.rasi"
else
	path_to_theme="~/.config/rofi/rofi_theme/black/black.rasi"
fi

input=$(rofi -dmenu -i -theme-str "window {height: 90px; width: 300px;}" -p "  󰖲 " -theme $path_to_theme)
if [[ $input != "" ]] && [[ "$input" =~ ^-?[0-9]+$ ]]; then
	hyprctl dispatch workspace $input
else
	exit 0
fi
