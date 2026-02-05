#!/bin/bash

BAT_PATH="/sys/class/power_supply/BAT0"
[ ! -d "$BAT_PATH" ] && BAT_PATH="/sys/class/power_supply/BAT1"

CAPACITY=$(cat "$BAT_PATH/capacity")
STATUS=$(cat "$BAT_PATH/status")

VOLT=$(echo "scale=2; $(cat $BAT_PATH/voltage_now) / 1000000" | bc)
if [ -f "$BAT_PATH/power_now" ]; then
	WATT=$(echo "scale=2; $(cat $BAT_PATH/power_now) / 1000000" | bc)
	AMPS=$(echo "scale=2; $WATT / $VOLT" | bc)
else
	AMPS=$(echo "scale=2; $(cat $BAT_PATH/current_now) / 1000000" | bc)
	WATT=$(echo "scale=2; $AMPS * $VOLT" | bc)
fi

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

[ "$STATUS" = "Charging" ] && ICON="󰔵 "
[ "$STATUS" = "Full" ] && ICON="󱐋 "

ENERGY_NOW=$(cat $BAT_PATH/energy_now)
ENERGY_FULL=$(cat $BAT_PATH/energy_full)
POWER_NOW=$(cat $BAT_PATH/power_now)

if [ "$POWER_NOW" -gt 0 ]; then
	if [ "$STATUS" = "Discharging" ]; then
		VAL=$(echo "scale=5; $ENERGY_NOW / $POWER_NOW" | bc)
		H=$(echo "$VAL / 1" | bc)
		M=$(echo "($VAL - $H) * 60 / 1" | bc)
		TIME_INFO="Time Left: ${H}h ${M}m"
	elif [ "$STATUS" = "Charging" ]; then
		VAL=$(echo "scale=5; ($ENERGY_FULL - $ENERGY_NOW) / $POWER_NOW" | bc)
		H=$(echo "$VAL / 1" | bc)
		M=$(echo "($VAL - $H) * 60 / 1" | bc)
		TIME_INFO="Time till full: ${H}h ${M}m"
	else
		TIME_INFO="Fully Charged"
	fi
else
	TIME_INFO="Calculating..."
fi

if command -v powerprofilesctl &>/dev/null; then
	MODE=$(powerprofilesctl get)
else
	MODE=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)
fi

TOOLTIP="Mode: ${MODE}\nStatus: $STATUS\n$TIME_INFO\nWattage: ${WATT}W\nVoltage: ${VOLT}V\nAmps: ${AMPS}A"

echo "{\"text\": \"$ICON $CAPACITY%\", \"percentage\": $CAPACITY, \"class\": \"$CLASS\", \"tooltip\": \"$TOOLTIP\"}"
