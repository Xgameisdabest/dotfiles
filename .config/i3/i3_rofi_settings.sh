#!/usr/bin/env bash

i3config="i3 config"
picomconfig="picom config"
arandr="resolution"
wallpaper="wallpaper"

select=$( echo -e "$i3config\n$picomconfig\n$wallpaper\n$arandr"  | rofi -dmenu -p " settings " )

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
