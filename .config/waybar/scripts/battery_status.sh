#!/bin/bash

# Define paths
BAT_PATH="/sys/class/power_supply/BAT0"
[ ! -d "$BAT_PATH" ] && BAT_PATH="/sys/class/power_supply/BAT1"

# Get Power Mode (Prioritized Check)
if hash powerprofilesctl 2>/dev/null; then
	MODE=$(powerprofilesctl get)
elif hash auto-cpufreq 2>/dev/null; then
	MODE=$(auto-cpufreq --get-state | sed -n 's/.*mode: //p')
else
	MODE=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 2>/dev/null || echo "N/A")
fi

# Desktop Handling
if [ ! -d "$BAT_PATH" ]; then
	TOOLTIP="Mode: ${MODE}\nStatus: Plugged In\nTime left: INF\n--------------------\nWattage: --W\nVoltage: --V\nAmps: --A"
	echo "{\"text\": \"󰚥 AC\", \"percentage\": 100, \"class\": \"desktop-ac\", \"tooltip\": \"$TOOLTIP\"}"
	exit 0
fi

# Read Battery Data (Using internal variables to minimize 'cat' calls)
read -r CAPACITY STATUS VOLT_NOW POWER_NOW ENERGY_NOW ENERGY_FULL < <(cat "$BAT_PATH/capacity" "$BAT_PATH/status" "$BAT_PATH/voltage_now" "$BAT_PATH/power_now" "$BAT_PATH/energy_now" "$BAT_PATH/energy_full" 2>/dev/null | tr '\n' ' ')

# Calculate Electricals
VOLT=$(echo "scale=2; $VOLT_NOW / 1000000" | bc)
WATT=$(echo "scale=2; $POWER_NOW / 1000000" | bc)
AMPS=$(echo "scale=2; $WATT / $VOLT" | bc)

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

[ "$STATUS" = "Charging" ] && ICON="󰔵 "
[ "$STATUS" = "Full" ] && ICON="󱐋 "

# Calculate Time Remaining
if [ "${POWER_NOW:-0}" -gt 0 ]; then
	if [ "$STATUS" = "Discharging" ]; then
		VAL=$(echo "scale=5; $ENERGY_NOW / $POWER_NOW" | bc)
		TIME_INFO="Time Left: $(echo "$VAL/1" | bc)h $(echo "($VAL-($VAL/1))*60/1" | bc)m"
	elif [ "$STATUS" = "Charging" ]; then
		VAL=$(echo "scale=5; ($ENERGY_FULL - $ENERGY_NOW) / $POWER_NOW" | bc)
		TIME_INFO="Time till full: $(echo "$VAL/1" | bc)h $(echo "($VAL-($VAL/1))*60/1" | bc)m"
	else
		TIME_INFO="Fully Charged"
	fi
else
	TIME_INFO="Plugged In"
fi

# JSON Output
TOOLTIP="Mode: ${MODE}\nStatus: $STATUS\n$TIME_INFO\n--------------------\nWattage: ${WATT}W\nVoltage: ${VOLT}V\nAmps: ${AMPS}A"
echo "{\"text\": \"$ICON $CAPACITY%\", \"percentage\": $CAPACITY, \"class\": \"$CLASS\", \"tooltip\": \"$TOOLTIP\"}"
