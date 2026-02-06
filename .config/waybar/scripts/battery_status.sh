#!/bin/bash

# Define paths
BAT_PATH="/sys/class/power_supply/BAT0"
[ ! -d "$BAT_PATH" ] && BAT_PATH="/sys/class/power_supply/BAT1"

# Detect Controller, Mode, and Turbo
TURBO_INFO=""
GOVERNOR=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 2>/dev/null || echo "N/A")

if hash powerprofilesctl 2>/dev/null; then
	CONTROLLER="power-profiles-daemon"
	MODE=$(powerprofilesctl get)
elif hash auto-cpufreq 2>/dev/null; then
	CONTROLLER="auto-cpufreq"
	MODE=$(auto-cpufreq --get-state)
	# Kernel Turbo Check
	if [ -f "/sys/devices/system/cpu/intel_pstate/no_turbo" ]; then
		[[ $(cat /sys/devices/system/cpu/intel_pstate/no_turbo) == "0" ]] && T_STAT="on" || T_STAT="off"
	elif [ -f "/sys/devices/system/cpu/cpufreq/boost" ]; then
		[[ $(cat /sys/devices/system/cpu/cpufreq/boost) == "1" ]] && T_STAT="on" || T_STAT="off"
	else
		T_STAT="N/A"
	fi
	TURBO_INFO="\nTurbo: $T_STAT"
else
	CONTROLLER="Kernel (Generic)"
	MODE="$GOVERNOR"
fi

# Desktop Handling
if [ ! -d "$BAT_PATH" ]; then
	TOOLTIP="Controller: ${CONTROLLER}\nMode: ${MODE}${TURBO_INFO}\nGovernor: ${GOVERNOR}\nStatus: Plugged In\nTime left: INF\n--------------------\nWattage: --W\nVoltage: --V\nAmps: --A"
	echo "{\"text\": \"󰚥 AC\", \"percentage\": 100, \"class\": \"desktop-ac\", \"tooltip\": \"$TOOLTIP\"}"
	exit 0
fi

# Read Battery Data
# Read the output lines directly into an array
mapfile -t BAT_DATA < <(cat "$BAT_PATH/capacity" "$BAT_PATH/status" "$BAT_PATH/voltage_now" "$BAT_PATH/power_now" "$BAT_PATH/energy_now" "$BAT_PATH/energy_full" 2>/dev/null)

# Assign variables from the array indices
CAPACITY="${BAT_DATA[0]}"
STATUS="${BAT_DATA[1]}"
V_RAW="${BAT_DATA[2]}"
P_RAW="${BAT_DATA[3]}"
E_NOW="${BAT_DATA[4]}"
E_FULL="${BAT_DATA[5]}"

# Time Calculation
TIME_INFO="Time left: N/A"
if [[ "$P_RAW" -gt 0 ]]; then
	if [[ "$STATUS" == "Discharging" ]]; then
		HOURS=$(echo "scale=2; $E_NOW / $P_RAW" | bc)
		TIME_MIN=$(printf "%.0f" "$(echo "$HOURS * 60" | bc)")
		TIME_INFO="Time left: $((TIME_MIN / 60))h $((TIME_MIN % 60))m"
	elif [[ "$STATUS" == "Charging" ]]; then
		E_DIFF=$((E_FULL - E_NOW))
		HOURS=$(echo "scale=2; $E_DIFF / $P_RAW" | bc)
		TIME_MIN=$(printf "%.0f" "$(echo "$HOURS * 60" | bc)")
		TIME_INFO="Time to full: $((TIME_MIN / 60))h $((TIME_MIN % 60))m"
	fi
elif [[ "$STATUS" == "Full" ]]; then
	TIME_INFO="Time left: --"
fi

# Electricals with leading zero fix
VOLT=$(printf "%.2f" "$(echo "scale=2; ${V_RAW:-0} / 1000000" | bc)")
WATT=$(printf "%.2f" "$(echo "scale=2; ${P_RAW:-0} / 1000000" | bc)")
if (($(echo "$VOLT > 0" | bc -l))); then
	AMPS=$(printf "%.2f" "$(echo "scale=2; $WATT / $VOLT" | bc)")
else
	AMPS="0.00"
fi

# Icons and Classes
VALS=(100 85 65 45 25 0)
ICONS=(" " " " " " " " " " " ")
LVLS=("LVL0" "LVL1" "LVL2" "LVL3" "LVL4" "LVL5")

for i in "${!VALS[@]}"; do
	if [ "$CAPACITY" -ge "${VALS[$i]}" ]; then
		ICON="${ICONS[$i]}"
		CLASS="${LVLS[$i]}"
		break
	fi
done

# Text and Status Overrides
DISPLAY_TEXT="$ICON $CAPACITY%"

if [[ "$STATUS" == "Charging" ]]; then
	ICON="󰔵 "
	DISPLAY_TEXT="$ICON $CAPACITY%"
elif [[ "$STATUS" == "Full" ]] || [[ "$CAPACITY" == 100 ]]; then
	ICON="󰁹󱐋"
	DISPLAY_TEXT="$ICON Full"
fi

# Final Output
TOOLTIP="Controller: ${CONTROLLER}\nMode: ${MODE}${TURBO_INFO}\nGovernor: ${GOVERNOR}\nStatus: $STATUS\n$TIME_INFO\n--------------------\nWattage: ${WATT}W\nVoltage: ${VOLT}V\nAmps: ${AMPS}A"
echo "{\"text\": \"$DISPLAY_TEXT\", \"percentage\": $CAPACITY, \"class\": \"$CLASS\", \"tooltip\": \"$TOOLTIP\"}"
