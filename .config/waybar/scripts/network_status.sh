#!/usr/bin/env bash

# Icons and classes by strength index
icons=("󰤯" "󰤯" "󰤟" "󰤟" "󰤢" "󰤢" "󰤢" "󰤨" "󰤨" "󰤨")
classes=("strength-0" "strength-1" "strength-2" "strength-3" "strength-4" "strength-5" "strength-6" "strength-7" "strength-8" "strength-9")

prev_strength=-1

while true; do
    # Get Wi-Fi interface
    iface=$(iw dev | awk '$1=="Interface"{print $2; exit}')

    if [[ -n "$iface" ]]; then
        # Get signal strength in %
        strength=$(awk -v iface="$iface" '$1==iface ":" {print int($3*100/70)}' /proc/net/wireless)
        strength=${strength:-0}

        # Only update if strength changed
        if (( strength != prev_strength )); then
            prev_strength=$strength

            if (( strength == 0 )); then
                icon="󰤭"
                class="disconnected"
            else
                index=$(( strength * 9 / 100 ))
                icon="${icons[index]}"
                class="${classes[index]}"
            fi

            # Output JSON to Waybar
            echo "{\"text\":\"$icon\",\"class\":\"$class\"}"
        fi
    else
        # Interface not found
        if (( prev_strength != 0 )); then
            prev_strength=0
            echo '{"text":"󰤭","class":"disconnected"}'
        fi
    fi

    # Poll every 0.5s (can reduce CPU while still responsive)
    sleep 0.5
done

