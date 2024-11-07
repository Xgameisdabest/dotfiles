#!/usr/bin/env bash

i3config="i3 Config 󰨇 "
picomconfig="Picom Config 󰢹 "
arandr="Resolution 󰨤 "
wallpaper="Wallpaper  "
gestures="Gestures 󱠡 "
rofi="Menu  "

select=$( echo -e "$i3config\n$picomconfig\n$gestures\n$rofi\n$wallpaper\n$arandr"  | rofi -dmenu -theme-str 'window {height: 340px; width: 255px;}' -theme-str "listview {columns: 1; layout: vertical;}" -p " Settings   " )

case ${select} in
	$i3config)
		$TERMINAL -e nvim ~/.config/i3/config
		;;
	$picomconfig)
		$TERMINAL -e nvim ~/.config/picom/picom.conf
		;;
	$arandr)
		arandr
		;;
	$wallpaper)
		waypaper
		;;
	$gestures)
		$TERMINAL -e nvim ~/.config/libinput-gestures.conf
		;;
	$rofi)
		$TERMINAL -e nvim ~/.config/rofi/config.rasi
		;;
esac
