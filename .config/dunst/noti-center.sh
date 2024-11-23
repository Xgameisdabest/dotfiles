#!/bin/bash

noti_main_menu(){
notifications=$(dunstctl history | jq -r '
    .data[0][] |
    select(
	(.summary.data | contains("Press 󰖳 + = to open the keybind menu!") | not) and
	(.summary.data | contains("Airplane Mode Toggled 󰀝 ") | not) and
	(.summary.data | contains("Battery Time Remaining: ") | not) and
	(.summary.data | contains("Power set to performance mode 󰓅") | not) and
	(.summary.data | contains("Power set to balance mode 󰾅") | not) and
	(.summary.data | contains("Power set to power-saver mode 󰾆") | not) and
	(.summary.data | contains("CONNECTING TO PHONE ") | not) and
	(.summary.data | contains("Screenshotted") | not) and
	(.summary.data | contains("Window Screenshotted") | not) and
	(.summary.data | contains("Selected Area Screenshotted") | not) and
        (.summary.data | contains("RESIZE MODE. PRESS esc TO EXIT!") | not) and
	(.summary.data | contains("") | not) and
        (.summary.data | contains("") | not) and
        (.summary.data | contains("") | not) and
	(.summary.data | contains("") | not)) |
    "\(.summary.data)"
')

cls_hist=$(echo "Clear History 󱏫")
# options="$notifications\n$cls_hist"
options="$cls_hist\n$notifications"
# Use rofi to display notifications
selected=$(echo -e "$options" | rofi -dmenu -i -selected-row 1 -p " Select notification 󱅫  " -theme-str "listview {columns: 1;}")
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
	     	echo -e "Notification Body 󰎟 :\n$clean_body" | rofi -dmenu -i -selected-row 1 -p "Notification Body"
		;;
esac

