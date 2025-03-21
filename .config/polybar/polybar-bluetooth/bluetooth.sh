#!/bin/bash
dev_icon_connected() {
	connected_device_UUID=$(bluetoothctl devices Connected | awk '{print $2}')
	device_info=$(bluetoothctl info $connected_device_UUID)
	icon_dev_type=$(echo -e "$device_info" | grep Icon | sed 's/^[[:space:]]*//')
	if [[ $icon_dev_type =~ "input-mouse" ]]; then
		echo "%{B#2193ff} 󰦋 "
	elif [[ $icon_dev_type =~ "audio-card" ]]; then
		echo "%{B#2193ff} 󰦢 "
	elif [[ $icon_dev_type =~ "audio-headset" ]]; then
		echo "%{B#2193ff} 󰥰 "
	else
		echo "%{B#2193ff}  "
	fi
}

if [[ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]]; then
  echo "%{B#7f849c} 󰂲 "
else
  if [[ $(bluetoothctl devices Connected | grep Device | cut -d ' ' -f 3- | wc -l) -eq 0 ]]; then 
    echo "%{B#74c7ec} 󰂳 "
  fi
  dev_icon_connected
fi

