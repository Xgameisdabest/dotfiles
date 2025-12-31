#!/usr/bin/env bash

current_window_class=$(hyprctl activewindow -j | jq -r '.class')

if [[ $current_window_class == "Waydroid" ]]; then
	waydroid session stop
else
	hyprctl dispatch killactive
fi
