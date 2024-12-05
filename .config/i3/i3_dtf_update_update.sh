#!/usr/bin/bash

# Default to the home directory for searching the dotfiles repository
search_dir="$HOME"

# The special marker file to indicate the dotfiles directory
marker_file="preview_img"

# Search for the dotfiles directory that contains the marker file
dtf_dir_detect=$(locate "$marker_file" | grep "$search_dir" | tail -n 1 | xargs dirname)

# Move back one directory to the parent directory
parent_dir=$(dirname "$dtf_dir_detect")

# Change to the parent directory
cd "$parent_dir"

# Perform a git pull in the parent directory
$TERMINAL -e bash -c "git pull; read -p 'Update completed. Press Enter to exit...'"
