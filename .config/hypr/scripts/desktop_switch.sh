#!/usr/bin/env bash

DIRECTION=$1
CURRENT=$(hyprctl -j monitors | jq -r '.[] | select(.focused==true).activeWorkspace.id')

# Fallback if CURRENT is empty
if [ -z "$CURRENT" ]; then
    echo "Could not determine current workspace."
    exit 1
fi

WORKSPACES=$(hyprctl -j workspaces | jq -r '.[].id')
MIN=$(echo "$WORKSPACES" | sort -n | head -n1)
MAX=$(echo "$WORKSPACES" | sort -n | tail -n1)
DEFAULT=1

if [ "$CURRENT" -eq "$DEFAULT" ] && [ "$DIRECTION" = "prev" ]; then
    exit 0
fi

if [ "$CURRENT" -eq "$MAX" ] && [ "$DIRECTION" = "next" ]; then
    DIRECTION=$((CURRENT+1))
fi

if [ "$CURRENT" -ne "$DEFAULT" ] && [ "$DIRECTION" = "prev" ]; then
    DIRECTION=$((CURRENT-1))
fi

if [ "$CURRENT" -ne "$MAX" ] && [ "$DIRECTION" = "next" ]; then
    DIRECTION=$((CURRENT+1))
fi

# Move focused window to target workspace
hyprctl dispatch workspace "$DIRECTION"
