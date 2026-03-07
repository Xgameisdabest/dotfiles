#!/usr/bin/env bash

# Function to calculate and print the JSON status
print_status() {
	# --- Audio Logic ---
	volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | grep -Po '[0-9]{1,3}' | head -1)
	mute=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
	volume=${volume:-0}
	mute=${mute:-no}

	# --- Brightness Logic ---
	if [ -d /sys/class/backlight/ ] && [ "$(ls -A /sys/class/backlight/)" ]; then
		device=$(ls /sys/class/backlight/ | head -n 1)
		max=$(cat "/sys/class/backlight/$device/max_brightness")
		curr=$(cat "/sys/class/backlight/$device/brightness")
		brightness_val="$((curr * 100 / max))"
		brightness_tooltip="Brightness: ${brightness_val}%"
	else
		brightness_val="0"
		brightness_tooltip="Brightness: Unsupported"
	fi

	# --- Icon and Class Logic ---
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
		else
			icon=""
			class="high"
		fi
		volume_tooltip="Volume: ${volume}%"
	fi

	tooltip="$volume_tooltip\r$brightness_tooltip"

	# Output JSON for Waybar/Status bar
	echo "{\"text\":\"$icon  ${volume}%\",\"class\":\"$class\",\"tooltip\":\"$tooltip\"}"
}

# --- Event Listeners ---

# 1. Listen for Audio Changes (PulseAudio/PipeWire)
audio_events() {
	pactl subscribe | grep --line-buffered "sink"
}

# 2. Listen for Brightness Changes (Kernel sysfs)
brightness_events() {
	backlight_dev=$(ls /sys/class/backlight/ | head -n 1)
	if [ -n "$backlight_dev" ]; then
		# Requires 'inotify-tools' installed
		inotifywait -m -q -e modify "/sys/class/backlight/$backlight_dev/brightness"
	fi
}

# Initial Print
print_status

# The Magic: Run both listeners in the background, pipe their output to a loop
# Whenever ANY listener outputs a line, we refresh the status.
{
	audio_events &
	brightness_events &
} | while read -r _; do
	print_status
done
