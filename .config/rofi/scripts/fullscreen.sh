#!/usr/bin/sh
polybar-msg cmd hide
rofi -theme ~/.config/rofi/rofi_theme/black-and-white-theme-fullscreen.rasi -show drun
polybar-msg cmd show
