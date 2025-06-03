#!/bin/bash

notification_timeout=750
prev_state=""

while true; do
source ~/.config/dtf-config/config

caps_lock_notification=${caps_lock_notification:-true}

if [[ $caps_lock_notification == "false" ]]; then
	break
else
    current_state=$(xset q | grep "Caps Lock" | awk '{print $4}')
    if [ "$current_state" != "$prev_state" ]; then
        if [ "$current_state" = "on" ]; then
            notify-send -t $notification_timeout -h string:x-dunst-stack-tag:caps_notif "󰪛   Caps Lock ON"
        else
            notify-send -t $notification_timeout -h string:x-dunst-stack-tag:caps_notif "󰪛   Caps Lock OFF"
        fi
        prev_state=$current_state
    fi
    sleep 0.2

fi
done
