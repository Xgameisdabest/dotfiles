#!/bin/bash

source ~/.config/dtf-config/config

hyprland_plugins=${hyprland_plugins:-false}

if [[ $hyprland_plugins == "true" ]]; then
	sleep 0.5
	hyprpm reload -n
fi
