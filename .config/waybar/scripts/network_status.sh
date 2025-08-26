#!/usr/bin/env bash

while true; do
    # Get Wi-Fi interface
    iface=$(iw dev | awk '$1=="Interface"{print $2; exit}')

    if [[ -n "$iface" ]]; then
        # Calculate signal strength (percentage)
        strength=$(grep "$iface" /proc/net/wireless | awk '{print int($3*100/70)}')
        strength=${strength:-0}
	
        if (( strength > 0 && strength <= 5 )); then icon="󰤯 "; cls="strength-0";  
        elif (( strength <= 10 )); then icon="󰤯 "; cls="strength-1";
        elif (( strength <= 20 )); then icon="󰤟 "; cls="strength-2";
        elif (( strength <= 30 )); then icon="󰤟 "; cls="strength-3";
        elif (( strength <= 40 )); then icon="󰤢 "; cls="strength-4";
        elif (( strength <= 50 )); then icon="󰤢 "; cls="strength-5";
        elif (( strength <= 60 )); then icon="󰤢 "; cls="strength-6";
        elif (( strength <= 70 )); then icon="󰤨 "; cls="strength-7";
        elif (( strength <= 80 )); then icon="󰤨 "; cls="strength-8";
        else icon="󰤨 "; cls="strength-9";  
        fi

	if (( strength == 0 )); then
    	icon="󰤭 "
    	cls="disconnected"
	fi

        class="$cls"
    fi

    # Output JSON for Waybar
    echo "{\"text\":\"$icon\",\"class\":\"$class\"}"

    sleep 0.5
done

