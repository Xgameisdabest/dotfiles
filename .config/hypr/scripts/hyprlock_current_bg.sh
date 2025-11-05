#!/bin/bash

# Path to Hyprlock config
CONFIG="$HOME/.config/hypr/hyprlock.conf"

# Extract wallpaper path from swaybg
WALLPAPER=$(ps aux | grep swaybg | grep -v grep | grep -oP '(?<=-i )\S+')

# Default wallpaper path (reset value)
DEFAULT=""

if [ -n "$WALLPAPER" ]; then
	# Save current path line
	ORIGINAL_LINE=$(sed -n '/^background {/,/^}/s/^[[:space:]]*path =.*/&/p' "$CONFIG")

	# Inject current wallpaper
	sed -i "/^background {/,/^}/{s|^[[:space:]]*path =.*|    path = $WALLPAPER|}" "$CONFIG"
fi

# Run Hyprlock and wait for it to quit
hyprlock

killall -9 hyprlock

# After Hyprlock exits, restore the default (or original) wallpaper line
if [ -n "$WALLPAPER" ]; then
	if [ -n "$ORIGINAL_LINE" ]; then
		# Restore original line
		sed -i "/^background {/,/^}/{s|^[[:space:]]*path =.*|$ORIGINAL_LINE|}" "$CONFIG"
	else
		# Or reset to default
		sed -i "/^background {/,/^}/{s|^[[:space:]]*path =.*|    path = $DEFAULT|}" "$CONFIG"
	fi
fi
