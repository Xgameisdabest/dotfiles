#!/bin/bash

source ~/.config/dtf-config/config

animations=${animations:-true}
blur=${blur:-true}

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
