#!/bin/bash

source ~/.config/dtf-config/config

welcome_notification=${welcome_notification:-false}

if [[ $welcome_notification == "true" ]]; then
	notify-send -t 5000 "Dotfiles V4" "Welcome back $(whoami)!"
	paplay ~/.config/dunst/scripts/sounds/desktop-login.oga
fi
