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

# Check the git status in the found dotfiles directory
check_update=$(cd "$dtf_dir" && git status -uno)

# Check if there is any output indicating changes (uncommitted or untracked files)
if [[ "$check_update" == *"Your branch is up to date with"* ]]; then
    # No changes detected, repository is up to date
    echo ""
else
    echo " Update Available!"
fi
