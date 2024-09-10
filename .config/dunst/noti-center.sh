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

cls_hist=$(echo "Clear history")
options="$notifications\n$cls_hist"

# Use rofi to display notifications
selected=$(echo -e "$options" | rofi -dmenu -i -p "Select notification")

# Show selected notification body (for preview purposes)
# if [ -n "$selected" ]; then
#     # Extract and display the body of the selected notification
#     body=$(dunstctl history | jq -r --arg summary "$selected" \
#         '.data[0][] | select(.summary.data == $summary) | .body.data')
#
#     # Remove HTML tags from the body text
#     clean_body=$(echo "$body" | sed 's/<[^>]*>//g')
#
#     # Display the clean body in rofi
#     echo "Notification Body:\n$clean_body" | rofi -dmenu -i -p "Notification Body"
#
# elif ["$selected" == "Clear history"]; then
# 	dunstctl history-clear
# fi

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
	     	echo -e "Notification Body:\n$clean_body" | rofi -dmenu -i -p "Notification Body"
		;;
esac

