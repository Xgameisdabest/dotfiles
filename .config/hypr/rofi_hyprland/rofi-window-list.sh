#!/usr/bin/env bash

CONFIG_FILE="$HOME/.config/dtf-config/config"
[[ -f "$CONFIG_FILE" ]] && source "$CONFIG_FILE"

rofi_theme=${rofi_theme:-black}
theme_dir="$HOME/.config/rofi/rofi_theme/$rofi_theme"
path_to_theme="$theme_dir/$rofi_theme.rasi"
stack_file="/tmp/hide_window_pid_stack.txt"

# Get screen width and currently focused window
screen_width=$(hyprctl monitors -j | jq '.[] | select(.focused == true) | .width')
active_addr=$(hyprctl activewindow -j | jq -r '.address')

# Fetch window, labeling ID -98 as "Hidden"
window_data=$(hyprctl -j clients | jq -r '
    sort_by(.workspace.id, .title)[] 
    | (if .workspace.id == -98 then "Hidden" else "Workspace \(.workspace.id)" end) as $ws_label
    | "\($ws_label) -> \(.class): \(.title)\t\(.address)\t\(.workspace.id)"
')

window_list=$(echo "$window_data" | cut -f1)

# Find index of active window for Rofi (0-based)
active_row_num=$(echo "$window_data" | grep -n "$active_addr" | cut -d: -f1)
selected_row=$((${active_row_num:-1} - 1))

# Calculate dynamic height
num_windows=$(echo "$window_list" | wc -l)
max_h=710
calc_h=$((100 + (num_windows * 38)))
final_h=$((calc_h > max_h ? max_h : calc_h))

# Calculate dynamic width (Target: 10.5px per char, Max: 2/3 screen)
max_chars=$(echo "$window_list" | wc -L)
min_w=400
read -r max_w calc_w <<<"$(awk -v sw="$screen_width" -v mc="$max_chars" 'BEGIN { printf "%.0f %.0f", (sw*2/3), (mc*10.5)+80 }')"

# Clamp width between min and max limits
if ((calc_w < min_w)); then
	final_w=$min_w
elif ((calc_w > max_w)); then
	final_w=$max_w
else final_w=$calc_w; fi

# Open Rofi
choice=$(echo "$window_list" | rofi -dmenu -i \
	-p " Available Windows 󰖲 " \
	-selected-row "$selected_row" \
	-theme "$path_to_theme" \
	-theme-str "listview {columns: 1; layout: vertical;}" \
	-theme-str "window {height: ${final_h}px; width: ${final_w}px;}")

[[ -z "$choice" ]] && exit 0

# Parse selection data
matched_line=$(echo "$window_data" | grep -P "^\Q$choice\E" | head -n1)
addr=$(echo "$matched_line" | cut -f2)
wsid=$(echo "$matched_line" | cut -f3)

if [[ -n "$addr" ]]; then
	target_pid=$(hyprctl clients -j | jq -r ".[] | select(.address == \"$addr\") | .pid")
	if [[ "$wsid" == "-98" ]]; then
		# Handle hidden window: cleanup stack and move to current workspace
		notify-send "Window showed!" "Process ID: $target_pid"
		[[ -n "$target_pid" ]] && sed -i "/^$target_pid$/d" "$stack_file"

		curr_ws=$(hyprctl activeworkspace -j | jq '.id')
		hyprctl dispatch movetoworkspacesilent "$curr_ws",address:"$addr"
		hyprctl dispatch focuswindow address:"$addr"
	else
		# Handle visible window: switch workspace and focus
		notify-send "Window switched!" "Process ID: $target_pid"
		hyprctl dispatch workspace "$wsid"
		hyprctl dispatch focuswindow address:"$addr"
	fi
fi
