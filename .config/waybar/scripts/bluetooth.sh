#!/bin/bash

dev_icon_connected() {
    connected_device_UUID=$(bluetoothctl devices Connected | awk '{print $2}')
    device_info=$(bluetoothctl info "$connected_device_UUID")
    icon_dev_type=$(echo -e "$device_info" | grep Icon | sed 's/^[[:space:]]*//')

    # Map device types to icons
    case "$icon_dev_type" in
        *input-mouse*)        echo "󰦋" ;;
        *input-keyboard*)     echo "󰌌" ;;
        *input-tablet*)       echo "󰓶" ;;
        *input-gaming*)       echo "󰊴" ;;
        *audio-card*)         echo "󰦢" ;;
        *audio-headset*|*audio-headphones*) echo "󰥰" ;;
        *camera-photo*|*camera-video*) echo "󰄀" ;;
        *computer*)           echo "󰌢" ;;
        *video-display*)      echo "󰍹" ;;
        *modem*)              echo "󰑩" ;;
        *multimedia-player*)  echo "󰾰" ;;
        *network-wireless*)   echo "󰀂" ;;
        *phone*)              echo "" ;;
        *printer*)            echo "󰨋" ;;
        *scanner*)            echo "󰮄" ;;
        *)                    echo "󰂱" ;;
    esac
}

while true; do
    connected_devices_count=$(bluetoothctl devices Connected | grep Device | wc -l)
    powered=$(bluetoothctl show | grep "Powered: yes" | wc -l)

    if [[ $powered -eq 0 ]]; then
        echo "{\"text\":\"󰂲\",\"class\":\"powered-off\"}"
    else
        if [[ $connected_devices_count -eq 0 ]]; then
            echo "{\"text\":\"󰂳\",\"class\":\"no-devices\"}"
        elif [[ $connected_devices_count -eq 1 ]]; then
            icon=$(dev_icon_connected)
            echo "{\"text\":\"$icon\",\"class\":\"one-device\"}"
        else
            echo "{\"text\":\"󰂱 $connected_devices_count\",\"class\":\"multiple-devices\"}"
        fi
    fi

    sleep 0.5
done
