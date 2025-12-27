#!/usr/bin/bash

source ~/.config/dtf-config/config
bar_color=${bar_color:-black}
bar_top=${bar_top:-false}
bar_expressive_style=${bar_expressive_style:-false}
bar_dynamic_style=${bar_dynamic_style:-false}

killall -SIGINT waybar

if [[ $bar_dynamic_style == "true" ]] && [[ $bar_top == "false" ]] && [[ $bar_color == "black" ]]; then
	waybar -s ~/.config/waybar/bar_style/dynamic.css -c ~/.config/waybar/bar_config/bottom_bar.jsonc &

elif [[ $bar_expressive_style == "true" ]] && [[ $bar_top == "false" ]] && [[ $bar_color == "black" ]]; then
	waybar -s ~/.config/waybar/bar_style/expressive.css -c ~/.config/waybar/bar_config/bottom_bar.jsonc &

elif [[ $bar_dynamic_style == "true" ]] && [[ $bar_top == "true" ]] && [[ $bar_color == "black" ]]; then
	waybar -s ~/.config/waybar/bar_style/dynamic.css -c ~/.config/waybar/bar_config/top_bar.jsonc &

elif [[ $bar_expressive_style == "true" ]] && [[ $bar_top == "true" ]] && [[ $bar_color == "black" ]]; then
	waybar -s ~/.config/waybar/bar_style/expressive.css -c ~/.config/waybar/bar_config/top_bar.jsonc &

elif [[ $bar_expressive_style == "true" ]] && [[ $bar_top == "true" ]] && [[ $bar_color == "black" ]]; then
	waybar -s ~/.config/waybar/bar_style/expressive.css -c ~/.config/waybar/bar_config/top_bar.jsonc &

elif [[ $bar_color == "black" ]] && [[ $bar_top == "false" ]]; then
	waybar -s ~/.config/waybar/bar_style/dark.css -c ~/.config/waybar/bar_config/bottom_bar.jsonc &

elif [[ $bar_color == "white" ]] && [[ $bar_top == "false" ]]; then
	waybar -s ~/.config/waybar/bar_style/white.css -c ~/.config/waybar/bar_config/bottom_bar.jsonc &

elif [[ $bar_color == "black" ]] && [[ $bar_top == "true" ]]; then
	waybar -s ~/.config/waybar/bar_style/dark.css -c ~/.config/waybar/bar_config/top_bar.jsonc &

elif [[ $bar_color == "white" ]] && [[ $bar_top == "true" ]]; then
	waybar -s ~/.config/waybar/bar_style/white.css -c ~/.config/waybar/bar_config/top_bar.jsonc &

else
	waybar -s ~/.config/waybar/bar_style/dark.css -c ~/.config/waybar/bar_config/bottom_bar.jsonc &
fi
