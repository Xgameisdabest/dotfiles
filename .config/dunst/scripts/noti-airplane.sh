#!/bin/bash
sleep 0.2
wifi="$(nmcli r wifi | awk 'FNR = 2 {print $1}')"
if [[ "$wifi" == "disabled" ]]; then
	notify-send '󰀝 Airplane Mode: Active'
elif [[ "$wifi" == "enabled" ]]; then
	notify-send '󰀝 Airplane Mode: Inactive'
fi
