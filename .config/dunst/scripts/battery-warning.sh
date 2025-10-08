#!/bin/bash

PIDFILE="/tmp/battery-watch.pid"
THRESHOLD=20

# Prevent duplicates
if [[ -f "$PIDFILE" ]] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
	echo "battery-watch already running"
	exit 0
fi

echo $$ >"$PIDFILE"

cleanup() {
	echo "Cleaning up..."
	if [[ -n "$GDBUS_PID" ]] && kill -0 "$GDBUS_PID" 2>/dev/null; then
		kill "$GDBUS_PID" 2>/dev/null
	else
		# Fallback: try to kill *only this script's* gdbus process
		pkill -P $$ -f "gdbus monitor --system --dest org.freedesktop.UPower" 2>/dev/null
	fi
	rm -f "$PIDFILE"
}
trap cleanup EXIT INT TERM

BATTERY_PATH=$(upower -e | grep BAT)
[[ -z "$BATTERY_PATH" ]] && {
	echo "No battery detected."
	exit 1
}

# Start gdbus monitor and capture its PID
gdbus monitor --system --dest org.freedesktop.UPower --object-path "$BATTERY_PATH" |
	while read -r line; do
		if [[ "$line" =~ "PropertiesChanged" ]]; then
			STATE=$(upower -i "$BATTERY_PATH" | awk '/state:/ {print $2}')
			PERCENT=$(upower -i "$BATTERY_PATH" | awk '/percentage:/ {print int($2)}')
			if [[ "$STATE" == "discharging" && "$PERCENT" -le "$THRESHOLD" ]]; then
				notify-send "  Low Battery" "Battery at ${PERCENT}%!"
				paplay /usr/share/sounds/freedesktop/stereo/dialog-warning.oga
			fi
		fi
	done &
GDBUS_PID=$!

wait "$GDBUS_PID"
