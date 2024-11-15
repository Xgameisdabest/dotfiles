#!/usr/bin/env bash

i3config="󰨇  i3 Desktop"
polybar="  Polybar"
btrlockscreen="󰷛  Lock Screen"
picomconfig="󰢹  Picom"
arandr="󰨤  Resolution"
wallpaper="  Wallpaper"
gestures="󱠡  Gestures"
rofi="󰮫  Menu  "

rofi_submenu(){
	
	rofi="󰮫  Menu"
	wifi="󱛃  Wifi"
	bluetooth="󰂳  Bluetooth"
	pwr_menu="  Power Menu"
	pwr_mode="󰾆  Power Mode"
	web_search="  Web Search"
	calendar="  Calendar"
	i3_settings_menu="  i3 Settings"
	notifications_hist="󰵙  Notification"

	select2=$(echo -e "$rofi\n$i3_settings_menu\n$wifi\n$bluetooth\n$pwr_menu\n$pwr_mode\n$web_search\n$calendar\n$notifications_hist" | rofi -dmenu -theme-str 'window {height: 450px; width: 260px;}' -theme-str "listview {columns: 1; layout: vertical;}" -p " Menu   ")
	
	case $select2 in
		$rofi)
			$TERMINAL -e nvim ~/.config/rofi/config.rasi
			;;
		$wifi)
			$TERMINAL -e nvim ~/.config/rofi/modules/rofi-wifi-menu
			;;
		$bluetooth)
			$TERMINAL -e nvim ~/.config/rofi/modules/rofi-bluetooth
			;;
		$pwr_menu)
			$TERMINAL -e nvim ~/.config/rofi/modules/rofi-power-menu
			;;
		$pwr_mode)
			$TERMINAL -e nvim ~/.config/rofi/modules/rofi-power-mode
			;;
		$web_search)
			$TERMINAL -e nvim ~/.config/rofi/modules/rofi-web-search
			;;
		$calendar)
			$TERMINAL -e nvim ~/.config/rofi/modules/rofi-calendar
			;;
		$i3_settings_menu)
			$TERMINAL -e nvim ~/.config/i3/i3_rofi_settings.sh
			;;
		$notifications_hist)
			$TERMINAL -e nvim ~/.config/dunst/noti-center.sh
			;;
	esac

}

select=$( echo -e "$i3config\n$polybar\n$rofi\n$picomconfig\n$btrlockscreen\n$gestures\n$wallpaper\n$arandr"  | rofi -dmenu -theme-str 'window {height: 410px; width: 260px;}' -theme-str "listview {columns: 1; layout: vertical;}" -p " Settings   " )

case $select in
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
		rofi_submenu
		;;
	$btrlockscreen)
		$TERMINAL -e nvim ~/.config/betterlockscreen/betterlockscreenrc
		;;
	$polybar)
		$TERMINAL -e nvim ~/.config/polybar/config.ini
		;;
esac
