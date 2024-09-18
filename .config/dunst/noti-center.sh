#!/bin/bash

notifications=$(dunstctl history | jq -r '
    .data[0][] |
    select(
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
selected=$(echo -e "$options" | rofi -dmenu -i -selected-row 1 -p "Select notification" -theme-str "listview {columns: 1;}")

case "$selected" in
	"")
		exit
		;;
	"$cls_hist")
		dunstctl history-clear
		;;
	*)
		body=$(dunstctl history | jq -r --arg summary "$selected" \
			'.data[0][] | select(.summary.data == $summary) | .body.data')
	     	clean_body=$(echo "$body" | sed 's/<[^>]*>//g')
	     	echo -e "Notification Body:\n$clean_body" | rofi -dmenu -i -selected-row 1 -p "Notification Body"
		;;
esac

