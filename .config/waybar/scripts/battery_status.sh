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
read -r CAPACITY STATUS V_RAW P_RAW E_NOW E_FULL < <(cat "$BAT_PATH/capacity" "$BAT_PATH/status" "$BAT_PATH/voltage_now" "$BAT_PATH/power_now" "$BAT_PATH/energy_now" "$BAT_PATH/energy_full" 2>/dev/null | tr '\n' ' ')

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

[[ "$STATUS" == "Charging" ]] && ICON="󰔵 "
[[ "$STATUS" == "Full" ]] && ICON="󱐋 "

# Time Remaining
if [ "${P_RAW:-0}" -gt 0 ]; then
	if [[ "$STATUS" == "Discharging" ]]; then
		VAL=$(echo "scale=5; $E_NOW / $P_RAW" | bc)
	elif [[ "$STATUS" == "Charging" ]]; then
		VAL=$(echo "scale=5; ($E_FULL - $E_NOW) / $P_RAW" | bc)
	fi

	if [ -n "$VAL" ]; then
		H=$(echo "$VAL/1" | bc)
		M=$(echo "($VAL-$H)*60/1" | bc)
		TIME_INFO="Time: ${H}h ${M}m"
	else
		TIME_INFO="Fully Charged"
	fi
else
	TIME_INFO="Plugged In"
fi

# Final Output
TOOLTIP="Controller: ${CONTROLLER}\nMode: ${MODE}${TURBO_INFO}\nGovernor: ${GOVERNOR}\nStatus: $STATUS\n$TIME_INFO\n--------------------\nWattage: ${WATT}W\nVoltage: ${VOLT}V\nAmps: ${AMPS}A"
echo "{\"text\": \"$ICON $CAPACITY%\", \"percentage\": $CAPACITY, \"class\": \"$CLASS\", \"tooltip\": \"$TOOLTIP\"}"
