#!/usr/bin/env bash

source ~/.config/dtf-config/config

polybar_color=${polybar_color:-black}

killall -q polybar

if [[ $polybar_color == "black" ]]; then
for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar --reload main &
done

elif [[ $polybar_color == "white" ]]; then
for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar --reload main_white &
done

else
for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar --reload main &
done

fi
