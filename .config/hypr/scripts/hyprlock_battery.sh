#!/bin/bash

# Define the battery path
BAT_PATH="/sys/class/power_supply/BAT0"

# Immediate exit if battery directory doesn't exist
if [ ! -d "$BAT_PATH" ]; then
	exit 0
fi

# Fetch values
battery_percentage=$(cat "$BAT_PATH/capacity" 2>/dev/null || echo 0)
battery_status=$(cat "$BAT_PATH/status" 2>/dev/null || echo "Unknown")

# Define Hex Colors (Hyprlock likes these)
green="#a6e3a1"
yellow="#f9e2af"
light_green="#94e2d5"
light_red="#f38ba8"
red="#ff6f91"

reset_color="#ffffff"

# Determine Icon and Color
if [ "$battery_percentage" -ge 85 ]; then
	icon=" "
	color=$green
elif [ "$battery_percentage" -ge 65 ]; then
	icon=" "
	color=$light_green
elif [ "$battery_percentage" -ge 45 ]; then
	icon=" "
	color=$yellow
elif [ "$battery_percentage" -ge 25 ]; then
	icon=" "
	color=$light_red
else
	icon=" "
	color=$red
fi

# Check battery status
if [ $battery_status == "Charging" ]; then
	icon="󰔵 "
elif [ $battery_status == "Full" ] || [ $battery_percentage == 100 ]; then
	icon="󰁹󱐋"
fi

# Output with Pango Markup
echo "<span foreground='$color'>$icon<span foreground='$reset_color'> $battery_percentage%</span></span>"
