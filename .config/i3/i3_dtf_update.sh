#!/usr/bin/bash

# Default to the home directory for searching the dotfiles repository
search_dir="$HOME"

# The special marker file to indicate the dotfiles directory
marker_file=".dotfiles_target_file"

# Search for the dotfiles directory that contains the marker file
dtf_dir=$(locate "$marker_file" | grep "$search_dir" | tail -n 1 | xargs dirname)

if [[ -z "$dtf_dir" ]]; then
    exit 1
fi

# Check if the git repository is ahead/behind with respect to the remote repository
check_update=$(cd "$dtf_dir" && git status -uno)

# Check if there is any output indicating the repository is behind or has diverged
if [[ "$check_update" == *"Your branch is up to date with"* ]]; then
    # No update required, repository is up to date
    notify-send "Dotfiles Update  " "Your dotfiles are up to date!"
else
    # There are changes in the remote (e.g., behind, diverged), send a notification
    notify-send "Dotfiles Update  " "Your dotfiles are not up to date!"
fi

