#!/bin/bash

source ~/.config/dtf-config/config

animations=${animations:-true}
blur=${blur:-true}
transparent_window_when_unfocus=${transparent_window_when_unfocus:-true}

if [[ $transparent_window_when_unfocus == "false" ]]; then
	hyprctl keyword decoration:inactive_opacity 1
else
	hyprctl keyword decoration:inactive_opacity 0.95
fi

power_mode_status=$(powerprofilesctl get)
if [[ $power_mode_status != "power-saver" ]]; then
	if [[ $animations == "false" ]]; then
		hyprctl keyword animations:enabled 0
	else
		hyprctl keyword animations:enabled 1
	fi

	if [[ $blur == "false" ]]; then
		hyprctl keyword decoration:blur:enabled false
	else
		hyprctl keyword decoration:blur:enabled true
	fi
else
	hyprctl keyword animations:enabled 0
	hyprctl keyword decoration:blur:enabled false
fi
