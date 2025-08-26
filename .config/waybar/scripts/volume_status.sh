#!/bin/bash

while true; do
    # Get current volume and mute status
    mute=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
    volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]{1,3}(?=%)' | head -1)

    # Determine icon and class
    if [[ "$mute" == "yes" ]]; then
        icon=" "
        class="muted"
    else
        if (( volume < 25 )); then
            icon=" "
            class="low"
        elif (( volume < 50 )); then
            icon=" "
            class="medium"
        else
            icon=" "
            class="high"
        fi
    fi

    # Output JSON for Waybar
    echo "{\"text\":\"$icon ${volume}%\",\"class\":\"$class\"}"

    sleep 0.1
done
