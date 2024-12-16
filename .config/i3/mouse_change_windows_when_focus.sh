#!/bin/bash
XDT=/usr/bin/xdotool

WINDOW=`$XDT getwindowfocus`

# this brings in variables WIDTH and HEIGHT
eval `xdotool getwindowgeometry --shell $WINDOW`

TX=`expr $WIDTH / 2`
TY=`expr $HEIGHT / 2`

if [[ $WINDOW != 4194398 ]]; then
	$XDT mousemove -window $WINDOW $TX $TY
fi
