#!/bin/sh

#this script is made by eric murphy, go check him out on youtube

# Send a notification when the laptop is plugged in/unplugged
# Add the following to /etc/udev/rules.d/60-power.rules (replace USERNAME with your user)

# ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="0", ENV{DISPLAY}=":0", ENV{XAUTHORITY}="/home/USERNAME/.Xauthority" RUN+="/usr/bin/su USERNAME -c '/home/USERNAME/.config/dunst/bat_status.sh discharging'"
# ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="1", ENV{DISPLAY}=":0", ENV{XAUTHORITY}="/home/USERNAME/.Xauthority" RUN+="/usr/bin/su USERNAME -c '/home/USERNAME/.config/dunst/bat_status.sh charging'"

export XAUTHORITY=~/.Xauthority
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

BATTERY_STATE=$1
BATTERY_LEVEL=$(acpi -b | grep "Battery 0" | grep -P -o '[0-9]+(?=%)')
# My battery takes a couple of seconds to recognize as charging, so this is a hacky way to deal with it
case "$BATTERY_STATE" in
	"charging") BATTERY_CHARGING="Charging 󰂅" ;;
	"discharging") BATTERY_CHARGING="Discharging 󰁹" ;;
esac

# Send notification
notify-send "${BATTERY_CHARGING}" "${BATTERY_LEVEL}% of battery charged." -t 5000
