#!/bin/bash

# Get all existing workspace IDs (sorted)
workspaces=$(hyprctl workspaces -j | jq '.[].id' | sort -n)
current=$(hyprctl activeworkspace -j | jq '.id')

# Convert to array
mapfile -t ws_array <<<"$workspaces"
count=${#ws_array[@]}

# Find index of current workspace
for i in "${!ws_array[@]}"; do
	if [[ "${ws_array[$i]}" -eq "$current" ]]; then
		idx=$i
		break
	fi
done

case "$1" in
next)
	next_idx=$(((idx + 1) % count))
	hyprctl dispatch workspace "${ws_array[$next_idx]}"
	;;
prev)
	prev_idx=$(((idx - 1 + count) % count))
	hyprctl dispatch workspace "${ws_array[$prev_idx]}"
	;;
esac
