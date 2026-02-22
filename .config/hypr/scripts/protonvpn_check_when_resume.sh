#!/usr/bin/env bash

# get the interface via ip a
protonvpn_check=$(ip a | grep proton | wc -m)

# perform checks
if [[ $protonvpn_check > 0 ]]; then
	protonvpn-app --start-minimized
else
	exit 0
fi
