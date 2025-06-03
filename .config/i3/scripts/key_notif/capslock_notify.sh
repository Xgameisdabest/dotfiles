#!/bin/bash

notification_timeout=750

source ~/.config/dtf-config/config

caps_lock_notification=${caps_lock_notification:-true}

sleep 0.2
if [[ $caps_lock_notification == "true" ]]; then
    prev_state=""
    current_state=$(xset q | grep "Caps Lock" | awk '{print $4}')
    if [ "$current_state" != "$prev_state" ]; then
        if [ "$current_state" = "on" ]; then
            notify-send -t $notification_timeout -h string:x-dunst-stack-tag:caps_notif "󰪛   Caps Lock ON"
        else
            notify-send -t $notification_timeout -h string:x-dunst-stack-tag:caps_notif "󰪛   Caps Lock OFF"
        fi
        prev_state=$current_state
    fi
fi
