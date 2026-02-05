#!/bin/bash

# Define paths
BAT_PATH="/sys/class/power_supply/BAT0"
[ ! -d "$BAT_PATH" ] && BAT_PATH="/sys/class/power_supply/BAT1"

# Get Power Mode (Check services in order of priority)
if hash powerprofilesctl 2>/dev/null; then
	MODE=$(powerprofilesctl get)
elif hash auto-cpufreq 2>/dev/null; then
	# Get mode from auto-cpufreq
	MODE_VAL=$(auto-cpufreq --get-state)

	# Get Turbo status directly from kernel (0 = on/enabled, 1 = off/disabled)
	# This path works for most modern Intel/AMD CPUs
	if [ -f "/sys/devices/system/cpu/intel_pstate/no_turbo" ]; then
		TURBO_RAW=$(cat /sys/devices/system/cpu/intel_pstate/no_turbo)
		[ "$TURBO_RAW" = "0" ] && TURBO="on" || TURBO="off"
	elif [ -f "/sys/devices/system/cpu/cpufreq/boost" ]; then
		TURBO_RAW=$(cat /sys/devices/system/cpu/cpufreq/boost)
		[ "$TURBO_RAW" = "1" ] && TURBO="on" || TURBO="off"
	else
		TURBO="N/A"
	fi
	MODE="${MODE_VAL} (Turbo: ${TURBO})"
elif [ -f "/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" ]; then
	MODE=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)
else
	MODE="N/A"
fi

# 2. Desktop Handling
if [ ! -d "$BAT_PATH" ]; then
	TOOLTIP="Mode: ${MODE}\nStatus: Plugged In\nTime left: INF\n--------------------\nWattage: --W\nVoltage: --V\nAmps: --A"
	echo "{\"text\": \"󰚥 AC\", \"percentage\": 100, \"class\": \"desktop-ac\", \"tooltip\": \"$TOOLTIP\"}"
	exit 0
fi

# 3. Read Battery Data
read -r CAPACITY STATUS VOLT_RAW PWR_RAW ENG_NOW ENG_FULL < <(cat "$BAT_PATH/capacity" "$BAT_PATH/status" "$BAT_PATH/voltage_now" "$BAT_PATH/power_now" "$BAT_PATH/energy_now" "$BAT_PATH/energy_full" 2>/dev/null | tr '\n' ' ')

# 4. Calculate Electricals & Format Leading Zeros
# We use printf to ensure .55 becomes 0.55
VOLT=$(printf "%.2f" "$(echo "scale=2; $VOLT_RAW / 1000000" | bc)")
WATT=$(printf "%.2f" "$(echo "scale=2; $PWR_RAW / 1000000" | bc)")
AMPS=$(printf "%.2f" "$(echo "scale=2; $WATT / $VOLT" | bc)")

# 5. Logic for Icons and Classes
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

[ "$STATUS" = "Charging" ] && ICON="󰔵 "
[ "$STATUS" = "Full" ] && ICON="󱐋 "

# 6. Calculate Time Remaining
if [ "${PWR_RAW:-0}" -gt 0 ]; then
	if [ "$STATUS" = "Discharging" ]; then
		VAL=$(echo "scale=5; $ENG_NOW / $PWR_RAW" | bc)
	elif [ "$STATUS" = "Charging" ]; then
		VAL=$(echo "scale=5; ($ENG_FULL - $ENG_NOW) / $PWR_RAW" | bc)
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

# 7. Final JSON Output
TOOLTIP="Mode: ${MODE}\nStatus: $STATUS\n$TIME_INFO\n--------------------\nWattage: ${WATT}W\nVoltage: ${VOLT}V\nAmps: ${AMPS}A"
echo "{\"text\": \"$ICON $CAPACITY%\", \"percentage\": $CAPACITY, \"class\": \"$CLASS\", \"tooltip\": \"$TOOLTIP\"}"
