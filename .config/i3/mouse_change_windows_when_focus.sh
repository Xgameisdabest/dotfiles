#!/bin/sh
set -e

output=$(xdotool getactivewindow getwindowgeometry --shell) 
read -r window width height << EOF
$( echo $(echo $output | awk '{print $1; print $4; print $5;}' | cut -d "=" -f 2) )
EOF

move_y=$((height / 2))
move_x=$((width / 2))

xdotool mousemove --window $window $move_x $move_y
