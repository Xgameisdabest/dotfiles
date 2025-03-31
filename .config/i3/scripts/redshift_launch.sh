#!/bin/bash

source ~/.config/dtf-config/config

autostart_night_mode=${autostart_night_mode:-false}

if [[ $autostart_night_mode == "true" ]]; then
	redshift -PO 4800
else
	redshift -x
fi
