#!/bin/sh
if [ $(nmcli -fields WIFI g | grep "enabled" | wc -c) -eq 0 ] 
then
	nmcli radio wifi on
	notify-send "Wifi Enabled 󱚽 " -t 850
elif [ $(nmcli -fields WIFI g | grep "enabled" | wc -c) != 0 ]
then
	nmcli radio wifi off
	notify-send "Wifi Disabled 󱛅 " -t 850
fi
