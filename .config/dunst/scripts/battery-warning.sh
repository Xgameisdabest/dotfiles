#!/bin/bash

PIDFILE="/tmp/battery-watch.pid"
THRESHOLD=20

# Prevent multiple instances
if [[ -f "$PIDFILE" ]] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
    echo "battery-watch already running"
    exit 0
fi

echo $$ >"$PIDFILE"
trap "rm -f $PIDFILE" EXIT

# Get the UPower battery object path
BATTERY_PATH=$(upower -e | grep BAT)
if [[ -z "$BATTERY_PATH" ]]; then
    echo "No battery detected."
    exit 1
fi

# Subscribe to property changes
gdbus monitor --system --dest org.freedesktop.UPower --object-path "$BATTERY_PATH" |
while read -r line; do
    if [[ "$line" =~ "PropertiesChanged" ]]; then
        # Extract current state and percentage
        STATE=$(upower -i "$BATTERY_PATH" | awk '/state:/ {print $2}')
        PERCENT=$(upower -i "$BATTERY_PATH" | awk '/percentage:/ {print int($2)}')

        # Only trigger if discharging and below threshold
        if [[ "$STATE" == "discharging" && "$PERCENT" -le "$THRESHOLD" ]]; then
            notify-send "  Low Battery" "Battery at ${PERCENT}%!"
            paplay ~/.config/dunst/scripts/sounds/message.oga
        fi
    fi
done
