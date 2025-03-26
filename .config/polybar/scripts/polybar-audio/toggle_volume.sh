#!/bin/bash

check_volume_level(){
	
	volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]{1,3}(?=%)' | head -1)
	
	    if [ "$volume" -lt 25 ]; then
		echo "%{B#bac2de}   $volume% "
	    elif [ "$volume" -lt 50 ]; then
		echo "%{B#bac2de}   $volume% "
	    elif [ "$volume" -le 100 ]; then 
		echo "%{B#bac2de}   $volume% "
	    else 
		echo "%{B#bac2de}   $volume% "
	    fi

}

if [ $(pactl get-sink-mute @DEFAULT_SINK@ | sed 's/Mute: //g') = "no" ];
then
  check_volume_level
else
	echo "%{B#7f849c}   $(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]{1,3}(?=%)' | head -1)% "
fi
