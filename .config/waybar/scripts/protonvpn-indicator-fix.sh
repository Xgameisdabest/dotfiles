#!/bin/bash

PROCESS="protonvpn-app"

if pgrep -x "$PROCESS" >/dev/null; then
	killall "$PROCESS" 2>/dev/null

	while pgrep -x "$PROCESS" >/dev/null; do sleep 0.2; done

	sleep 2

	protonvpn-app --start-minimized &
fi
