#!/bin/bash

# Configure
volume_step=3
brightness_step=3
max_volume=153
min_volume=0
notification_timeout=900

# Query info
get_volume() { pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '\d+(?=%)' | head -1; }
get_mute() { pactl get-sink-mute @DEFAULT_SINK@ | grep -Po '(?<=Mute: )(yes|no)'; }
get_mic_mute() { pactl get-source-mute @DEFAULT_SOURCE@ | grep -Po '(?<=Mute: )(yes|no)'; }
get_brightness() { light | cut -d'.' -f1; } # faster than grep

# Icon selectors
get_volume_icon() {
	local vol=$(get_volume)
	local mute=$(get_mute)

	if [[ $mute == "yes" ]]; then
		volume_icon=" "
	elif ((vol < 25)); then
		volume_icon=" "
	elif ((vol < 50)); then
		volume_icon=" "
	else
		volume_icon=" "
	fi
}

get_brightness_icon() { brightness_icon=" "; }

# Notif script
send_notif() {
	local tag="$1"
	local value="$2"
	local message="$3"
	notify-send -t "$notification_timeout" \
		-h string:x-dunst-stack-tag:"$tag" \
		-h int:value:"$value" \
		"$message"
}

send_notif_mic() {
	local tag="$1"
	local message="$3"
	notify-send -t "$notification_timeout" \
		-h string:x-dunst-stack-tag:"$tag" \
		"$message"
}

# Volume notif
notify_volume() {
	local prefix="$1"
	local vol=$(get_volume)
	get_volume_icon
	send_notif "volume_notif" "$vol" " $prefix$volume_icon   ${vol}%"
}

# Brightness notif
notify_brightness() {
	local prefix="$1"
	local br=$(get_brightness)
	get_brightness_icon
	send_notif "brightness_notif" "$br" " $prefix$brightness_icon   ${br}%"
}

# Mic notif
show_mic_status_notif() {
	local mic_status=$(get_mic_mute)
	if [[ $mic_status == "yes" ]]; then
		send_notif_mic "mic_notif" 0 "   Mic Muted"
	else
		send_notif_mic "mic_notif" 0 "   Mic Unmuted"
	fi
}

# Main
case "$1" in

volume_up)
	volume=$(get_volume)
	if ((volume + volume_step > max_volume)); then
		pactl set-sink-volume @DEFAULT_SINK@ "${max_volume}%"
		notify_volume ""
	else
		pactl set-sink-volume @DEFAULT_SINK@ "+${volume_step}%"
		notify_volume ""
		paplay "$CUSTOM_SOUND_PATH/audio-volume-change.oga" 2>/dev/null
	fi
	;;

volume_down)
	volume=$(get_volume)
	if ((volume - volume_step < min_volume)); then
		notify_volume ""
	else
		pactl set-sink-volume @DEFAULT_SINK@ "-${volume_step}%"
		notify_volume ""
		paplay "$CUSTOM_SOUND_PATH/audio-volume-change.oga" 2>/dev/null
	fi
	;;

volume_mute)
	pactl set-sink-mute @DEFAULT_SINK@ toggle
	notify_volume ""
	;;

mic_toggle)
	pactl set-source-mute @DEFAULT_SOURCE@ toggle
	show_mic_status_notif
	;;

brightness_up)
	current=$(get_brightness)
	if ((current < 100)); then
		light -A "$brightness_step"
		notify_brightness ""
	else
		notify_brightness ""
	fi
	;;

brightness_down)
	current=$(get_brightness)
	if ((current > 1)); then
		light -U "$brightness_step"
		notify_brightness ""
	else
		notify_brightness ""
	fi
	;;

brightness_status)
	notify_brightness ""
	;;

volume_status)
	notify_volume ""
	;;
esac
