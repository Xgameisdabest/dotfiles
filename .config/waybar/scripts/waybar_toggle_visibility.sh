#!/bin/bash

# waybar toggle script, can be used universally in this dotfiles

if [ -f /tmp/waybar.hidden ]; then
	rm /tmp/waybar.hidden
	pkill -USR1 waybar
else
	touch /tmp/waybar.hidden
	pkill -USR1 waybar
fi
