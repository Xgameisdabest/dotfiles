#!/usr/bin/env bash

source ~/.config/dtf-config/config

polybar_color=${polybar_color:-black}
polybar_compact=${polybar_compact:-false}

killall -q polybar

if [[ $polybar_color == "black" ]] && [[ $polybar_compact == "false" ]]; then
	for m in $(polybar --list-monitors | cut -d":" -f1); do
	    MONITOR=$m polybar --reload main_black &
	done

elif [[ $polybar_color == "white" ]] && [[ $polybar_compact == "false" ]]; then
	for m in $(polybar --list-monitors | cut -d":" -f1); do
	    MONITOR=$m polybar --reload main_white &
	done

elif [[ $polybar_color == "black" ]] && [[ $polybar_compact == "true" ]]; then
	for m in $(polybar --list-monitors | cut -d":" -f1); do
	    MONITOR=$m polybar --reload main_black_compact &
	done

elif [[ $polybar_color == "white" ]] && [[ $polybar_compact == "true" ]]; then
	for m in $(polybar --list-monitors | cut -d":" -f1); do
	    MONITOR=$m polybar --reload main_white_compact &
	done

else
	for m in $(polybar --list-monitors | cut -d":" -f1); do
	    MONITOR=$m polybar --reload main_black &
	done

fi
