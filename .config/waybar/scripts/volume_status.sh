#!/bin/bash

print_volume() {
    mute=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
    volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]{1,3}(?=%)' | head -1)

    if [ "$mute" = "yes" ]; then
        icon=" "
        class="muted"
    else
        if [ "$volume" -lt 25 ]; then
            icon=" "
            class="low"
        elif [ "$volume" -lt 50 ]; then
            icon=" "
            class="medium"
        else
            icon=" "
            class="high"
        fi
    fi

    echo "{\"text\":\"$icon ${volume}%\",\"class\":\"$class\"}"
}

# Print initial state
print_volume

# Listen for volume/mute changes continuously
pactl subscribe | grep --line-buffered "sink" | while read -r _; do
    print_volume
done

