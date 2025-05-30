#!/usr/bin/env bash

#THIS SCRIPT WAS FABRICATED BY ME (Xgameisdabest, aka xytozine)

#when add new entry make sure to add 40 to height
main_menu_height=520px
main_menu_width=265px

rofi_submenu_height=595px
rofi_submenu_width=270px

polybar_submenu_height=335px
polybar_submenu_width=280px

polybar_bar_config_submenu_height=450px
polybar_bar_config_submenu_width=420px

polybar_module_config_submenu_height=300px
polybar_module_config_submenu_width=420px

i3_submenu_height=480px
i3_submenu_width=385px

goback="Back 󰌍 "
quit="Exit 󰈆 "

i3config="󰨇  i3 Desktop  "
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
	select=$(echo -e "$i3config\n$rofi\n$polybar\n$picomconfig\n$zshconfig\n$dunst\n$btrlockscreen\n$gestures\n$wallpaper\n$arandr\n$quit"  | rofi -dmenu -i -theme-str "window {height: $main_menu_height; width: $main_menu_width;}" -theme-str "listview {columns: 1; layout: vertical;}" -p " Settings   ")

	case $select in
		$i3config)
			i3_submenu
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
	sound_setting="󱄠  Audio"
	pwr_menu="  Power Menu"
	pwr_mode="󰾆  Power Mode"
	web_search="  Web Search"
	calendar="  Calendar"
	i3_settings_menu="  Settings Menu"
	notifications_hist="󰵙  Notification"
	os_about="󰟀  Machine Info"
	redshift="  Night Mode"
	
	select2=$(echo -e "$rofi_sub\n$i3_settings_menu\n$wifi\n$bluetooth\n$sound_setting\n$pwr_menu\n$pwr_mode\n$web_search\n$calendar\n$notifications_hist\n$os_about\n$redshift\n$goback" | rofi -dmenu -i -theme-str "window {height: $rofi_submenu_height; width: $rofi_submenu_width;}" -theme-str "listview {columns: 1; layout: vertical;}" -p " Rofi   ")
	
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
			$TERMINAL -e nvim ~/.config/i3/scripts/i3_rofi_settings.sh
			;;
		$notifications_hist)
			$TERMINAL -e nvim ~/.config/dunst/noti-center.sh
			;;
		$sound_setting)
			$TERMINAL -e nvim ~/.config/rofi/modules/rofi-sound-settings
			;;
		$os_about)
			$TERMINAL -e nvim ~/.config/rofi/modules/rofi-os-about
			;;
		$redshift)
			$TERMINAL -e nvim ~/.config/rofi/modules/rofi-redshift
			;;
		$goback)
			main_menu
			;;
	esac

}

### POLYBAR SUBMENU

polybar_bar_config_submenu(){
	polybar_cfg_sub_black_bottom="  Black Bar Bottom"
	polybar_cfg_sub_white_bottom="  White Bar Bottom"
	polybar_cfg_sub_black_compact_bottom="  Black Bar Compact Bottom"
	polybar_cfg_sub_white_compact_bottom="  White Bar Compact Bottom"
	polybar_cfg_sub_black_top="  Black Bar Top"
	polybar_cfg_sub_white_top="  White Bar Top"
	polybar_cfg_sub_black_compact_top="  Black Bar Compact Top"
	polybar_cfg_sub_white_compact_top="  White Bar Compact Top"
	select3_sub=$(echo -e "$polybar_cfg_sub_black_bottom\n$polybar_cfg_sub_white_bottom\n$polybar_cfg_sub_black_compact_bottom\n$polybar_cfg_sub_white_compact_bottom\n$polybar_cfg_sub_black_top\n$polybar_cfg_sub_white_top\n$polybar_cfg_sub_black_compact_top\n$polybar_cfg_sub_white_compact_top\n$goback" | rofi -dmenu -i -theme-str "window {height: $polybar_bar_config_submenu_height; width: $polybar_bar_config_submenu_width;}" -theme-str "listview {columns: 1; layout: vertical;}" -p " Bars   ")
	
	case $select3_sub in
		$polybar_cfg_sub_black_bottom)
			$TERMINAL -e nvim ~/.config/polybar/polybar-config/main_black_bottom.ini
			;;
		$polybar_cfg_sub_white_bottom)
			$TERMINAL -e nvim ~/.config/polybar/polybar-config/main_white_bottom.ini
			;;
		$polybar_cfg_sub_black_compact_bottom)
			$TERMINAL -e nvim ~/.config/polybar/polybar-config/main_black_compact_bottom.ini
			;;
		$polybar_cfg_sub_white_compact_bottom)
			$TERMINAL -e nvim ~/.config/polybar/polybar-config/main_white_compact_bottom.ini
			;;
		$polybar_cfg_sub_black_top)
			$TERMINAL -e nvim ~/.config/polybar/polybar-config/main_black_top.ini
			;;
		$polybar_cfg_sub_white_top)
			$TERMINAL -e nvim ~/.config/polybar/polybar-config/main_white_top.ini
			;;
		$polybar_cfg_sub_black_compact_top)
			$TERMINAL -e nvim ~/.config/polybar/polybar-config/main_black_compact_top.ini
			;;
		$polybar_cfg_sub_white_compact_top)
			$TERMINAL -e nvim ~/.config/polybar/polybar-config/main_white_compact_top.ini
			;;
		$goback)
			polybar_submenu
			;;
	esac

}

