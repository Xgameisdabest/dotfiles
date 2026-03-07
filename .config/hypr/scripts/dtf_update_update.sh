#!/usr/bin/bash

# Configuration
search_dir="$HOME"
marker_file=".dotfiles_target_file"
deps_file="dependencies.txt" # The file inside your repo

# 1. Locate the dotfiles directory
dtf_dir_detect=$(locate "$marker_file" | grep "$search_dir" | tail -n 1 | xargs dirname)

if [ -z "$dtf_dir_detect" ]; then
	echo "Error: Could not locate dotfiles directory."
	exit 1
fi

cd "$dtf_dir_detect"

# 2. Execute the logic inside the terminal wrapper
# We pull BEFORE checking dependencies so the list is fresh
$TERMINAL -e bash -c "
    echo '--- Pulling latest changes ---';
    git pull || { echo 'Update failed!'; read -p 'Press <ENTER> to exit...'; exit 1; };

    echo '--- Loading Dependencies from $deps_file ---';
    if [ ! -f \"$deps_file\" ]; then
        echo 'Error: $deps_file not found in repo!';
        read -p 'Press <ENTER> to exit...'; exit 1;
    fi

    # Read file and build DEPS list
    DEPS=\$(tr '\n' ' ' < \"$deps_file\")
    FINAL_INSTALL_LIST=\"\"

    for pkg in \$DEPS; do
        if ! dpkg -l | grep -qw \"\$pkg\" &>/dev/null; then
            FINAL_INSTALL_LIST=\"\$FINAL_INSTALL_LIST \$pkg\"
        fi
    done

    # Conflict Handling: auto-cpufreq vs power-profiles-daemon
    if command -v auto-cpufreq &>/dev/null; then
        echo '--> auto-cpufreq detected. Skipping power-profiles-daemon.'
    elif ! dpkg -l | grep -qw 'power-profiles-daemon' &>/dev/null; then
        echo '--> Adding power-profiles-daemon to install list.'
        FINAL_INSTALL_LIST=\"\$FINAL_INSTALL_LIST power-profiles-daemon\"
    fi

    echo '--- Checking/Installing Dependencies ---';
    if [ -n \"\$FINAL_INSTALL_LIST\" ]; then
        echo \"Installing missing: \$FINAL_INSTALL_LIST\"
        sudo apt update && sudo apt install -y \$FINAL_INSTALL_LIST || { echo 'Install failed!'; read -p 'Press <ENTER> to exit...'; exit 1; };
    else
        echo 'All dependencies satisfied.';
    fi

    echo '--- Refreshing Dotfiles ---';
    stow -D . && stow . || { echo 'Stow failed!'; read -p 'Press <ENTER> to exit...'; exit 1; };
    
    sudo updatedb;
    hyprctl reload;
    
    clear;
    echo 'Update completed successfully!';
    read -p 'Press <ENTER> to see git diff, \"󰖳 + x\" to quit!';
    git diff HEAD@{1}
" &
