#!/usr/bin/bash

# Dependency List
DEPS="zsh hyprland swaybg hyprsunset hypridle hyprlock waybar rofi ncal neovim alacritty dunst libnotify-bin btop thunar blueman pipewire-pulse pipewire network-manager fzf udev lsd jq wl-clipboard power-profiles-daemon acpi swaybg bsdmainutils light kitty iw wlr-randr gawk paplay xwayland hyprpolkitagent hyprland-qt-support0 tty-clock socat"

# Default to the home directory for searching the dotfiles repository
search_dir="$HOME"
marker_file=".dotfiles_target_file"

# Search for the dotfiles directory
dtf_dir_detect=$(locate "$marker_file" | grep "$search_dir" | tail -n 1 | xargs dirname)

if [ -z "$dtf_dir_detect" ]; then
	echo "Error: Could not locate dotfiles directory with marker $marker_file"
	exit 1
fi

cd "$dtf_dir_detect"

# Updated logic: Check/Install dependencies, then pull and restow
$TERMINAL -e bash -c "
    echo '--- Checking/Installing Dependencies ---';
    sudo apt update && sudo apt install -y $DEPS || { echo 'Dependency install failed!'; read -p 'Press <ENTER> to exit...'; exit 1; };

    echo '--- Pulling latest changes ---';
    git pull || { echo 'Update failed, unable to perform git pull!'; read -p 'Press <ENTER> to exit...'; exit 1; };

    echo '--- Refreshing Dotfiles ---';
    stow -D . && stow . || { echo 'Stow failed!'; read -p 'Press <ENTER> to exit...'; exit 1; };
    
    sudo updatedb;
    hyprctl reload;
    
    clear;
    echo 'Update completed successfully!';
    read -p 'Press <ENTER> to see the changes, \"󰖳 + x\" to quit!';
    git diff HEAD@{1}
"
