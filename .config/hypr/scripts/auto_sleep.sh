#!/usr/bin/env bash

source ~/.config/dtf-config/config

auto_sleep=${auto_sleep:-true}

if [[ $auto_sleep == "false" ]]; then
    pkill hypridle
    notify-send "Auto Screen Timeout Disabled 󱡥"
else
    hypridle &
    notify-send "Auto Screen Timeout Enabled 󰾨"
fi
