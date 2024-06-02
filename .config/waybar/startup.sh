#!/usr/bin/env sh

killall -q waybar

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m waybar --reload example &
  done
else
  waybar --reload example &
fi
