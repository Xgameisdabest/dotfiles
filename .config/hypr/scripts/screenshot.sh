#!/bin/bash

if [[ $1 == "screen" ]]; then
	# Entire screen
	desktop="$HOME/Pictures/$(date +'%Y-%m-%d_%H-%M-%S_desktop').png"
	grim "$desktop"
	wl-copy <"$desktop"
	notify-send "Screenshotted 󰨇 "
elif [[ $1 == "window" ]]; then
	# Window
	focus_window="$HOME/Pictures/$(date +'%Y-%m-%d_%H-%M-%S_window').png"
	grim -g "$(hyprctl activewindow -j | jq -r ".at[0],.at[1],.size[0],.size[1]" | tr "\n" "," | sed "s/,$//")" "$focus_window"
	wl-copy <"$focus_window"
	notify-send "Window Screenshotted 󰖯 "
elif [[ $1 == "select" ]]; then
	# Selected
	selected_area="$HOME/Pictures/$(date +'%Y-%m-%d_%H-%M-%S_area').png"
	grim -g "$(slurp)" "$selected_area"
	wl-copy <"$selected_area"
	notify-send "Selected Area Screenshotted 󰨤"
fi
