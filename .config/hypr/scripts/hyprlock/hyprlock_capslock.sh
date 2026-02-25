#!/bin/bash

sleep 0.2
current_state="0"
for f in /sys/class/leds/input*::capslock/brightness; do
	[[ -f "$f" ]] || continue
	[[ $(cat "$f") -eq 1 ]] && current_state="1" && break
done

if [ "$current_state" != "$prev_state" ]; then
	if [ "$current_state" = 1 ]; then
		echo "󰪛   Caps Lock ON"
	else
		# echo "󰪛   Caps Lock OFF"
		echo ""
	fi
	prev_state=$current_state
fi
