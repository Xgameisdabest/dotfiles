#!/usr/bin/env bash

goback="Back 󰌍 "
quit="Exit 󰈆 "

i3config="󰨇  i3 Desktop"
polybar="  Polybar  "
btrlockscreen="󰷛  Lock Screen"
picomconfig="󰢹  Picom"
arandr="󰨤  Resolution"
wallpaper="  Wallpaper"
gestures="󱠡  Gestures"
rofi="󰮫  Rofi  "
zshconfig="  Zsh"
dunst="󰵙  Notification"

### MAIN MENU

main_menu(){
	#when add new entry make sure to add 35 to height
	select=$(echo -e "$i3config\n$rofi\n$polybar\n$picomconfig\n$zshconfig\n$dunst\n$btrlockscreen\n$gestures\n$wallpaper\n$arandr\n$quit"  | rofi -dmenu -i -theme-str 'window {height: 520px; width: 260px;}' -theme-str "listview {columns: 1; layout: vertical;}" -p " Settings   ")

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
			polybar_submenu
			;;
		$zshconfig)
			$TERMINAL -e nvim ~/.zshrc
			;;
		$dunst)
			$TERMINAL -e nvim ~/.config/dunst/dunstrc
			;;
		$quit)
			echo "exit"
			exit 0
			;;
	esac
}

### ROFI SUBMENU

rofi_submenu(){
	
	rofi_sub="󰮫  Menu"
	wifi="󱛃  Wifi"
	bluetooth="󰂳  Bluetooth"
	pwr_menu="  Power Menu"
	pwr_mode="󰾆  Power Mode"
	web_search="  Web Search"
	calendar="  Calendar"
	i3_settings_menu="  This Menu"
	notifications_hist="󰵙  Notification"

	select2=$(echo -e "$rofi_sub\n$i3_settings_menu\n$wifi\n$bluetooth\n$pwr_menu\n$pwr_mode\n$web_search\n$calendar\n$notifications_hist\n$goback" | rofi -dmenu -i -theme-str 'window {height: 480px; width: 260px;}' -theme-str "listview {columns: 1; layout: vertical;}" -p " Menu   ")
	
	case $select2 in
		$rofi_sub)
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
		$goback)
			main_menu
			;;
	esac

}

### POLYBAR SUBMENU

polybar_submenu(){
	
	polybar_sub="  Polybar"
	bar_start="󱓞  Bar Startup"
	
	select2=$(echo -e "$polybar_sub\n$bar_start\n$goback" | rofi -dmenu -i -theme-str 'window {height: 220px; width: 260px;}' -theme-str "listview {columns: 1; layout: vertical;}" -p " Polybar   ")

	case $select2 in 
		$polybar_sub)
			$TERMINAL -e nvim ~/.config/polybar/config.ini
			;;
		$bar_start)
			$TERMINAL -e nvim ~/.config/polybar/launch.sh
			;;
		$goback)
			main_menu
			;;
	esac
}

### PROGRAM MAIN EXEC

main_menu
