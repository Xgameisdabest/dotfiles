#!/usr/bin/env bash

prev_volume=-1
prev_mute=""

while true; do
    # Get current sink info once
    read -r volume mute <<< "$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | grep -Po '[0-9]{1,3}' | head -1) $(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')"
    
    volume=${volume:-0}
    mute=${mute:-no}

    # Only update if something changed
    if [[ "$volume" != "$prev_volume" || "$mute" != "$prev_mute" ]]; then
        prev_volume=$volume
        prev_mute=$mute

        if [[ "$mute" == "yes" ]]; then
            icon=""
            class="muted"
        else
            if (( volume < 25 )); then
                icon=""
                class="low"
            elif (( volume < 50 )); then
                icon=""
                class="medium"
            else
                icon=""
                class="high"
            fi
        fi

        # Output JSON
        echo "{\"text\":\"$icon  ${volume}%\",\"class\":\"$class\"}"
    fi

    sleep 0.3
done
