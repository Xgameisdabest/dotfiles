#!/usr/bin/bash
input=$(rofi -dmenu -i -theme-str "window {height: 90px; width: 300px;}" -p " Workspace  ")
if [[ $input != "" ]]; then
	i3-msg workspace $input
else
	exit 0
fi
