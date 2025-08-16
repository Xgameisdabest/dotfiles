#!/usr/bin/bash
source ~/.config/dtf-config/config
rofi_theme=${rofi_theme:-black}
if [[ $rofi_theme == "white" ]]; then
	path_to_theme="~/.config/rofi/rofi_theme/white/white.rasi"
else
	path_to_theme="~/.config/rofi/rofi_theme/black/black.rasi"
fi

rofi -theme $path_to_theme -show window
