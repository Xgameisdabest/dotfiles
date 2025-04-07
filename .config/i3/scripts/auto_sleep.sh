#!/usr/bin/bash

source ~/.config/dtf-config/config

auto_sleep=${auto_sleep:-true}

if [[ $auto_sleep == "false" ]]; then
	xset s off
	xset -dpms
	notify-send "Auto Screen Timeout Disabled 󱡥"
else
	xset s 600
	xset +dpms
	xset dpms 600 600 600
	notify-send "Auto Screen Timeout Enabled 󰾨"
fi
