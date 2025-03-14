#!/bin/sh
if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]
then
  #echo "%{F#7f849c}󰂲"
  echo "%{B#7f849c}  󰂲  "
else
  if [ $(echo info | bluetoothctl | grep 'Device' | wc -c) -eq 0 ]
  then 
    #echo "%{F#ff215c}󰂳"
    echo "  %{B#ff215c}  󰂳  "
  fi
  echo "%{B#2193ff}    "
fi

