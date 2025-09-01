#!/usr/bin/bash
source ~/.config/dtf-config/config
rofi_theme=${rofi_theme:-black}
if [[ $rofi_theme == "white" ]]; then
	path_to_theme="~/.config/rofi/rofi_theme/white/white.rasi"
else
	path_to_theme="~/.config/rofi/rofi_theme/black/black.rasi"
fi

# Get list of windows from hyprctl
WINDOWS=$(hyprctl -j clients | jq -r '.[] | "\(.address)\t\(.workspace.id)\t[Ws: \(.workspace.id)] \(.class) - \(.title)"')

# Let the user pick a window in rofi
CHOICE=$(echo "$WINDOWS" | cut -f3- | rofi -dmenu -i -p "Window" -theme $path_to_theme)

# Extract address and workspace of chosen window
ADDR=$(echo "$WINDOWS" | grep -F "$CHOICE" | cut -f1)
WSID=$(echo "$WINDOWS" | grep -F "$CHOICE" | cut -f2)

# Focus it if chosen
if [[ -n "$CHOICE" ]]; then
  # First, switch to its workspace (only if not already there)
  hyprctl dispatch workspace "$WSID"
  # Then, focus the exact window
  hyprctl dispatch focuswindow address:"$ADDR"
fi
