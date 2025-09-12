#!/bin/bash

source ~/.config/dtf-config/config

animations=${animations:-true}

if [[ $animations == "false" ]]; then
	hyprctl keyword animations:enabled 0
else
	hyprctl keyword animations:enabled 1
fi
