#!/usr/bin/bash
source ~/.config/dtf-config/config

rofi_theme=${rofi_theme:-black}
bar_hidden_when_using_fullscreen_launcher=${bar_hidden_when_using_fullscreen_launcher:-true}

if [[ $rofi_theme == "white" ]]; then
	path_to_theme="~/.config/rofi/rofi_theme/white/white-fullscreen.rasi"
else
	path_to_theme="~/.config/rofi/rofi_theme/black/black-fullscreen.rasi"
fi

if [[ $bar_hidden_when_using_fullscreen_launcher == "true" ]]; then
	if [[ $XDG_CURRENT_DESKTOP == "i3" ]]; then
		polybar_status=$(xwininfo -id $(xdotool search -name polybar | head -n1) | grep IsViewable)
		polybar-msg cmd hide
		rofi -x11 -theme $path_to_theme -drun-categories Game -show drun
		#check if it is hidden or not
		if [[ -n $polybar_status ]]; then
			polybar-msg cmd show
		fi
	elif [[ $XDG_CURRENT_DESKTOP == "Hyprland" ]]; then
		if [[ -f /tmp/waybar.hidden ]]; then
			rofi -x11 -theme $path_to_theme -drun-categories Game -show drun
		else
			pkill -USR1 waybar
			rofi -x11 -theme $path_to_theme -drun-categories Game -show drun
			pkill -USR1 waybar
		fi
	fi
else
	rofi -x11 -theme $path_to_theme -drun-categories Game -show drun
fi
