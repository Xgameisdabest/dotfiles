#!/bin/bash

current_volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '\d+(?=%)' | head -n 1)
mute_status=$(pactl get-sink-mute @DEFAULT_SINK@ | sed "s/Mute: //g")
current_brightness=$(light -G | cut -d'.' -f1)

if [[ $mute_status == "yes" ]]; then
		volume_icon=""
	elif ((current_volume < 25)); then
		volume_icon=""
	elif ((current_volume < 50)); then
		volume_icon=""
	else
		volume_icon=""
	fi

echo "$volume_icon  $current_volume% -   $current_brightness%"
