#!/bin/bash

# Get CPU temp (adjust sensor name if needed)
temp=$(sensors | awk '/^Package id 0:/ {print $4}' | tr -d '+')
if [ -z "$temp" ]; then
	temp=$(sensors | awk '/^Tctl:/ {print $2}' | tr -d '+')
fi

# Remove °C and drop decimal part (e.g. 67.0 -> 67)
temp_num=$(echo "$temp" | tr -d '°C' | cut -d'.' -f1)

# Get all fan speeds (adjust regex depending on your sensors output)
fans=$(sensors | awk '/fan[0-9]:/ {print $1 " " $2 " RPM"}')

if [ -z "$fans" ]; then
	fans="No fans detected"
fi

# Decide class (integers only now)
if ((temp_num >= 80)); then
	class="critical"
elif ((temp_num >= 70)); then
	class="warning"
else
	class="normal"
fi

# Escape newlines for JSON output
tooltip="CPU Temp: ${temp_num}°C\n$fans"

# Output JSON for Waybar
echo "{\"text\": \"${temp_num}°C\", \"tooltip\": \"${tooltip}\", \"class\": \"$class\"}"
