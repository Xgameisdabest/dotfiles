#!/usr/bin/env bash

source ~/.config/dtf-config/config

screen_saver_style=${screen_saver_style:-clock}

screensaver_logic() {
	local style="$1"
	local cmd=""

	messages_list=("Never kill yourself" "Have fun" "You are not alone" "Be positive" "Stay focus")
	message=${messages_list[$RANDOM % ${#messages_list[@]}]}

	case "$style" in
	cbonsai) cmd="cbonsai --live --multiplier 5 --infinite --wait 5 --time 0.02 --life 40 --message=\"$message\"" ;;
	clock) cmd="tty-clock -scbC7S" ;;
	pipes) cmd="pipes" ;;
	cmatrix) cmd="cmatrix" ;;
	neofetch) cmd="$HOME/.config/neofetch/neofetch_center.sh" ;;
	rain) cmd="rain" ;;
	*) cmd="tty-clock -scbC7S" ;;
	esac

	local bin=$(echo "$cmd" | awk '{print $1}')

	if ! command -v "$bin" &>/dev/null; then
		echo " error: '$bin' binary is not found."
		echo " Press any key to exit..."
		read -n 1
		exit 1
	fi

	pkill -USR1 waybar
	hyprctl dispatch fullscreen 0
	sleep 0.2
	eval "$cmd"
	pkill -USR1 waybar
}

export -f screensaver_logic

$TERMINAL -e bash -c "screensaver_logic \"$screen_saver_style\""
