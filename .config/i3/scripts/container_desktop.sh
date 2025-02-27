#!/usr/bin/env bash

DIRECTION=$1
CURRENT=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).name' | cut -d"\"" -f2)

DEFAULT=1
MIN=$(i3-msg -t get_workspaces | jq '.[0].num')
MAX=$(i3-msg -t get_workspaces | jq '.[-1].num')

if [ $CURRENT -eq $DEFAULT ] && [ $DIRECTION = "prev" ]; then
	exit 0
fi

if [ $CURRENT -eq $MAX ] && [ $DIRECTION = "next" ]; then
	DIRECTION=$((CURRENT+1))
fi

if [ $CURRENT != $DEFAULT ] && [ $DIRECTION = "prev" ]; then
	DIRECTION=$((CURRENT-1))
fi

if [ $CURRENT != $MAX ] && [ $DIRECTION = "next" ]; then
	DIRECTION=$((CURRENT+1))
fi

i3-msg move container to workspace $DIRECTION
