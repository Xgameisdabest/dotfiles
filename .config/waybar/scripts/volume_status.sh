#!/bin/bash

print_volume() {
  mute=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
  volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]{1,3}(?=%)' | head -1)
  sink_name=$(pactl get-default-sink)
  # try to get a friendly description (e.g. "Built-in Audio Analog Stereo" / "Headphones")
  device_desc=$(pactl list sinks | grep -A2 "Name: $sink_name" | grep "Description:" | cut -d: -f2- | xargs)

  if [ "$mute" = "yes" ]; then
    icon=""
  elif [ "$volume" -lt 25 ]; then
    icon=""
  elif [ "$volume" -lt 50 ]; then
    icon=""
  else
    icon=""
  fi

  # Waybar custom module JSON
  echo "{\"text\": \"$icon  ${volume}%\", \"tooltip\": \"$device_desc\"}"
}

# print initial state
print_volume

# update on sink events
pactl subscribe | grep --line-buffered "sink" | while read -r _; do
  print_volume
done
