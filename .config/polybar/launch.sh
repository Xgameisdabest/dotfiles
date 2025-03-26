#!/usr/bin/env bash

source ~/.config/dtf-config/config

polybar_color=${polybar_color:-black}
polybar_compact=${polybar_compact:-false}
polybar_top=${polybar_top:-false}

killall -q polybar

if [[ $polybar_color == "black" ]] && [[ $polybar_compact == "false" ]] && [[ $polybar_top == "false" ]]; then
	for m in $(polybar --list-monitors | cut -d":" -f1); do
	    MONITOR=$m polybar --reload main_black_bottom &
	done

elif [[ $polybar_color == "white" ]] && [[ $polybar_compact == "false" ]] && [[ $polybar_top == "false" ]]; then
	for m in $(polybar --list-monitors | cut -d":" -f1); do
	    MONITOR=$m polybar --reload main_white_bottom &
	done

elif [[ $polybar_color == "black" ]] && [[ $polybar_compact == "true" ]] && [[ $polybar_top == "false" ]]; then
	for m in $(polybar --list-monitors | cut -d":" -f1); do
	    MONITOR=$m polybar --reload main_black_compact_bottom &
	done

elif [[ $polybar_color == "white" ]] && [[ $polybar_compact == "true" ]] && [[ $polybar_top == "false" ]]; then
	for m in $(polybar --list-monitors | cut -d":" -f1); do
	    MONITOR=$m polybar --reload main_white_compact_bottom &
	done

elif [[ $polybar_color == "black" ]] && [[ $polybar_compact == "false" ]] && [[ $polybar_top == "true" ]]; then
	for m in $(polybar --list-monitors | cut -d":" -f1); do
	    MONITOR=$m polybar --reload main_black_top &
	done

elif [[ $polybar_color == "white" ]] && [[ $polybar_compact == "false" ]] && [[ $polybar_top == "true" ]]; then
	for m in $(polybar --list-monitors | cut -d":" -f1); do
	    MONITOR=$m polybar --reload main_white_top &
	done

elif [[ $polybar_color == "black" ]] && [[ $polybar_compact == "true" ]] && [[ $polybar_top == "true" ]]; then
	for m in $(polybar --list-monitors | cut -d":" -f1); do
	    MONITOR=$m polybar --reload main_black_compact_top &
	done

elif [[ $polybar_color == "white" ]] && [[ $polybar_compact == "true" ]] && [[ $polybar_top == "true" ]]; then
	for m in $(polybar --list-monitors | cut -d":" -f1); do
	    MONITOR=$m polybar --reload main_white_compact_top &
	done

else
	for m in $(polybar --list-monitors | cut -d":" -f1); do
	    MONITOR=$m polybar --reload main_black_bottom &
	done

fi
