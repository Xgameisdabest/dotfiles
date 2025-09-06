#!/bin/bash

notification_timeout=750

source ~/.config/dtf-config/config

caps_lock_notification=${caps_lock_notification:-true}

sleep 0.2
if [[ $caps_lock_notification == "true" ]]; then
    current_state="0"
    for f in /sys/class/leds/input*::capslock/brightness; do
        [[ -f "$f" ]] || continue
        [[ $(cat "$f") -eq 1 ]] && current_state="1" && break
    done

    if [ "$current_state" != "$prev_state" ]; then
        if [ "$current_state" = 1 ]; then
            notify-send -t $notification_timeout -h string:x-dunst-stack-tag:caps_notif "󰪛   Caps Lock ON"
        else
            notify-send -t $notification_timeout -h string:x-dunst-stack-tag:caps_notif "󰪛   Caps Lock OFF"
        fi
        prev_state=$current_state
    fi
fi
