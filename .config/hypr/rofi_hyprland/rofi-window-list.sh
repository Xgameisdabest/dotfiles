#!/usr/bin/bash
source ~/.config/dtf-config/config
rofi_theme=${rofi_theme:-black}
if [[ $rofi_theme == "white" ]]; then
	path_to_theme="~/.config/rofi/rofi_theme/white/white.rasi"
else
	path_to_theme="~/.config/rofi/rofi_theme/black/black.rasi"
fi

# Get list of windows from hyprctl
windows=$(
hyprctl -j clients | jq -r 'sort_by(.workspace.id, .title)[] | "\(.address)\t\(.workspace.id)\t[Ws: \(.workspace.id)] \(.class) - \(.title)"'
)
windows_list=$(echo "$windows" | cut -f3-)

windows_list_menu_height=100
numbers_of_window=$(echo "$windows_list" | wc -l)
height_per_window_entry=$((windows_list_menu_height + (numbers_of_window * 38)))
if [[ $height_per_window_entry -gt 710 ]]; then
	height_per_window_entry=710
fi

# Let the user pick a window in rofi
choice=$(echo "$windows_list" | rofi -dmenu -i -p " Available Windows 󰖲 " -theme $path_to_theme -theme-str "window {height: ${height_per_window_entry}px;}")

# Extract address and workspace of chosen window
addr=$(echo "$windows" | grep -F "$choice" | cut -f1)
wsid=$(echo "$windows" | grep -F "$choice" | cut -f2)

# Focus it if chosen
if [[ -n "$choice" ]]; then
  # First, switch to its workspace (only if not already there)
  hyprctl dispatch workspace "$wsid"
  # Then, focus the exact window
  hyprctl dispatch focuswindow address:"$addr"
fi
