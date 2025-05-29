#!/bin/bash

source ~/.config/dtf-config/config

performance_mode_when_plugged=${performance_mode_when_plugged:-false}

notification_timeout=1100

if [[ $performance_mode_when_plugged == "true" ]]; then
	if [[ $1 == "--performance" ]]; then
		powerprofilesctl set performance
		light -S 100
		notify-send -t $notification_timeout -h string:x-dunst-stack-tag:power_mode_status "Power set to performance mode 󰓅"
		~/.config/dunst/volume.sh brightness_status
	fi
fi
