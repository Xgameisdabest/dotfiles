#!/bin/bash

# Usage: ./parse_hyprland_keybinds.sh <hyprland.conf>

cat "$1" |
	sed -e 's/  */ /g' \
		-e 's/bind[elm]\? *= *//g' \
		-e 's/, /,/g' \
		-e 's/ # /,/' \
		-e 's/,exec//g' |

	# remove empty lines and comments
	sed '/^[[:space:]]*$/d' |
	sed '/^#/d' |
	# drop variable definitions
	grep -v '^\$mod = SUPER' |
	grep -v '^\$alt = ALT' |
	sed -e 's/:/,/g' \
		-e 's/switch,on,Lid Switch/laptop lid on/g' \
		-e 's/switch,off,Lid Switch/laptop lid off/g' |
	awk -F, '{
    cmd="";
    for(i=3;i<NF;i++) cmd=cmd $(i) " ";

    if ($1 != "" && $2 != "")
        keybind = $1 " + " $2;
    else
        keybind = $1 $2;

    gsub(/\$mod/, "SUPER", keybind);
    gsub(/\$alt/, "ALT", keybind);

    # replace "|" with "+"
    gsub(/\|/, "+", keybind);

    # collapse multiple "+" into one
    gsub(/\++/, "+", keybind);

    # remove spaces around "+"
    gsub(/ *\+ */, " + ", keybind);

    gsub(/^ +| +$/, "", keybind);
 
    # build command from fields 3..NF-1
    cmd="";
    for (i=3; i<NF; i++) {
        if (cmd != "") cmd = cmd " ";
        cmd = cmd $i;
    }

    last = (NF >= 3 ? $NF : "");

    # print with commas so OFS inserts spaces; no accidental concatenation
    if (cmd != "" && last != "")  print keybind ": ", cmd, last;
    else if (last != "")          print keybind ": ", last;
    else if (cmd != "")           print keybind ": ", cmd;
    else                          print keybind;
  }' |
	sed 's/SUPER SHIFT/SUPER + SHIFT/g'
