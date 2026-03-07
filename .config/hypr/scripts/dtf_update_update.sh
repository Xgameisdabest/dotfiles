#!/usr/bin/bash

# Base Dependency List (Removed power-profiles-daemon from here to handle it conditionally)
DEPS="zsh hyprland swaybg hyprsunset hypridle hyprlock waybar rofi ncal neovim alacritty kitty dunst libnotify-bin btop thunar blueman pipewire-pulse pipewire network-manager fzf udev lsd jq wl-clipboard acpi bsdmainutils light iw wlr-randr gawk pulseaudio-utils xwayland hyprpolkitagent hyprland-qt-support0 tty-clock socat"

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

# Logic to build the final install list
FINAL_INSTALL_LIST=""

for pkg in $DEPS; do
	if ! dpkg -l | grep -qw "$pkg" &>/dev/null; then
		FINAL_INSTALL_LIST="$FINAL_INSTALL_LIST $pkg"
	fi
done

# --- Conflict Handling: auto-cpufreq vs power-profiles-daemon ---
# Check if auto-cpufreq is installed (binary check covers git/snap/apt installs)
if command -v auto-cpufreq &>/dev/null; then
	echo "--> auto-cpufreq detected. Skipping power-profiles-daemon to prevent conflicts."
else
	# If auto-cpufreq isn't there, check if PPD is already installed
	if ! dpkg -l | grep -qw "power-profiles-daemon" &>/dev/null; then
		echo "--> auto-cpufreq not found. Adding power-profiles-daemon to install list."
		FINAL_INSTALL_LIST="$FINAL_INSTALL_LIST power-profiles-daemon"
	fi
fi

$TERMINAL -e bash -c "
    echo '--- Pulling latest changes ---';
    git pull || { echo 'Update failed!'; read -p 'Press <ENTER> to exit...'; exit 1; };

    echo '--- Refreshing Dotfiles ---';
    stow -D . && stow . || { echo 'Stow failed!'; read -p 'Press <ENTER> to exit...'; exit 1; };
    
    sudo updatedb;

    echo '--- Checking/Installing Dependencies ---';
    if [ -n \"$FINAL_INSTALL_LIST\" ]; then
        echo 'Installing missing: $FINAL_INSTALL_LIST'
        sudo apt update && sudo apt install -y $FINAL_INSTALL_LIST || { echo 'Install failed!'; read -p 'Press <ENTER> to exit...'; exit 1; };
    else
        echo 'All dependencies (including power management logic) are satisfied.';
    fi
 
    hyprctl reload;
    
    clear;
    echo 'Update completed successfully!';
    read -p 'Press <ENTER> to see git diff, \"󰖳 + x\" to quit!';
    git diff HEAD@{1}
" &
