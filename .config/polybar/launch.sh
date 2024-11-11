#!/usr/bin/env sh

killall -q polybar

for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar --reload top &
    MONITOR=$m polybar --reload bottom &
done

#It's best to keep it here
#
# if type "xrandr"; then
#   for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
#     MONITOR=$m polybar --reload example &
#   done
# else
#   polybar --reload example &
# fi
#
