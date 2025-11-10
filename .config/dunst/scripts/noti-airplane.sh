#!/bin/bash
sleep 0.2
wifi="$(nmcli r wifi | awk 'FNR = 2 {print $1}')"
if [[ "$wifi" == "disabled" ]]; then
	notify-send '󰀝 Airplane Mode: Active'
	paplay $CUSTOM_SOUND_PATH/message.oga
elif [[ "$wifi" == "enabled" ]]; then
	notify-send '󰀝 Airplane Mode: Inactive'
	paplay $CUSTOM_SOUND_PATH/message.oga
fi
