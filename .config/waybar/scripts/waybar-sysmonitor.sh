#!/bin/bash

source ~/.config/dtf-config/config
rofi_theme=${rofi_theme:-black}

if [[ $rofi_theme == "white" ]]; then
	path_to_theme="~/.config/rofi/rofi_theme/white/white.rasi"
else
	path_to_theme="~/.config/rofi/rofi_theme/black/black.rasi"
fi

main_menu_height=265px
main_menu_width=450px

temperature="  Temperature"
system_monitor="  Htop (Legacy Process Manager)"
system_monitor2="  Btop (Newer Process Manager)"
quit="Exit 󰈆 "

select=$(echo -e "$temperature\n$system_monitor2\n$system_monitor\n$quit" | rofi -dmenu -theme $path_to_theme -i -p " Monitors   " -theme-str "listview {columns: 1; layout: vertical;}" -theme-str "window {width: $main_menu_width; height: $main_menu_height;}")

case $select in
	$temperature)
		$TERMINAL -e watch sensors
	;;
	$system_monitor)
		$TERMINAL -e htop
	;;
	$system_monitor2)
		$TERMINAL -e btop
	;;
	$quit)
		exit 0
	;;
esac

