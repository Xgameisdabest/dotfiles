#!/bin/bash

notification_timeout=750

# Check if dependencies are available
if ! command -v xset &> /dev/null || ! command -v notify-send &> /dev/null; then
    echo "Error: This script requires 'xset' and 'notify-send'."
    exit 1
fi

# Initialize previous state
prev_state=""

while true; do
    current_state=$(xset q | grep "Num Lock" | awk '{print $8}')
    
    if [ "$current_state" != "$prev_state" ]; then
        if [ "$current_state" = "on" ]; then
            notify-send -t $notification_timeout -h string:x-dunst-stack-tag:numlock_notif "󰿪   Num Lock ON"
        else
            notify-send -t $notification_timeout -h string:x-dunst-stack-tag:numlock_notif "󰿪   Num Lock OFF"
        fi
        prev_state=$current_state
    fi

    sleep 0.2
done
