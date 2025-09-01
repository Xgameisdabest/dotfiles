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

bar_color=${bar_color:-black}
bar_compact=${bar_compact:-false}
bar_top=${bar_top:-false}

killall -q polybar

if [[ $bar_color == "black" ]] && [[ $bar_compact == "false" ]] && [[ $bar_top == "false" ]]; then
	for m in $(polybar --list-monitors | cut -d":" -f1); do
	    MONITOR=$m polybar --reload main_black_bottom &
	done

elif [[ $bar_color == "white" ]] && [[ $bar_compact == "false" ]] && [[ $bar_top == "false" ]]; then
	for m in $(polybar --list-monitors | cut -d":" -f1); do
	    MONITOR=$m polybar --reload main_white_bottom &
	done

elif [[ $bar_color == "black" ]] && [[ $bar_compact == "true" ]] && [[ $bar_top == "false" ]]; then
	for m in $(polybar --list-monitors | cut -d":" -f1); do
	    MONITOR=$m polybar --reload main_black_compact_bottom &
	done

elif [[ $bar_color == "white" ]] && [[ $bar_compact == "true" ]] && [[ $bar_top == "false" ]]; then
	for m in $(polybar --list-monitors | cut -d":" -f1); do
	    MONITOR=$m polybar --reload main_white_compact_bottom &
	done

elif [[ $bar_color == "black" ]] && [[ $bar_compact == "false" ]] && [[ $bar_top == "true" ]]; then
	for m in $(polybar --list-monitors | cut -d":" -f1); do
	    MONITOR=$m polybar --reload main_black_top &
	done

elif [[ $bar_color == "white" ]] && [[ $bar_compact == "false" ]] && [[ $bar_top == "true" ]]; then
	for m in $(polybar --list-monitors | cut -d":" -f1); do
	    MONITOR=$m polybar --reload main_white_top &
	done

elif [[ $bar_color == "black" ]] && [[ $bar_compact == "true" ]] && [[ $bar_top == "true" ]]; then
	for m in $(polybar --list-monitors | cut -d":" -f1); do
	    MONITOR=$m polybar --reload main_black_compact_top &
	done

elif [[ $bar_color == "white" ]] && [[ $bar_compact == "true" ]] && [[ $bar_top == "true" ]]; then
	for m in $(polybar --list-monitors | cut -d":" -f1); do
	    MONITOR=$m polybar --reload main_white_compact_top &
	done

else
	for m in $(polybar --list-monitors | cut -d":" -f1); do
	    MONITOR=$m polybar --reload main_black_bottom &
	done

fi
