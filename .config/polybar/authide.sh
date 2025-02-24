#!/bin/bash

TOP_MARGIN=65

while true; do
    MOUSE_POSITION=$(xdotool getmouselocation --shell)
    eval $MOUSE_POSITION

    if [ "$Y" -le "$TOP_MARGIN" ]; then
        polybar-msg cmd show
    else
        polybar-msg cmd hide
    fi

    sleep 0.2
done
