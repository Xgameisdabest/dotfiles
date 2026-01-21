#!/bin/bash

volume_step=3
brightness_step=3
max_volume=153
min_volume=0
notification_timeout=900

get_pa_info() {
	local info
	info=$(
		pactl get-sink-volume @DEFAULT_SINK@
		pactl get-sink-mute @DEFAULT_SINK@
	)
	vol=$(echo "$info" | grep -Po '\d+(?=%)' | head -1)
	mute=$(echo "$info" | grep -Po '(?<=Mute: )(yes|no)')
}

get_brightness() {
	local max curr
	max=$(cat /sys/class/backlight/*/max_brightness | head -1)
	curr=$(cat /sys/class/backlight/*/brightness | head -1)
	br=$((curr * 100 / max))
}

get_volume_icon() {
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

send_notif() {
	notify-send -t "$notification_timeout" \
		-h string:x-dunst-stack-tag:"$1" \
		-h int:value:"$2" \
		"$3"
}

notify_volume() {
	get_pa_info
	get_volume_icon
	send_notif "volume_notif" "$vol" " $1$volume_icon   ${vol}%"
}

notify_brightness() {
	get_brightness
	send_notif "brightness_notif" "$br" " $1    ${br}%"
}

show_mic_status_notif() {
	local mic_status
	mic_status=$(pactl get-source-mute @DEFAULT_SOURCE@ | grep -Po '(?<=Mute: )(yes|no)')
	if [[ $mic_status == "yes" ]]; then
		send_notif "mic_notif" 0 "   Mic Muted"
	else
		send_notif "mic_notif" 0 "   Mic Unmuted"
	fi
}

case "$1" in
volume_up)
	get_pa_info
	if ((vol + volume_step > max_volume)); then
		pactl set-sink-volume @DEFAULT_SINK@ "${max_volume}%"
		notify_volume ""
	else
		pactl set-sink-volume @DEFAULT_SINK@ "+${volume_step}%"
		notify_volume ""
		# Play sound in background so script can exit immediately
		paplay "$CUSTOM_SOUND_PATH/audio-volume-change.oga" 2>/dev/null &
	fi
	;;

volume_down)
	get_pa_info
	if ((vol - volume_step < min_volume)); then
		notify_volume ""
	else
		pactl set-sink-volume @DEFAULT_SINK@ "-${volume_step}%"
		notify_volume ""
		paplay "$CUSTOM_SOUND_PATH/audio-volume-change.oga" 2>/dev/null &
	fi
	;;

volume_mute)
	pactl set-sink-mute @DEFAULT_SINK@ toggle
	notify_volume ""
	;;

volume_status)
	notify_volume ""
	;;

mic_toggle)
	pactl set-source-mute @DEFAULT_SOURCE@ toggle
	show_mic_status_notif
	;;

brightness_up)
	get_brightness
	if ((br < 100)); then
		light -A "$brightness_step"
		notify_brightness ""
	else
		notify_brightness ""
	fi
	;;

brightness_down)
	get_brightness
	if ((br > 1)); then
		light -U "$brightness_step"
		notify_brightness ""
	else
		notify_brightness ""
	fi
	;;

brightness_status)
	notify_brightness ""
	;;
esac
