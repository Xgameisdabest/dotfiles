#!/usr/bin/bash

# Default to the home directory for searching the dotfiles repository
search_dir="$HOME"

# The special marker file to indicate the dotfiles directory
marker_file=".dotfiles_target_file"

# Search for the dotfiles directory that contains the marker file
dtf_dir_detect=$(locate "$marker_file" | grep "$search_dir" | tail -n 1 | xargs dirname)

cd "$dtf_dir_detect"

# Perform a git pull in the parent directory
$TERMINAL -e bash -c "git pull; read -p 'Update completed. Press Enter to exit...'"
