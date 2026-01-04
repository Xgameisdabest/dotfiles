#!/bin/bash

# --- CPU Temperature ---
cpu_temp=$(sensors | awk '/^Package id 0:/ {print $4}' | tr -d '+')
if [ -z "$cpu_temp" ]; then
	cpu_temp=$(sensors | awk '/^Tctl:/ {print $2}' | tr -d '+')
fi
cpu_num=$(echo "$cpu_temp" | tr -d '°C' | cut -d'.' -f1)

# --- GPU Temperature ---
# Check NVIDIA first, then fallback to AMD/Intel via sensors
if command -v nvidia-smi &>/dev/null; then
	gpu_num=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits | head -n 1)
else
	gpu_num=$(sensors | awk '/(edge|junction|PPT):/ {print $2; exit}' | tr -d '+°C' | cut -d'.' -f1)
fi

[ -z "$gpu_num" ] && gpu_num="N/A"

# --- Fan Speeds ---
fans=$(sensors | awk '/fan[0-9]:/ {print $1 " " $2 " RPM"}')
[ -z "$fans" ] && fans="No fans detected"

# --- Logic for Waybar Class ---
if ((cpu_num >= 80)); then
	class="critical"
elif ((cpu_num >= 70)); then
	class="warning"
else
	class="normal"
fi

# --- Formatting ---
# Text shows only CPU on the bar
text="${cpu_num}°C"

# Tooltip contains the breakdown
tooltip="CPU: ${cpu_num}°C\nGPU: ${gpu_num}°C\n----------\nFans:\n$fans"

# Output JSON for Waybar
echo "{\"text\": \"$text\", \"tooltip\": \"${tooltip}\", \"class\": \"$class\"}"
