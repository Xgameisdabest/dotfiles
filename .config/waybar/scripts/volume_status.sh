#!/usr/bin/env bash

print_status() {
    volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | grep -Po '[0-9]{1,3}' | head -1)
    mute=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

    volume=${volume:-0}
    mute=${mute:-no}

    if [[ "$mute" == "yes" ]]; then
        icon=""
        class="muted"
        tooltip="Muted"
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
        tooltip="Volume: ${volume}%"
    fi

    echo "{\"text\":\"$icon  ${volume}%\",\"class\":\"$class\",\"tooltip\":\"$tooltip\"}"
}

# Print initial status
print_status

# Listen for events from PulseAudio/PipeWire
pactl subscribe | grep --line-buffered "sink" | while read -r _; do
    print_status
done
