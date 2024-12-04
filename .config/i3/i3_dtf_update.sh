#!/usr/bin/bash

# Default to the home directory for searching the dotfiles repository
search_dir="$HOME"

# The special marker file to indicate the dotfiles directory
marker_file="preview_img"

# Search for the dotfiles directory that contains the marker file
dtf_dir=$(locate "$marker_file" | grep "$search_dir" | tail -n 1 | xargs dirname)
echo $dtf_dir

if [[ -z "$dtf_dir" ]]; then
    echo "Dotfiles directory not found."
    exit 1
fi

# Check the git status in the found dotfiles directory
check_update=$(cd "$dtf_dir" && git status --short)

# Check if there is any output indicating changes (uncommitted or untracked files)
if [[ -z "$check_update" ]]; then
    # No changes detected, repository is up to date
    notify-send "Dotfiles Update" "Your dotfiles are up to date!"
    echo "Dotfiles are up to date."
else
    # There are changes, send a notification
    notify-send "Dotfiles Update" "Your dotfiles are not up to date!"
    echo "Dotfiles are not up to date!"
fi
