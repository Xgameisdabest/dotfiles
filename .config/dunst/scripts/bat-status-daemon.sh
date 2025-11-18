#!/bin/bash

# --- Configuration ---
# source ~/.config/dtf-config/config

# --- Singleton Logic ---
# if ps aux | grep "bat-status-daemon.sh" | grep -v grep | grep -v "$$" >/dev/null; then
# 	echo "already running."
# 	exit 0
# fi

# --- Helper Functions ---
BAT_PATH=$(find /sys/class/power_supply/BAT* -print -quit)

if [[ -z "$BAT_PATH" ]]; then
	echo "Error: No battery detected."
	exit 1
fi

get_battery_state() {
	cat "$BAT_PATH/status"
}

get_battery_level() {
	cat "$BAT_PATH/capacity"
}

# Initialize state
PREVIOUS_STATE=$(get_battery_state)

# --- Main Logic ---
# echo "Starting Power Watch on $BAT_PATH..."

udevadm monitor --udev --subsystem-match=power_supply |
	while read -r _ _ action devpath _; do

		if [[ "$devpath" =~ "AC" ]] || [[ "$devpath" =~ "BAT" ]]; then
			
			sleep 2
			CURRENT_STATE=$(get_battery_state)

			# DEBOUNCE: Only act if the state has actually changed
			if [[ "$CURRENT_STATE" != "$PREVIOUS_STATE" ]]; then

				BATTERY_LEVEL=$(get_battery_level)

				case "$CURRENT_STATE" in
				"Charging")
					notify-send "Charging 󰂅" "${BATTERY_LEVEL}% - Connected to power." -t 2500 -u low
					paplay $CUSTOM_SOUND_PATH/power-plug.oga
					;;
				"Discharging")
					notify-send "Discharging 󰁹" "${BATTERY_LEVEL}% - Running on battery." -t 2500 -u normal
					paplay $CUSTOM_SOUND_PATH/power-unplug.oga
					;;
				*) ;;
				esac

				PREVIOUS_STATE="$CURRENT_STATE"
				# echo "State changed: $CURRENT_STATE ($BATTERY_LEVEL%)"
			fi
		fi
	done
