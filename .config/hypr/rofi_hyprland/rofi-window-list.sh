#!/usr/bin/env bash

CONFIG_FILE="$HOME/.config/dtf-config/config"
[[ -f "$CONFIG_FILE" ]] && source "$CONFIG_FILE"

rofi_theme=${rofi_theme:-black}
theme_dir="$HOME/.config/rofi/rofi_theme/$rofi_theme"
path_to_theme="$theme_dir/$rofi_theme.rasi"
stack_file="/tmp/hide_window_pid_stack.txt"

window_data=$(hyprctl -j clients | jq -r '
    sort_by(.workspace.id, .title)[] 
    | (if .workspace.id == -98 then "Hidden" else "WS: \(.workspace.id)" end) as $ws_label
    | "\($ws_label) -> \(.class): \(.title)\t\(.address)\t\(.workspace.id)"
')

window_list=$(echo "$window_data" | cut -f1)

num_windows=$(echo "$window_list" | wc -l)
max_height=710
calculated_height=$((100 + (num_windows * 38)))
final_height=$((calculated_height > max_height ? max_height : calculated_height))

choice=$(echo "$window_list" | rofi -dmenu -i \
	-p " Available Bindoj 󰖲 " \
	-theme "$path_to_theme" \
	-theme-str "listview {columns: 1; layout: vertical;}" \
	-theme-str "window {height: ${final_height}px;}")

[[ -z "$choice" ]] && exit 0

matched_line=$(echo "$window_data" | grep -P "^\Q$choice\E" | head -n1)
addr=$(echo "$matched_line" | cut -f2)
wsid=$(echo "$matched_line" | cut -f3)

if [[ -n "$addr" ]]; then
	if [[ "$wsid" == "-98" ]]; then
		target_pid=$(hyprctl clients -j | jq -r ".[] | select(.address == \"$addr\") | .pid")

		if [[ -n "$target_pid" ]]; then
			sed -i "/^$target_pid$/d" "$stack_file"
		fi

		current_workspace=$(hyprctl activeworkspace -j | jq '.id')
		hyprctl dispatch movetoworkspacesilent "$current_workspace",address:"$addr"
		hyprctl dispatch focuswindow address:"$addr"

	else
		hyprctl dispatch workspace "$wsid"
		hyprctl dispatch focuswindow address:"$addr"
	fi
fi
