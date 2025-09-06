#!/bin/bash

notification_timeout=750

source ~/.config/dtf-config/config

num_lock_notification=${num_lock_notification:-true}

sleep 0.2
if [[ $num_lock_notification == "true" ]]; then
    current_state="0"
    for f in /sys/class/leds/input*::numlock/brightness; do
        [[ -f "$f" ]] || continue
        [[ $(cat "$f") -eq 1 ]] && current_state="1" && break
    done

    if [ "$current_state" != "$prev_state" ]; then
        if [ "$current_state" = 1 ]; then
            notify-send -t $notification_timeout -h string:x-dunst-stack-tag:numlock_notif "󰿪   Num Lock ON"
        else
            notify-send -t $notification_timeout -h string:x-dunst-stack-tag:numlock_notif "󰿪   Num Lock OFF"
        fi
        prev_state=$current_state
    fi
fi
