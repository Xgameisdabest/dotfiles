#!/usr/bin/env bash

handle_title() {
	data=$(hyprctl activewindow -j | jq -rc '{class: .class, title: .title}')

	class=$(echo "$data" | jq -r '.class')
	full_title=$(echo "$data" | jq -r '.title')

	if [ -z "$class" ] || [ "$class" = "null" ]; then
		# Default state when no window is focused
		echo "{\"text\": \"󰖲\", \"tooltip\": \"  No active window\"}"
	else
		short_label="${class:0:15}"
		# Waybar expects a JSON object with "text" and "tooltip"
		echo "{\"text\": \"󰖯 $short_label\", \"tooltip\": \"󰖯 $full_title\"}"
	fi
}

handle_title

socat -U - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do
	if [[ "$line" == activewindowv2* ]] || [[ "$line" == windowtitlev2* ]]; then
		handle_title
	fi
done
