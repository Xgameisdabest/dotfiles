#!/bin/env bash

source ~/.config/dtf-config/config

picom_enable=${picom_enable:-true}

if [[ $picom_enable == "true" ]]; then
	pidof picom 1> /dev/null || picom --config ~/.config/picom/picom.conf &
elif [[ $picom_enable == "false" ]]; then
	killall picom
else
	pidof picom 1> /dev/null || picom --config ~/.config/picom/picom.conf &
fi
