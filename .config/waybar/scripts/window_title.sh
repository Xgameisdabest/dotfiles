#!/usr/bin/env bash

# Get focused window title from Hyprland
title=$(hyprctl activewindow -j | jq -r '.class')

# Fallback if empty (no active window)
if [ -z "$title" ] || [ "$title" = "null" ]; then
  echo "{\"text\": \"Hypr 󰨇\"}"
else
  echo "{\"text\": \"󰖯 $title\"}"
fi

