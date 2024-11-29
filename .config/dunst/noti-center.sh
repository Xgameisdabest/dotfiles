#!/bin/bash

noti_main_menu(){
notifications=$(dunstctl history | jq -r '
    .data[0][] |
    select(
	(.summary.data | contains("Press 󰖳 + = to open the keybind menu!") | not) and
	(.summary.data | contains("Wifi Enabled") | not) and
	(.summary.data | contains("Wifi Disabled") | not) and
	(.summary.data | contains("Removed Network") | not) and
	(.summary.data | contains("Getting list of available Wi-Fi networks") | not) and
	(.summary.data | contains("Connection Established!") | not) and
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
	(.summary.data | contains("") | not) and
        (.summary.data | contains("") | not) and
	(.summary.data | contains("") | not) and
        (.summary.data | contains("") | not) and
	(.summary.data | contains("") | not)) |
    "\(.summary.data)"
')

cls_hist=$(echo "Clear History 󱏫")
# options="$notifications\n$cls_hist"
options="$cls_hist\n$notifications"
# Use rofi to display notifications
selected=$(echo -e "$options" | rofi -dmenu -i -selected-row 1 -p " Select notification 󱅫  " -theme-str "listview {columns: 1;}" -theme-str 'window {location: north east; x-offset: -10px; y-offset: 70px;}')
}

noti_main_menu

case "$selected" in
	"")
		exit
		;;
	"$cls_hist")
		dunstctl history-clear
		noti_main_menu
		;;
	*)
		body=$(dunstctl history | jq -r --arg summary "$selected" \
			'.data[0][] | select(.summary.data == $summary) | .body.data')
	     	clean_body=$(echo "$body" | sed 's/<[^>]*>//g')
	     	echo -e "Notification Body 󰎟 :\n$clean_body" | rofi -dmenu -i -selected-row 1 -p "Notification Body" -theme-str "listview {columns: 1;}" -theme-str 'window {location: north east; x-offset: -10px; y-offset: 70px;}'
		;;
esac

