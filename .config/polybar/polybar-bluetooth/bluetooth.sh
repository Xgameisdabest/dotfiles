#!/bin/sh
if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]
then
  #echo "%{F#7f849c}󰂲"
  echo "󰂲"
else
  if [ $(echo info | bluetoothctl | grep 'Device' | wc -c) -eq 0 ]
  then 
    #echo "%{F#ff215c}󰂳"
    echo "󰂳"
  fi
  echo ""
fi

