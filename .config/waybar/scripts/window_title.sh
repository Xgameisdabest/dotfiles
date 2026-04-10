#!/usr/bin/env bash

handle_title() {
	# Get JSON data for the active window
	data=$(hyprctl activewindow -j)

	class=$(echo "$data" | jq -r '.class')
	full_title=$(echo "$data" | jq -r '.title' | sed -e 's/&/and/g' -e 's/</[/g' -e 's/>/]/g')
	pid=$(echo "$data" | jq -r '.pid')

	if [ -z "$class" ] || [ "$class" = "null" ]; then
		echo "{\"text\": \"󰖲\", \"tooltip\": \"  No active window\"}"
	else
		# Calculate RAM usage for the specific PID in MB/GB
		# 'rss' is Resident Set Size (physical memory used)
		if [ -n "$pid" ] && [ "$pid" != "null" ]; then
			ram_kb=$(ps -p "$pid" -o rss= | tr -d ' ')
			if [ -n "$ram_kb" ]; then
				ram_mb=$((ram_kb / 1024))

				if [ "$ram_mb" -ge 1024 ]; then
					# Convert to GB with 1 decimal place using awk
					ram_gb=$(awk "BEGIN {printf \"%.1f\", $ram_kb / 1048576}")
					ram_display="$ram_gb GB"
				else
					ram_display="$ram_mb MB"
				fi
			else
				ram_display="Null B"
			fi
		fi

		short_label="${class:0:15}"
		window_tooltip="  $full_title\n  RAM Usage: $ram_display"
		echo "{\"text\": \"󰖯 $short_label\", \"tooltip\": \"$window_tooltip\"}"
	fi
}

handle_title

# Listen for window changes
socat -U - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do
	if [[ "$line" == activewindowv2* ]] || [[ "$line" == windowtitlev2* ]]; then
		handle_title
	fi
done
