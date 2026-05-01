#!/bin/bash

# MODIFIED BY GEMINI - ORIGINAL BY Xgameisdabest (xytozine)
source ~/.config/dtf-config/config

bar_top=${bar_top:-false}
rofi_theme=${rofi_theme:-black}

# --- Geometry Configuration ---
if [[ $bar_top == "true" ]]; then
	location="north west"
	main_menu_x_offset=10px
	main_menu_y_offset=70px
else
	location="south west"
	main_menu_x_offset=10px
	main_menu_y_offset=-70px
fi

# --- Theme Configuration ---
if [[ $rofi_theme == "white" ]]; then
	path_to_theme="~/.config/rofi/rofi_theme/white/white.rasi"
else
	path_to_theme="~/.config/rofi/rofi_theme/black/black.rasi"
fi

goback="Back 󰌍 "
quit="Exit 󰈆 "
cls_hist="Clear History 󱏫"

# --- Functions ---

get_dnd_status() {
	# dunstctl is-paused returns true/false
	if [[ $(dunstctl is-paused) == "true" ]]; then
		echo "Do Not Disturb 󰂛 : On"
	else
		echo "Do Not Disturb 󰂚 : Off"
	fi
}

noti_main_menu() {
	# 1. Check DND Status
	dnd_toggle=$(get_dnd_status)

	# 2. Fetch and filter notifications
	# Logic preserved from original script
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
    "\(.summary.data)"')

	# 3. Calculate Height
	notif_menu_height=210 # Slightly increased to account for DND row
	numbers_of_notif=$(echo "$notifications" | grep -v '^$' | wc -l)
	height_per_notif=$((notif_menu_height + (numbers_of_notif * 38)))

	[[ $height_per_notif -gt 750 ]] && height_per_notif=750

	# 4. Show Rofi
	options="$dnd_toggle\n$cls_hist\n$notifications"

	selected=$(echo -e "$quit\n$options" | rofi -x11 -dmenu \
		-theme "$path_to_theme" \
		-i -selected-row 2 \
		-p " Notifications 󱅫  " \
		-theme-str "listview {columns: 1;}" \
		-theme-str "window {location: $location; x-offset: $main_menu_x_offset; y-offset: $main_menu_y_offset; height: ${height_per_notif}px;}")

	# 5. Logic Handling
	case "$selected" in
	"") exit 0 ;;
	"$quit") exit 0 ;;
	"$dnd_toggle")
		dunstctl set-paused toggle
		noti_main_menu # Refresh menu to show updated status
		;;
	"$cls_hist")
		dunstctl history-clear
		noti_main_menu
		;;
	*)
		# If nothing above matches and it's not empty, it's a notification
		[[ -n "$selected" ]] && noti_body_menu "$selected"
		;;
	esac
}

noti_body_menu() {
	local target="$1"
	body=$(dunstctl history | jq -r --arg summary "$target" \
		'.data[0][] | select(.summary.data == $summary) | .body.data' | head -n 1)

	clean_body=$(echo "$body" | sed 's/<[^>]*>//g')

	choose_opt=$(echo -e "$goback\n$quit\nNotification Body 󰎟 :\n$clean_body" | rofi -x11 -dmenu \
		-theme "$path_to_theme" -i -selected-row 0 \
		-p " Notification Body 󰎟 " \
		-theme-str "listview {columns: 1;}" \
		-theme-str "window {location: $location; x-offset: $main_menu_x_offset; y-offset: $main_menu_y_offset;}")

	case "$choose_opt" in
	"$goback") not_main_menu ;;
	"$quit") exit 0 ;;
	esac
}

# --- Entry Point ---
noti_main_menu
