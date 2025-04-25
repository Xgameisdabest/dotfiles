#!/bin/bash

# See README.md for usage instructions
volume_step=3
brightness_step=3
max_volume=153
min_volume=0
notification_timeout=900
download_album_art=true
show_album_art=true
show_music_in_volume_indicator=false

# Uses regex to get volume from pactl
function get_volume {
    pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]{1,3}(?=%)' | head -1
}

# Uses regex to get mute status from pactl
function get_mute {
    pactl get-sink-mute @DEFAULT_SINK@ | grep -Po '(?<=Mute: )(yes|no)'
}

# Uses regex to get mic mute status from pactl
function get_mic_mute {
    pactl get-source-mute @DEFAULT_SOURCE@ | grep -Po '(?<=Mute: )(yes|no)'
}

# Uses regex to get brightness from xbacklight
function get_brightness {
    light | grep -Po '[0-9]{1,3}' | head -n 1
}

get_brightness_var=$(light | grep -Po '[0-9]{1,3}' | head -n 1)

# Returns a mute icon, a volume-low icon, or a volume-high icon, depending on the volume
function get_volume_icon {
    volume=$(get_volume)
    mute=$(get_mute)
    if [ "$mute" == "yes" ] ; then
        volume_icon="Volume:   "
    elif [ "$volume" -lt 25 ]; then
	volume_icon="Volume:   "
    elif [ "$volume" -lt 50 ]; then
        volume_icon="Volume:   "
    elif [ "$volume" -le 100 ]; then 
        volume_icon="Volume:   "
    else 
	volume_icon="Volume:   "
    fi
}

# Always returns the same icon - I couldn't get the brightness-low icon to work with fontawesome
function get_brightness_icon {
    brightness_icon="Brightness:  "
}

function get_album_art {
    url=$(playerctl -f "{{mpris:artUrl}}" metadata)
    if [[ $url == "file://"* ]]; then
        album_art="${url/file:\/\//}"
    elif [[ $url == "http://"* ]] && [[ $download_album_art == "true" ]]; then
        # Identify filename from URL
        filename="$(echo $url | sed "s/.*\///")"

        # Download file to /tmp if it doesn't exist
        if [ ! -f "/tmp/$filename" ]; then
            wget -O "/tmp/$filename" "$url"
        fi

        album_art="/tmp/$filename"
    elif [[ $url == "https://"* ]] && [[ $download_album_art == "true" ]]; then
        # Identify filename from URL
        filename="$(echo $url | sed "s/.*\///")"
        
        # Download file to /tmp if it doesn't exist
        if [ ! -f "/tmp/$filename" ]; then
            wget -O "/tmp/$filename" "$url"
        fi

        album_art="/tmp/$filename"
    else
        album_art=""
    fi
}

# Displays a volume notification
function show_volume_notif {
    volume=$(get_mute)
    get_volume_icon

    if [[ $show_music_in_volume_indicator == "true" ]]; then
        current_song=$(playerctl -f "{{title}} - {{artist}}" metadata)

        if [[ $show_album_art == "true" ]]; then
            get_album_art
        fi

        notify-send -t $notification_timeout -h string:x-dunst-stack-tag:volume_notif -h int:value:$volume -i "$album_art" "$volume_icon   $volume%" "$current_song"
    else
        notify-send -t $notification_timeout -h string:x-dunst-stack-tag:volume_notif -h int:value:$volume "$volume_icon   $volume%"
    fi
}

function show_volume_notif_up {
    volume=$(get_mute)
    get_volume_icon

    if [[ $show_music_in_volume_indicator == "true" ]]; then
        current_song=$(playerctl -f "{{title}} - {{artist}}" metadata)

        if [[ $show_album_art == "true" ]]; then
            get_album_art
        fi

        notify-send -t $notification_timeout -h string:x-dunst-stack-tag:volume_notif -h int:value:$volume -i "$album_art" "$volume_icon + $volume%" "$current_song"
    else
        notify-send -t $notification_timeout -h string:x-dunst-stack-tag:volume_notif -h int:value:$volume "$volume_icon + $volume%"
    fi
}

