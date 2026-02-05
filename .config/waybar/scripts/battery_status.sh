#!/bin/bash

BAT_PATH="/sys/class/power_supply/BAT0"
[ ! -d "$BAT_PATH" ] && BAT_PATH="/sys/class/power_supply/BAT1"

CAPACITY=$(cat "$BAT_PATH/capacity")
STATUS=$(cat "$BAT_PATH/status")

# Get Raw Data (Converted from micro-units)
VOLT=$(echo "scale=2; $(cat $BAT_PATH/voltage_now) / 1000000" | bc)
# Some systems use power_now (Watts), others use current_now (Amps)
if [ -f "$BAT_PATH/power_now" ]; then
	WATT=$(echo "scale=2; $(cat $BAT_PATH/power_now) / 1000000" | bc)
	AMPS=$(echo "scale=2; $WATT / $VOLT" | bc)
else
	AMPS=$(echo "scale=2; $(cat $BAT_PATH/current_now) / 1000000" | bc)
	WATT=$(echo "scale=2; $AMPS * $VOLT" | bc)
fi

# Logic for Icons and Classes
if [ "$CAPACITY" -eq 100 ]; then
	ICON=" "
	CLASS="LVL0"
elif [ "$CAPACITY" -gt 85 ]; then
	ICON=" "
	CLASS="LVL1"
elif [ "$CAPACITY" -gt 65 ]; then
	ICON=" "
	CLASS="LVL2"
elif [ "$CAPACITY" -gt 45 ]; then
	ICON=" "
	CLASS="LVL3"
elif [ "$CAPACITY" -gt 25 ]; then
	ICON=" "
	CLASS="LVL4"
else
	ICON=" "
	CLASS="LVL5"
fi

# Charging Icons
[ "$STATUS" = "Charging" ] && ICON="󰔵 "
[ "$STATUS" = "Full" ] && ICON="󱐋 "

# Calculate Time Remaining (Estimate)
ENERGY_NOW=$(cat $BAT_PATH/energy_now)
ENERGY_FULL=$(cat $BAT_PATH/energy_full)
POWER_NOW=$(cat $BAT_PATH/power_now)

if [ "$POWER_NOW" -gt 0 ]; then
	if [ "$STATUS" = "Discharging" ]; then
		HOURS=$(echo "scale=2; $ENERGY_NOW / $POWER_NOW" | bc)
		TIME_INFO="Time Left: ${HOURS}h"
	elif [ "$STATUS" = "Charging" ]; then
		HOURS=$(echo "scale=2; ($ENERGY_FULL - $ENERGY_NOW) / $POWER_NOW" | bc)
		TIME_INFO="Time till full: ${HOURS}h"
	else
		TIME_INFO="Fully Charged"
	fi
else
	TIME_INFO="Calculating..."
fi

# Construct Tooltip Text
TOOLTIP="Status: $STATUS\nVoltage: ${VOLT}V\nWattage: ${WATT}W\nAmps: ${AMPS}A\n$TIME_INFO"

# Output JSON
echo "{\"text\": \"$ICON $CAPACITY%\", \"percentage\": $CAPACITY, \"class\": \"$CLASS\", \"tooltip\": \"$TOOLTIP\"}"
