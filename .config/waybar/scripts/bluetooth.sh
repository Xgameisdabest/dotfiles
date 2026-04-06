#!/usr/bin/env bash

get_device_icon() {
	local uuid="$1"
	local icon_dev_type
	icon_dev_type=$(bluetoothctl info "$uuid" 2>/dev/null | awk '/Icon/ {print $2}')

	case "$icon_dev_type" in
	*input-mouse*) echo "󰦋" ;;
	*input-keyboard*) echo "󰌌" ;;
	*input-tablet*) echo "󰓶" ;;
	*input-gaming*) echo "󰊴" ;;
	*audio-card*) echo "󰦢" ;;
	*audio-headset* | *audio-headphones*) echo "󰥰" ;;
	*camera-photo* | *camera-video*) echo "󰄀" ;;
	*computer*) echo "󰌢" ;;
	*video-display*) echo "󰍹" ;;
	*modem*) echo "󰑩" ;;
	*multimedia-player*) echo "󰾰" ;;
	*network-wireless*) echo "󰀂" ;;
	*phone*) echo "" ;;
	*printer*) echo "󰨋" ;;
	*scanner*) echo "󰮄" ;;
	*) echo "󰂱" ;;
	esac
}

# Get Bluetooth status
powered=$(bluetoothctl show | awk '/Powered:/ {print $2}')
mapfile -t connected_uuids < <(bluetoothctl devices Connected | grep '^Device' | awk '{print $2}')
connected_count="${#connected_uuids[@]}"

if [[ "$powered" != "yes" ]]; then
	echo '{"text":"󰂲","class":"powered-off","tooltip":"󰂲 Bluetooth device off"}'
elif ((connected_count == 0)); then
	echo '{"text":"󰂳","class":"no-devices","tooltip":"󰂳 No device connected"}'
elif ((connected_count == 1)); then
	icon=$(get_device_icon "${connected_uuids[0]}")
	name=$(bluetoothctl info "${connected_uuids[0]}" | awk -F ': ' '/Name/ {print $2}')
	echo "{\"text\":\"$icon\",\"class\":\"one-device\",\"tooltip\":\"$icon  $name\"}"
else
	tooltip_parts=()
	for uuid in "${connected_uuids[@]}"; do
		icon=$(get_device_icon "$uuid")
		name=$(bluetoothctl info "$uuid" | awk -F ': ' '/Name/ {print $2}')
		tooltip_parts+=("$icon  $name")
	done

	tooltip_devices=$(printf "%s\n" "${tooltip_parts[@]}" | sed 's/"/\\"/g; :a;N;$!ba;s/\n/\\n/g')

	echo "{\"text\":\"󰂱 $connected_count\",\"class\":\"multiple-devices\",\"tooltip\":\"$tooltip_devices\"}"
fi
