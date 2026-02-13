#!/bin/bash

# Capture neofetch output to a variable to measure it
# Use -nc (no color) for the measurement to get accurate character counts
NF_OUT=$(neofetch --color_blocks off)
NF_WIDTH=$(echo "$NF_OUT" | wc -L)     # Get the length of the longest line
NF_HEIGHT=$(echo "$NF_OUT" | wc -l)    # Count total number of lines

# Get current terminal size
TERM_WIDTH=$(tput cols)
TERM_HEIGHT=$(tput lines)

# Calculate gaps
V_GAP=$(( (TERM_HEIGHT - NF_HEIGHT) / 2 + 3))
H_GAP=$(( (TERM_WIDTH - NF_WIDTH) / 2))

# Prevent negative values if window is too small
[ $V_GAP -lt 0 ] && V_GAP=0
[ $H_GAP -lt 0 ] && H_GAP=0

clear

# Print vertical padding
for ((i = 0; i < V_GAP; i++)); do echo ""; done

# Print horizontal padding + Neofetch
# We run neofetch normally here so you keep your colors/icons
neofetch | sed "s/^/$(printf '%*s' $H_GAP)/"

# Exit logic
tput civis # Hide cursor
read -rsn 1 # Wait for any key
tput cnorm # Show cursor
clear
exit 0
