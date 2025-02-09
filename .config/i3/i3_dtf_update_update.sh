#!/usr/bin/bash

# Default to the home directory for searching the dotfiles repository
search_dir="$HOME"

# The special marker file to indicate the dotfiles directory
marker_file=".dotfiles_target_file"

# Search for the dotfiles directory that contains the marker file
dtf_dir_detect=$(locate "$marker_file" | grep "$search_dir" | tail -n 1 | xargs dirname)

cd "$dtf_dir_detect"

# Perform a git pull in the parent directory
$TERMINAL -e bash -c "git pull || { clear; read -p 'Update failed, unable to perform git pull! Press <ENTER> to exit...'; exit 0; }; read -p 'Update completed. Press <ENTER> to continue and restart...';echo 'You will be prompted to enter your password in order to run the updatedb command';stow --adopt .;sudo updatedb; i3-msg restart; clear; read -p 'Press <ENTER> to continue to see the changes, \"󰖳 + x\" to quit!';git diff HEAD@{1}"
