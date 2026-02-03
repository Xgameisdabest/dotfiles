#!/usr/bin/env bash
# Requires: wlr-randr, bash

source ~/.config/dtf-config/config

auto_set_monitors=${auto_set_monitors:-true}

if [[ $auto_set_monitors == "true" ]]; then
	command -v wlr-randr >/dev/null 2>&1 || {
		echo "wlr-randr not found in PATH"
		exit 1
	}

	monitors=$(
		wlr-randr | awk '
	    /^[A-Za-z0-9-]+ / {output=$1}
	    /preferred/ {res=$1}
	    /^[ ]+[0-9]+x[0-9]+/ && $1==res {
		gsub(/[^0-9.]/,"",$3)
		print output, res, $3
	    }
	  ' |
			sort -k1,1 -k3,3nr |
			awk '!seen[$1]++ { printf("%s %s %s\n",$1,$2,$3) }'
	)

	# Apply settings with wlr-randr
	while read -r name res rate; do
		echo "Setting $name to ${res}@${rate}"
		hyprctl keyword monitor "$name,${res}@${rate},auto,1"
	done <<<"$monitors"
fi
