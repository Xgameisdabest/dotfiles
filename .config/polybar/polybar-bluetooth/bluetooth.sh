#!/bin/bash
dev_icon_connected() {
	connected_device_UUID=$(bluetoothctl devices Connected | awk '{print $2}')
	device_info=$(bluetoothctl info $connected_device_UUID)
	icon_dev_type=$(echo -e "$device_info" | grep Icon | sed 's/^[[:space:]]*//')
	#inputs
	if [[ $icon_dev_type =~ "input-mouse" ]]; then
		echo "%{B#2193ff} 󰦋 "
	elif [[ $icon_dev_type =~ "input-keyboard" ]]; then
		echo "%{B#2193ff} 󰌌 "
	elif [[ $icon_dev_type =~ "input-tablet" ]]; then
		echo "%{B#2193ff} 󰓶 "
	elif [[ $icon_dev_type =~ "input-gaming" ]]; then
		echo "%{B#2193ff} 󰊴 "
	#audio
	elif [[ $icon_dev_type =~ "audio-card" ]]; then
		echo "%{B#2193ff} 󰦢 "
	elif [[ $icon_dev_type =~ "audio-headset" ]] || [[ $icon_dev_type =~ "audio-headphones" ]]; then
		echo "%{B#2193ff} 󰥰 "
	#camera
	elif [[ $icon_dev_type =~ "camera-photo" ]] || [[ $icon_dev_type =~ "camera-video" ]]; then
		echo "%{B#2193ff} 󰄀 "
	#computer
	elif [[ $icon_dev_type =~ "computer" ]]; then
		echo "%{B#2193ff} 󰌢 "
	#video-display
	elif [[ $icon_dev_type =~ "video-display" ]]; then
		echo "%{B#2193ff} 󰍹 "
	#modem
	elif [[ $icon_dev_type =~ "modem" ]]; then
		echo "%{B#2193ff} 󰑩 "
	#multimedia-player
	elif [[ $icon_dev_type =~ "multimedia-player" ]]; then
		echo "%{B#2193ff} 󰾰 "
	#network-wireless
	elif [[ $icon_dev_type =~ "network-wireless" ]]; then
		echo "%{B#2193ff} 󰀂 "
	#phone
	elif [[ $icon_dev_type =~ "phone" ]]; then
		echo "%{B#2193ff}  "
	#printer
	elif [[ $icon_dev_type =~ "printer" ]]; then
		echo "%{B#2193ff} 󰨋 "
	#scanner
	elif [[ $icon_dev_type =~ "scanner" ]]; then
		echo "%{B#2193ff} 󰮄 "
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

