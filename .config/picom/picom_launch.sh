#!/bin/env bash

source ~/.config/dtf-config/config

picom_enable=${picom_enable:-true}
transparent_window_when_unfocus=${transparent_window_when_unfocus:-true}

if [[ $picom_enable == "true" ]] && [[ $transparent_window_when_unfocus == "true" ]]; then
	pidof picom 1> /dev/null || picom --config ~/.config/picom/picom_trans_unfocus.conf &
	killall picom
elif [[ $picom_enable == "true" ]] && [[ $transparent_window_when_unfocus == "false" ]]; then
	pidof picom 1> /dev/null || picom --config ~/.config/picom/picom_no_trans_unfocus.conf &
	killall picom
elif [[ $picom_enable == "false" ]]; then
	killall picom
else
	pidof picom 1> /dev/null || picom --config ~/.config/picom/picom_trans_unfocus.conf &
fi
