#!/bin/bash

source ~/.config/dtf-config/config

hyprland_plugins=${hyprland_plugins:-false}

if [[ $hyprland_plugins == "true" ]]; then
	hyprpm reload
	sleep 0.2
	killall -SIGUSR2 waybar
fi
