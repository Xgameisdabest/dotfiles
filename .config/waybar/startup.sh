#!/usr/bin/bash

LOCK_FILE="/tmp/waybar_launch.lock"

if [[ -f "$LOCK_FILE" ]]; then
	exit 0
fi

touch "$LOCK_FILE"

killall -SIGINT waybar 2>/dev/null
while pgrep -u $USER -x waybar >/dev/null; do sleep 0.1; done

source ~/.config/dtf-config/config
bar_color=${bar_color:-black}
bar_top=${bar_top:-false}
bar_expressive_style=${bar_expressive_style:-false}
bar_dynamic_style=${bar_dynamic_style:-false}

CONFIG_DIR="$HOME/.config/waybar/bar_config"
STYLE_DIR="$HOME/.config/waybar/bar_style"

CONF="bottom_bar.jsonc"
STYLE="dark.css"

if [[ $bar_top == "true" ]]; then CONF="top_bar.jsonc"; fi

if [[ $bar_dynamic_style == "true" ]]; then
	STYLE="dynamic.css"
elif [[ $bar_expressive_style == "true" ]]; then
	STYLE="expressive.css"
elif [[ $bar_color == "white" ]]; then
	STYLE="white.css"
fi

waybar -s "$STYLE_DIR/$STYLE" -c "$CONFIG_DIR/$CONF" &
paplay $HOME/.config/dunst/scripts/sounds/button-toggle.ogg

sleep 1
rm "$LOCK_FILE"
