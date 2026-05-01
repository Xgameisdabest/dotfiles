#!/usr/bin/bash
source ~/.config/dtf-config/config
rofi_theme=${rofi_theme:-black}
if [[ $rofi_theme == "white" ]]; then
	path_to_theme="~/.config/rofi/rofi_theme/white/white.rasi"
else
	path_to_theme="~/.config/rofi/rofi_theme/black/black.rasi"
fi

# check environment
if [[ $XDG_SESSION_TYPE == "wayland" ]]; then
	typer="wtype"
else
	typer="xdotool"
fi

rofimoji --typer $typer --selector-args="-x11 -theme $path_to_theme"
