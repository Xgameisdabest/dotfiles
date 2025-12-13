#!/bin/bash

source ~/.config/dtf-config/config

layout=${layout:-dwindle}

if [[ $layout == "scrolling" ]]; then
	hyprctl keyword general:layout scrolling
elif [[ $layout == "master" ]]; then
	hyprctl keyword general:layout master
else
	hyprctl keyword general:layout dwindle
fi
