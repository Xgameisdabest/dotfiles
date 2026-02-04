#!/bin/bash

source ~/.config/dtf-config/config

transparent_window_when_unfocus=${transparent_window_when_unfocus:-true}

if [[ $transparent_window_when_unfocus == "true" ]]; then
	hyprctl keyword decoration:inactive_opacity 0.95
else
	hyprctl keyword decoration:inactive_opacity 1
fi
