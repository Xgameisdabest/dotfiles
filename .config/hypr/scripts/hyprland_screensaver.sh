#!/usr/bin/env bash

source ~/.config/dtf-config/config

screen_saver_style=${screen_saver_style:-clock}

screensaver_logic() {
	local style="$1"
	local cmd=""

	case "$style" in
	clock) cmd="tty-clock -scbC7S" ;;
	pipes) cmd="pipes" ;;
	cmatrix) cmd="cmatrix" ;;
	neofetch) cmd="neofetch" ;;
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

	# Execution
	pkill -USR1 waybar
	hyprctl dispatch fullscreen
	sleep 0.2
	eval "$cmd"
	pkill -USR1 waybar
}

$TERMINAL -e bash -c "$(declare -f screensaver_logic); screensaver_logic \"$screen_saver_style\""
