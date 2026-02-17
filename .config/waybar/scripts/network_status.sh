#!/usr/bin/env bash

# Wi-Fi signal icons
icons=("󰤯 " "󰤯 " "󰤟 " "󰤟 " "󰤢 " "󰤢 " "󰤢 " "󰤨 " "󰤨 " "󰤨 ")
classes=("strength-0" "strength-1" "strength-2" "strength-3" "strength-4" "strength-5" "strength-6" "strength-7" "strength-8" "strength-9")

prev_rx=0
prev_tx=0
prev_time=0

while sleep 4; do
	# Detect Ethernet interface (that is UP and not loopback)
	eth_iface=$(ip -o link show | awk -F': ' '/^[0-9]+: (en|eth)/ {print $2;}')
	eth_up=$(ip link show "$eth_iface" | awk '/state/ {print $9}')
	# eth_up="UP"

	if [[ -n "$eth_iface" && "$eth_up" =~ "UP" ]]; then
		# Ethernet is active → show ethernet icon
		ipaddr=$(ip addr show dev "$eth_iface" | awk '/inet / {print $2; exit}' | cut -d'/' -f1)
		ipaddr=${ipaddr:-"N/A"}

		# Network counters
		rx_bytes=$(</sys/class/net/$eth_iface/statistics/rx_bytes)
		tx_bytes=$(</sys/class/net/$eth_iface/statistics/tx_bytes)
		cur_time=$(date +%s)

		if ((prev_time > 0)); then
			interval=$((cur_time - prev_time))
			if ((interval > 0)); then
				rx_rate=$(((rx_bytes - prev_rx) / interval))
				tx_rate=$(((tx_bytes - prev_tx) / interval))

				# Human-readable speed
				hr_speed() {
					if (($1 > 1048576)); then
						printf "%.1f MB/s" "$(echo "$1/1048576" | bc -l)"
					elif (($1 > 1024)); then
						printf "%.0f KB/s" "$(echo "$1/1024" | bc -l)"
					else
						printf "%d B/s" "$1"
					fi
				}

				dl_speed=$(hr_speed $rx_rate)
				ul_speed=$(hr_speed $tx_rate)
				total_rate=$((rx_rate + tx_rate))
				net_speed=$(hr_speed $total_rate)

				tooltip="Ethernet\nIP: $ipaddr\n\n↓ Download: $dl_speed\n↑ Upload:   $ul_speed\n󰹹 Netspeed: $net_speed"
			fi
		fi

		prev_rx=$rx_bytes
		prev_tx=$tx_bytes
		prev_time=$cur_time

		echo "{\"text\":\"󰈀\",\"class\":\"ethernet\",\"tooltip\":\"${tooltip}\"}"
		continue
	fi

	# If no Ethernet → fallback to Wi-Fi logic
	iface=$(iw dev | awk '$1=="Interface"{print $2; exit}')

	if [[ -n "$iface" && -d "/sys/class/net/$iface" ]]; then
		strength=$(awk -v iface="$iface" '$1==iface ":" {print int($3*100/70)}' /proc/net/wireless)
		strength=${strength:-0}

		ssid=$(iw dev "$iface" link | grep 'SSID' | awk -F': ' '{print $2}')
		ssid=${ssid:-"Unknown"}

		ipaddr=$(ip addr show dev "$iface" | awk '/inet / {print $2; exit}' | cut -d'/' -f1)
		ipaddr=${ipaddr:-"N/A"}

		tooltip="SSID: $ssid\nIP: $ipaddr"

		rx_bytes=$(</sys/class/net/$iface/statistics/rx_bytes)
		tx_bytes=$(</sys/class/net/$iface/statistics/tx_bytes)
		cur_time=$(date +%s)

		if ((prev_time > 0)); then
			interval=$((cur_time - prev_time))
			if ((interval > 0)); then
				rx_rate=$(((rx_bytes - prev_rx) / interval))
				tx_rate=$(((tx_bytes - prev_tx) / interval))

				hr_speed() {
					if (($1 > 1048576)); then
						printf "%.1f MB/s" "$(echo "$1/1048576" | bc -l)"
					elif (($1 > 1024)); then
						printf "%.0f KB/s" "$(echo "$1/1024" | bc -l)"
					else
						printf "%d B/s" "$1"
					fi
				}

				dl_speed=$(hr_speed $rx_rate)
				ul_speed=$(hr_speed $tx_rate)
				total_rate=$((rx_rate + tx_rate))
				net_speed=$(hr_speed $total_rate)

				tooltip="$tooltip\n\n↓ Download: $dl_speed\n↑ Upload:   $ul_speed\n󰹹 Netspeed: $net_speed"
			fi
		fi

		prev_rx=$rx_bytes
		prev_tx=$tx_bytes
		prev_time=$cur_time

		if ((strength == 0)); then
			icon="󰤭 "
			class="disconnected"
		else
			index=$((strength * 9 / 100))
			icon="${icons[index]}"
			class="${classes[index]}"
		fi

		echo "{\"text\":\"$icon\",\"tooltip\":\"$tooltip\",\"class\":\"$class\"}"
	else
		echo '{"text":"󰤭 ","class":"disconnected","tooltip":"No interface"}'
	fi
done
