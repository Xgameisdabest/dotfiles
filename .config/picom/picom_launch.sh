#!/bin/env bash

source ~/.config/dtf-config/config

animations=${animations:-true}
transparent_window_when_unfocus=${transparent_window_when_unfocus:-true}

if [[ $animations == "true" ]] && [[ $transparent_window_when_unfocus == "true" ]]; then
	killall picom
	pidof picom 1> /dev/null || picom --config ~/.config/picom/picom_trans_unfocus.conf &
elif [[ $animations == "true" ]] && [[ $transparent_window_when_unfocus == "false" ]]; then
	killall picom
	pidof picom 1> /dev/null || picom --config ~/.config/picom/picom_no_trans_unfocus.conf &
elif [[ $animations == "false" ]]; then
	killall picom
else
	killall picom
	pidof picom 1> /dev/null || picom --config ~/.config/picom/picom_trans_unfocus.conf &
fi
