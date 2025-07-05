#!/usr/bin/env bash

source ~/.config/dtf-config/config


# Try default route
DEFAULT_IFACE=$(ip route | awk '/^default/ {print $5}' | head -n1)

# Check if it's wireless
if [[ -n "$DEFAULT_IFACE" && -d "/sys/class/net/$DEFAULT_IFACE/wireless" ]]; then
  export DEFAULT_NETWORK_INTERFACE="$DEFAULT_IFACE"
else
  # Fallback: any interface matching "wl*"
  FALLBACK_IFACE=$(ls /sys/class/net | grep '^wl' | head -n1)
  export DEFAULT_NETWORK_INTERFACE="$FALLBACK_IFACE"
fi

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
