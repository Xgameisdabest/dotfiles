#!/usr/bin/env bash

i3config="i3 Config 󰨇 "
picomconfig="Picom Config 󰢹 "
arandr="Resolution 󰨤 "
wallpaper="Wallpaper  "

select=$( echo -e "$i3config\n$picomconfig\n$wallpaper\n$arandr"  | rofi -dmenu -theme-str 'window {height: 270px; width: 255px;}' -theme-str "listview {columns: 1; layout: vertical;}" -p " Settings   " )

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
esac
