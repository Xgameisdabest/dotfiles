#!/usr/bin/env bash

print_status() {
	volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | grep -Po '[0-9]{1,3}' | head -1)
	mute=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
	if [ -d /sys/class/backlight/ ] && [ "$(ls -A /sys/class/backlight/)" ]; then
		device=$(ls /sys/class/backlight/ | head -n 1)
		max=$(cat "/sys/class/backlight/$device/max_brightness")
		curr=$(cat "/sys/class/backlight/$device/brightness")
		brightness="$((curr * 100 / max))%"
	else
		brightness="Unsupported"
	fi

	volume=${volume:-0}
	mute=${mute:-no}

	brightness_tooltip="Brightness: ${brightness}"

	if [[ "$mute" == "yes" ]]; then
		icon=""
		class="muted"
		volume_tooltip="Volume Muted"
	else
		if ((volume < 50)); then
			icon=""
			class="low"
		elif ((volume < 100)); then
			icon=""
			class="medium"
		elif ((volume >= 100)); then
			icon=""
			class="high"
		fi
		volume_tooltip="Volume: ${volume}%"
	fi

	tooltip="$volume_tooltip\n$brightness_tooltip"

	echo "{\"text\":\"$icon  ${volume}%\",\"class\":\"$class\",\"tooltip\":\"$tooltip\"}"
}

# Print initial status
print_status

# Listen for events from PulseAudio/PipeWire
pactl subscribe | grep --line-buffered "sink" | while read -r _; do
	print_status
done
