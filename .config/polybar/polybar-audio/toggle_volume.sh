#!/bin/sh
if [ $(pactl get-sink-mute @DEFAULT_SINK@ | sed 's/Mute: //g') = "no" ] 
then
  echo "󰕾 "
else
  echo "%{F#7f849c}󰝟 "
fi
