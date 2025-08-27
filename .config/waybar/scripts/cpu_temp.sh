#!/bin/bash

# Get CPU temp (adjust sensor name if needed)
temp=$(sensors | awk '/^Package id 0:/ {print $4}' | tr -d '+')
if [ -z "$temp" ]; then
    temp=$(sensors | awk '/^Tctl:/ {print $2}' | tr -d '+')
fi

# Remove °C and drop decimal part (e.g. 67.0 -> 67)
temp_num=$(echo "$temp" | tr -d '°C' | cut -d'.' -f1)

# Decide class (integers only now)
if (( temp_num >= 80 )); then
    class="critical"
elif (( temp_num >= 70 )); then
    class="warning"
else
    class="normal"
fi

# Output JSON for Waybar
echo "{\"text\": \"${temp_num}°C\", \"tooltip\": \"CPU Temp: ${temp_num}°C\", \"class\": \"$class\"}"
