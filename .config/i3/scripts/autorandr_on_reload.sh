#!/bin/bash

source ~/.config/dtf-config/config

autorandr_when_reload=${autorandr_when_reload:-false}

if [[ $autorandr_when_reload == "true" ]]; then
	autorandr --change --default default
fi
