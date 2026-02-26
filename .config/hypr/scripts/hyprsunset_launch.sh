#!/bin/bash

source ~/.config/dtf-config/config

autostart_night_mode=${autostart_night_mode:-false}

if [[ $autostart_night_mode == "true" ]]; then
	hyprsunset --temperature 4800 &
	exit 0
else
	hyprctl hyprsunset identity
	killall hyprsunset
fi
