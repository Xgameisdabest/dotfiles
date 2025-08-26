#!/usr/bin/bash

search_dir="$HOME"

marker_file=".dotfiles_target_file"

dtf_dir=$(locate "$marker_file" | grep "$search_dir" | tail -n 1 | xargs dirname)

if [[ -z "$dtf_dir" ]]; then
    exit 1
fi

check_update=$(cd "$dtf_dir" && git fetch >/dev/null 2>&1 && git status -uno)

if [[ -z "$check_update" ]]; then
    echo ""
elif [[ "$check_update" == *"Your branch is up-to-date with"* ]] || [[ "$check_update" == *"Your branch is up to date with"* ]]; then
    echo ""
else
    echo " Update!"
fi

