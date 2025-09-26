#!/usr/bin/env bash

# Get focused window title from Hyprland
title=$(hyprctl activewindow -j | jq -r '.class')

# Fallback if empty (no active window)
if [ -z "$title" ] || [ "$title" = "null" ]; then
	echo "{\"text\": \"󰖲\"}"
else
	# Truncate to 17 characters
	short_title="${title:0:15}"
	echo "{\"text\": \"󰖯 $short_title\"}"
fi
