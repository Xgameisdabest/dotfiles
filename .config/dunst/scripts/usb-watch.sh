#!/bin/bash

PIDFILE="/tmp/usb-watch.pid"

source ~/.config/dtf-config/config
usb_notification=${usb_notification:-false}

# If usb_notification is false → kill existing instance if alive, then quit
if [[ $usb_notification == "false" ]]; then
    if [[ -f "$PIDFILE" ]] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
        kill "$(cat "$PIDFILE")" 2>/dev/null
        rm -f "$PIDFILE"
	pkill udevadm
	pkill usb-watch.sh
        echo "usb-watch stopped"
    else
	pkill udevadm
	pkill usb-watch.sh
        echo "usb-watch not running"
    fi
    exit 0
fi

# If it's already running, quit to avoid duplicate instances
if [[ -f "$PIDFILE" ]] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
    echo "usb-watch already running"
    exit 0
fi

# Save PID and ensure cleanup on exit
echo $$ > "$PIDFILE"
trap "rm -f $PIDFILE" EXIT

# Main logic
declare -A DEVINFO
udevadm monitor --udev --subsystem-match=usb | \
while read -r _ _ action devpath _; do
    case $action in
        add)
            [[ $(udevadm info --query=property --path="$devpath" | awk -F= '/DEVTYPE=/{print $2}') != "usb_device" ]] && continue
            info=$(udevadm info --query=property --path="$devpath" | awk -F= '/ID_VENDOR=|ID_MODEL=/{print $2}' | xargs)
            DEVINFO["$devpath"]="$info"
            notify-send "USB connected" "$info"
            echo "USB connected" "$info"
            ;;
        remove)
            [[ "$devpath" =~ :[0-9]+\.[0-9]+$ ]] && continue
            info="${DEVINFO[$devpath]}"
            notify-send "USB removed" "${info:-$devpath}"
            echo "USB removed" "${info:-$devpath}"
            unset DEVINFO["$devpath"]
            ;;
    esac
done

