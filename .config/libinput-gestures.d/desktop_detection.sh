#!/bin/bash

if [[ $XDG_CURRENT_DESKTOP == "Hyprland" ]]; then
	case $1 in
	"window_ws_switch")
		case $2 in
		"next")
			~/.config/hypr/scripts/current_window_desktop_switch.sh next
			;;
		"prev")
			~/.config/hypr/scripts/current_window_desktop_switch.sh prev
			;;
		esac
		;;
	"window_hide")
		hyprctl dispatch togglespecialworkspace magic
		hyprctl dispatch movetoworkspace +0
		hyprctl dispatch togglespecialworkspace magic
		hyprctl dispatch movetoworkspace special:magic
		hyprctl dispatch togglespecialworkspace magic
		;;

	"window_show")
		hyprctl dispatch togglespecialworkspace magic
		hyprctl dispatch movetoworkspace +0
		hyprctl dispatch togglespecialworkspace magic
		hyprctl dispatch movetoworkspace special:magic
		hyprctl dispatch togglespecialworkspace magic
		;;
	esac
fi

if [[ $XDG_CURRENT_DESKTOP == "i3" ]]; then
	case $1 in
	"window_ws_switch")
		case $2 in
		"next")
			~/.config/i3/scripts/container_desktop.sh next
			;;
		"prev")
			~/.config/i3/scripts/container_desktop.sh prev
			;;
		esac
		;;
	"ws_switch")
		case $2 in
		"next")
			~/.config/i3/scripts/swipe_desktop.sh next
			;;
		"prev")
			~/.config/i3/scripts/swipe_desktop.sh prev
			;;
		esac
		;;
	"window_hide")
		i3-msg move scratchpad
		;;
	"window_show")
		i3-msg scratchpad show, floating disable
		;;
	esac

fi
