#!/usr/bin/bash
input=$(rofi -dmenu -i -theme-str "window {height: 90px; width: 300px;}" -p " 󰖯  󰖲 ")
if [[ $input != "" ]]; then
	i3-msg move container to workspace $input
else
	exit 0
fi
