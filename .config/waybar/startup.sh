#!/usr/bin/bash

source ~/.config/dtf-config/config
bar_color=${bar_color:-black}
bar_top=${bar_top:-false}

killall -SIGINT waybar

if [[ $bar_color == "black" ]] && [[ $bar_top == "false" ]]; then
	waybar -s ~/.config/waybar/bar_style/dark.css -c ~/.config/waybar/bar_config/bottom_bar.jsonc &

elif [[ $bar_color == "white" ]] && [[ $bar_top == "false" ]]; then
	waybar -s ~/.config/waybar/bar_style/white.css -c ~/.config/waybar/bar_config/bottom_bar.jsonc &

elif [[ $bar_color == "black" ]] && [[ $bar_top == "true" ]]; then
	waybar -s ~/.config/waybar/bar_style/dark.css -c ~/.config/waybar/bar_config/top_bar.jsonc &

elif [[ $bar_color == "white" ]] && [[ $bar_top == "true" ]]; then
	waybar -s ~/.config/waybar/bar_style/white.css -c ~/.config/waybar/bar_config/bottom_bar.jsonc &

else
	waybar -s ~/.config/waybar/bar_style/dark.css -c ~/.config/waybar/bar_config/bottom_bar.jsonc &

fi
