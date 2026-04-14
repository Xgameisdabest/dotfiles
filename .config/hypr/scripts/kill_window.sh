#!/usr/bin/env bash

current_window_class=$(hyprctl activewindow -j | jq -r '.class')

if [[ $current_window_class == "Waydroid" ]]; then
	waydroid session stop
elif [[ "${current_window_class,,}" == *spotify* ]]; then
	~/.config/hypr/scripts/hide_unhide_window.sh h
else
	hyprctl dispatch killactive
fi
