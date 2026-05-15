#!/bin/bash

source ~/.config/dtf-config/config

easyeffects_onstart=${easyeffects_onstart:-true}

if [[ $easyeffects_onstart == true ]]; then
	easyeffects --hide-window --service-mode
fi
