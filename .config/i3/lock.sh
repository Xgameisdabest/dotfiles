#!/bin/sh
set -e
xset s off dpms 0 0 0
betterlockscreen -l
#systemctl suspend
xset s off -dpms
