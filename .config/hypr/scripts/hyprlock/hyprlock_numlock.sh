#!/bin/bash

sleep 0.2
current_state="0"
for f in /sys/class/leds/input*::numlock/brightness; do
	[[ -f "$f" ]] || continue
	[[ $(cat "$f") -eq 1 ]] && current_state="1" && break
done

if [ "$current_state" != "$prev_state" ]; then
	if [ "$current_state" = 1 ]; then
		echo "󰿪   Num Lock ON"
	else
		# echo "󰿪   Num Lock OFF"
		echo ""
	fi
	prev_state=$current_state
fi
