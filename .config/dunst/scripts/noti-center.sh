#!/bin/bash

#THIS SCRIPT WAS FABRICATED BY ME (Xgameisdabest, aka xytozine)

source ~/.config/dtf-config/config

polybar_top=${polybar_top:-false}

if [[ $polybar_top == "true" ]]; then
	location="north west"
				 
	main_menu_x_offset=10px
	main_menu_y_offset=70px
else
	location="south west"
				 
	main_menu_x_offset=10px
	main_menu_y_offset=-70px
fi

goback="Back 󰌍 "
quit="Exit 󰈆 "

#main
noti_main_menu(){
notifications=$(dunstctl history | jq -r '
    .data[0][] |
    select(
	(.summary.data | contains("Dotfiles Update  ") | not) and
	(.summary.data | contains("Wifi Enabled") | not) and
	(.summary.data | contains("Wifi Disabled") | not) and
	(.summary.data | contains("󰗨 Removed Network") | not) and
	(.summary.data | contains("󰗨 Removing Network") | not) and
	(.summary.data | contains("Getting list of available Wi-Fi networks") | not) and
	(.summary.data | contains("Scanning Nearby Devices") | not) and
	(.summary.data | contains("Attempting to connect to") | not) and
	(.summary.data | contains("Airplane Mode: Active") | not) and
	(.summary.data | contains("Airplane Mode: Inactive") | not) and
	(.summary.data | contains("Battery Time Remaining: ") | not) and
	(.summary.data | contains("Charge Time Remaining: ") | not) and
	(.summary.data | contains("Battery Full") | not) and
	(.summary.data | contains("Power set to performance mode") | not) and
	(.summary.data | contains("Power set to balance mode") | not) and
	(.summary.data | contains("Power set to power-saver mode") | not) and
	(.summary.data | contains("CONNECTING TO PHONE") | not) and
	(.summary.data | contains("Screenshotted") | not) and
	(.summary.data | contains("Window Screenshotted") | not) and
	(.summary.data | contains("Selected Area Screenshotted") | not) and
        (.summary.data | contains("RESIZE MODE. PRESS esc TO EXIT!") | not) and
	(.summary.data | contains("Window stacking enabled 󰖲") | not) and
	(.summary.data | contains("Window tab stacking enabled 󰖲") | not) and
	(.summary.data | contains("Window split enabled 󰟘") | not) and
	(.summary.data | contains("") | not) and
        (.summary.data | contains("") | not) and
	(.summary.data | contains("") | not) and
        (.summary.data | contains("") | not) and
	(.summary.data | contains("") | not) and
	(.summary.data | contains("Charging 󰂅") | not) and
	(.summary.data | contains("Discharging 󰁹") | not) and
	(.summary.data | contains("") | not) and
	(.summary.data | contains("") | not) and
	(.summary.data | contains("󰖩") | not) and
	(.summary.data | contains("") | not) and
	(.summary.data | contains("") | not)) |
    "\(.summary.data)"
')

cls_hist=$(echo "Clear History 󱏫")
# options="$notifications\n$cls_hist"
options="$cls_hist\n$notifications"
# Use rofi to display notifications
selected=$(echo -e "$quit\n$options" | rofi -dmenu -i -selected-row 2 -p " Select notification 󱅫  " -theme-str "listview {columns: 1;}" -theme-str "window {location: $location; x-offset: $main_menu_x_offset; y-offset: $main_menu_y_offset;}")

case $selected in
	"")
		exit 0
		;;
	$quit)
		exit 0
		;;
	$cls_hist)
		dunstctl history-clear
		noti_main_menu
		;;
	*)
		noti_body_menu
		;;
esac

}

noti_body_menu(){
body=$(dunstctl history | jq -r --arg summary "$selected" \
			'.data[0][] | select(.summary.data == $summary) | .body.data')
	     	clean_body=$(echo "$body" | sed 's/<[^>]*>//g')
		choose_opt=$(echo -e "$goback\n$quit\nNotification Body 󰎟 :\n$clean_body" | rofi -dmenu -i -selected-row 3 -p "Notification Body" -theme-str "listview {columns: 1;}" -theme-str "window {location: $location; x-offset: $main_menu_x_offset; y-offset: $main_menu_y_offset;}")
		case $choose_opt in
			$goback)
				noti_main_menu
				;;
			$quit)
				exit 0
				;;
		esac
}

noti_main_menu
