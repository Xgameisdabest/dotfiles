#!/bin/bash
source ~/.config/dtf-config/config

cava_background=${cava_background:-false}

if [[ $cava_background == "true" ]]; then
	# Launch kitty with cavabg if not already running
	pkill -f "kitty.*--class=kitty-bg"
	kitty -c "$HOME/.config/kitty/kitty-bg.conf" \
			--class="kitty-bg" \
			"$HOME/.config/hypr/scripts/cavabg/cavabg.sh" &
else
	# Kill kitty background instance(s)
	pkill -f "kitty.*--class=kitty-bg"
fi
