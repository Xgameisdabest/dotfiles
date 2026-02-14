#!/usr/bin/env bash

# Wi-Fi signal icons
icons=("󰤯 " "󰤯 " "󰤟 " "󰤟 " "󰤢 " "󰤢 " "󰤢 " "󰤨 " "󰤨 " "󰤨 ")
classes=("strength-0" "strength-1" "strength-2" "strength-3" "strength-4" "strength-5" "strength-6" "strength-7" "strength-8" "strength-9")

prev_rx=0
prev_tx=0
prev_time=0

# Helper function for human-readable speeds
hr_speed() {
	local bytes=$1
	if ((bytes > 1048576)); then
		printf "%.1f MB/s" "$(echo "scale=1; $bytes/1048576" | bc)"
	elif ((bytes > 1024)); then
		printf "%.0f KB/s" "$(echo "$bytes/1024" | bc)"
	else
		printf "%d B/s" "$bytes"
	fi
}

while true; do
	# 1. Identify active interface (Prioritize Ethernet)
	iface=$(ip -o link show | awk -F': ' '$3 ~ /UP/ && $2 ~ /^(en|eth)/ {print $2; exit}')
	is_eth=true

	if [[ -z "$iface" ]]; then
		iface=$(iw dev | awk '$1=="Interface"{print $2; exit}')
		is_eth=false
	fi

	# 2. Check if interface exists and is up
	if [[ -n "$iface" && -d "/sys/class/net/$iface" ]]; then
		ipaddr=$(ip addr show dev "$iface" | awk '/inet / {print $2; exit}' | cut -d'/' -f1)
		ipaddr=${ipaddr:-"N/A"}

		# Network Stats
		rx_bytes=$(<"/sys/class/net/$iface/statistics/rx_bytes")
		tx_bytes=$(<"/sys/class/net/$iface/statistics/tx_bytes")
		cur_time=$(date +%s)

		# Calculate Speeds
		if ((prev_time > 0)); then
			interval=$((cur_time - prev_time))
			rx_rate=$(((rx_bytes - prev_rx) / interval))
			tx_rate=$(((tx_bytes - prev_tx) / interval))

			dl_speed=$(hr_speed $rx_rate)
			ul_speed=$(hr_speed $tx_rate)
			net_speed=$(hr_speed $((rx_rate + tx_rate)))
		fi

		# Logic for Ethernet vs Wi-Fi Display
		if [ "$is_eth" = true ]; then
			icon="󰈀 "
			class="ethernet"
			tooltip="Ethernet\nIP: $ipaddr\n\n↓ Download: $dl_speed\n↑ Upload: $ul_speed\n~ Speed: $net_speed"
		else
			strength=$(awk -v iface="$iface" '$1==iface ":" {print int($3*100/70)}' /proc/net/wireless)
			strength=${strength:-0}
			ssid=$(iw dev "$iface" link | awk -F': ' '/SSID/ {print $2}')

			index=$((strength * 9 / 100))
			icon="${icons[index]}"
			class="${classes[index]}"
			tooltip="SSID: ${ssid:-N/A}\nIP: $ipaddr\n\n↓ $dl_speed\n↑ $ul_speed"
		fi

		# Update persistent vars
		prev_rx=$rx_bytes
		prev_tx=$tx_bytes
		prev_time=$cur_time

		# Send JSON (using || true to ignore broken pipe errors)
		echo "{\"text\":\"$icon\",\"tooltip\":\"$tooltip\",\"class\":\"$class\"}" || true
	else
		echo '{"text":"󰤭 ","class":"disconnected","tooltip":"No interface"}' || true
	fi

	sleep 4
done
