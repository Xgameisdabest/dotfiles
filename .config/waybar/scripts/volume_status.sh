#!/bin/bash

print_volume() {
  mute=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
  volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]{1,3}(?=%)' | head -1)

  if [ "$mute" = "yes" ]; then
    echo "  ${volume}%"
  else
    if [ "$volume" -lt 25 ]; then
      echo "  ${volume}%"
    elif [ "$volume" -lt 50 ]; then
      echo "  ${volume}%"
    else
      echo "  ${volume}%"
    fi
  fi
}

# print initial state
print_volume

# listen for volume/mute changes
pactl subscribe | grep --line-buffered "sink" | while read -r _; do
  print_volume
done

