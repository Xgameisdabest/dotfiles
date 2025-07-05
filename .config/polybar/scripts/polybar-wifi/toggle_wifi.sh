#!/bin/sh
if [ $(nmcli -fields WIFI g | grep "enabled" | wc -c) -eq 0 ] 
then
	nmcli radio all on
	notify-send "Wifi Enabled 󱚽 " -t 850
elif [ $(nmcli -fields WIFI g | grep "enabled" | wc -c) != 0 ]
then
	nmcli radio all off
	notify-send "Wifi Disabled 󱛅 " -t 850
fi
