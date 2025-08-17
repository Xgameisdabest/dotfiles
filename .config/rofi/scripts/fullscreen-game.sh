#!/usr/bin/bash
source ~/.config/dtf-config/config
rofi_theme=${rofi_theme:-black}
if [[ $rofi_theme == "white" ]]; then
	path_to_theme="~/.config/rofi/rofi_theme/white/white-fullscreen.rasi"
else
	path_to_theme="~/.config/rofi/rofi_theme/black/black-fullscreen.rasi"
fi

polybar_status=$(xwininfo -id $(xdotool search -name polybar | head -n1) | grep IsViewable)

polybar-msg cmd hide

rofi -theme $path_to_theme -drun-categories Game -show drun

#check if it is hidden or not
if [[ -n $polybar_status ]]; then
    polybar-msg cmd show
fi