polybar_module_config_submenu(){
	polybar_module_sub_black="󰾍  Module (Black Bar)"
	polybar_module_sub_white="󰾍  Module (White Bar)"
	polybar_module_sub_black_compact="󰾍  Module (Black Compact Bar)"
	polybar_module_sub_white_compact="󰾍  Module (White Compact Bar)"
	select3_module=$(echo -e "$polybar_module_sub_black\n$polybar_module_sub_white\n$polybar_module_sub_black_compact\n$polybar_module_sub_white_compact\n$goback" | rofi -dmenu -i -theme-str "window {height: $polybar_module_config_submenu_height; width: $polybar_module_config_submenu_width;}" -theme-str "listview {columns: 1; layout: vertical;}" -p " Polybar Modules   ")
		case $select3_module in
		$polybar_module_sub_black)
			$TERMINAL -e nvim ~/.config/polybar/modules/modules_black.ini
			;;
		$polybar_module_sub_white)
			$TERMINAL -e nvim ~/.config/polybar/modules/modules_white.ini
			;;
		$polybar_module_sub_black_compact)
			$TERMINAL -e nvim ~/.config/polybar/modules/modules_black_compact.ini
			;;
		$polybar_module_sub_white_compact)
			$TERMINAL -e nvim ~/.config/polybar/modules/modules_white_compact.ini
			;;
		$goback)
			polybar_submenu
			;;
	esac
}

polybar_submenu(){
	
	polybar_main_cfg_sub="  Main Config"
	polybar_sub="  Bar  "
	polybar_module_sub="󰾍  Modules  "
	polybar_color_sub="  Colors"
	bar_start="󱓞  Bar Startup"
	
	#when add new entry make sure to add 35 to height
	select3=$(echo -e "$polybar_main_cfg_sub\n$polybar_sub\n$polybar_module_sub\n$polybar_color_sub\n$bar_start\n$goback" | rofi -dmenu -i -theme-str "window {height: $polybar_submenu_height; width: $polybar_submenu_width;}" -theme-str "listview {columns: 1; layout: vertical;}" -p " Polybar   ")

	case $select3 in 
		$polybar_main_cfg_sub)
			$TERMINAL -e nvim ~/.config/polybar/config.ini
			;;
		$polybar_sub)
			polybar_bar_config_submenu
			;;
		$polybar_module_sub)
			polybar_module_config_submenu
			;;
		$polybar_color_sub)
			$TERMINAL -e nvim ~/.config/polybar/theme/colors.ini
			;;
		$bar_start)
			$TERMINAL -e nvim ~/.config/polybar/launch.sh
			;;
		$goback)
			main_menu
			;;
	esac
}

### I3 SUBMENU

i3_submenu(){

	i3_sub="  Main Config"
	i3_workspace="  Workspaces"
	exec="  Launch On Startup"
	coloring="  Colors"
	gaps_border="󰃐  Gaps And Border"
	for_window_rules="!  Window Rules"
	system_keybinds="  System Keybinds 󰌏 "
	app_keybinds="󰀻  App Launch Keybinds 󰌏 "
	special_key_keybinds="󰘲  Special Key Keybinds 󰌏 "

	select4=$(echo -e "$i3_sub\n$i3_workspace\n$exec\n$coloring\n$gaps_border\n$for_window_rules\n$system_keybinds\n$app_keybinds\n$special_key_keybinds\n$goback" | rofi -dmenu -i -theme-str "window {height: $i3_submenu_height; width: $i3_submenu_width;}" -theme-str "listview {columns: 1; layout: vertical;}" -p " i3wm   ")

	case $select4 in
		$i3_sub)
			$TERMINAL -e nvim ~/.config/i3/config
			;;
		$i3_workspace)
			$TERMINAL -e nvim ~/.config/i3/i3-config-modules/workspace
			;;
		$exec)
			$TERMINAL -e nvim ~/.config/i3/i3-config-modules/exec
			;;
		$coloring)
			$TERMINAL -e nvim ~/.config/i3/i3-config-modules/coloring
			;;
		$for_window_rules)
			$TERMINAL -e nvim ~/.config/i3/i3-config-modules/for_window_rules
			;;
		$system_keybinds)
			$TERMINAL -e nvim ~/.config/i3/i3-config-modules/i3_system_keybinds
			;;
		$special_key_keybinds)
			$TERMINAL -e nvim ~/.config/i3/i3-config-modules/special_keys_keybinds
			;;
		$app_keybinds)
			$TERMINAL -e nvim ~/.config/i3/i3-config-modules/keybinds
			;;
		$gaps_border)
			$TERMINAL -e nvim ~/.config/i3/i3-config-modules/gaps_and_border
			;;
		$goback)
			main_menu
			;;
	esac


}


### PROGRAM MAIN EXEC

main_menu