function show_volume_notif_down {
    volume=$(get_mute)
    get_volume_icon

    if [[ $show_music_in_volume_indicator == "true" ]]; then
        current_song=$(playerctl -f "{{title}} - {{artist}}" metadata)

        if [[ $show_album_art == "true" ]]; then
            get_album_art
        fi

        notify-send -t $notification_timeout -h string:x-dunst-stack-tag:volume_notif -h int:value:$volume -i "$album_art" "$volume_icon - $volume%" "$current_song"
    else
        notify-send -t $notification_timeout -h string:x-dunst-stack-tag:volume_notif -h int:value:$volume "$volume_icon - $volume%"
    fi
}

# Displays a music notification
function show_music_notif {
    song_title=$(playerctl -f "{{title}}" metadata)
    song_artist=$(playerctl -f "{{artist}}" metadata)
    song_album=$(playerctl -f "{{album}}" metadata)

    if [[ $show_album_art == "true" ]]; then
        get_album_art
    fi

    notify-send -t $notification_timeout -h string:x-dunst-stack-tag:music_notif -i "$album_art" "$song_title" "$song_artist - $song_album"
}

# Displays a mic status notification
function show_mic_status_notif() {
	mic_status=$(get_mic_mute)
	if [[ $mic_status == "yes" ]]; then
		notify-send -t $notification_timeout -h string:x-dunst-stack-tag:mic_notif "   Mic Muted"
	else
		notify-send -t $notification_timeout -h string:x-dunst-stack-tag:mic_notif "   Mic Unmuted"
	fi
}

# Displays a brightness notification using notify-send
function show_brightness_notif {
    brightness=$(get_brightness)
    echo $brightness
    get_brightness_icon
    notify-send -t $notification_timeout -h string:x-dunst-stack-tag:brightness_notif -h int:value:$brightness "$brightness_icon   $brightness%"
}

function show_brightness_notif_up {
    brightness=$(get_brightness)
    echo $brightness
    get_brightness_icon
    notify-send -t $notification_timeout -h string:x-dunst-stack-tag:brightness_notif -h int:value:$brightness "$brightness_icon + $brightness%"
}

function show_brightness_notif_down {
    brightness=$(get_brightness)
    echo $brightness
    get_brightness_icon
    notify-send -t $notification_timeout -h string:x-dunst-stack-tag:brightness_notif -h int:value:$brightness "$brightness_icon - $brightness%"
}

# Main function - Takes user input, "volume_up", "volume_down", "brightness_up", or "brightness_down"
case $1 in
    volume_up)
    # Unmutes and increases volume, then displays the notification
    volume=$(get_volume)
    if [[ $(( $volume + $volume_step )) -gt $max_volume ]]; then
        pactl set-sink-volume @DEFAULT_SINK@ $max_volume%
	show_volume_notif
    else
        pactl set-sink-volume @DEFAULT_SINK@ +$volume_step%
	show_volume_notif_up
    fi
    ;;

    volume_down)
    # Raises volume and displays the notification
    volume=$(get_volume)
    if [[ $(($volume - $volume_step)) -lt $min_volume ]]; then
	show_volume_notif
    else
        pactl set-sink-volume @DEFAULT_SINK@ -$volume_step%
	show_volume_notif_down
    fi
    ;;

    volume_mute)
    # Toggles mute and displays the notification
    pactl set-sink-mute @DEFAULT_SINK@ toggle
    show_volume_notif
    ;;

    mic_toggle)
    pactl set-source-mute @DEFAULT_SOURCE@ toggle
    show_mic_status_notif
    ;;

    brightness_up)
    # Increases brightness and displays the notification
    if [[ $get_brightness_var -lt 100 ]]; then
    	light -A $brightness_step 
    	show_brightness_notif_up
    elif [[ $get_brightness_var -eq 100 ]]; then
	show_brightness_notif
    fi
    ;;

    brightness_down)
    # Decreases brightness and displays the notification
    if [[ $get_brightness_var -gt 1 ]]; then
    	light -U $brightness_step
    	show_brightness_notif_down
    elif [[ $get_brightness_var -eq 1 ]]; then
	show_brightness_notif
    fi
    ;;

    next_track)
    # Skips to the next song and displays the notification
    playerctl next
    ;;

    prev_track)
    # Skips to the previous song and displays the notification
    playerctl previous
    ;;

    play_pause)
    # Pauses/resumes playback and displays the notification
    playerctl play-pause
    show_music_notif
    ;;

    # Display current volume percentage
    brightness_status)
    show_brightness_notif
    ;;
    
    # Display current volume percentage
    volume_status)
    show_volume_notif
    ;;
esac
