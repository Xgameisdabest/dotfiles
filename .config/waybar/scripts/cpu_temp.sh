#!/bin/bash

# --- Initialize Variables ---
max_cpu=0
max_id=0
cpu_list=""
gpu_list=""
fan_list=""
drive_list=""

# Helper function to get status text
get_status() {
	local temp=$1
	local crit=$2
	local warn=$3
	if ((temp >= crit)); then
		echo "Critical"
	elif ((temp >= warn)); then
		echo "Underload"
	else
		echo "Safe"
	fi
}

# --- 1. CPU Temperatures (Multi-Package) ---
while read -r line; do
	id=$(echo "$line" | awk -F'[: ]+' '{print $3}')
	temp=$(echo "$line" | awk '{print $4}' | tr -d '+°C' | cut -d'.' -f1)

	if [ -n "$temp" ]; then
		status=$(get_status "$temp" 85 77)
		cpu_list="${cpu_list} CPU $id: ${temp}°C ($status)\n"
		if ((temp > max_cpu)); then
			max_cpu=$temp
			max_id=$id
		fi
	fi
done < <(sensors | grep "Package id")

# --- 2. GPU, Fans, and SSDs ---
current_adapter=""
while read -r line; do
	if [[ "$line" == *"-pci-"* ]] || [[ "$line" == *"-isa-"* ]]; then
		current_adapter=$(echo "$line" | awk '{print $1}')
	fi

	# GPU Temp
	if [[ "$line" == *"edge:"* ]]; then
		g_temp=$(echo "$line" | awk '{print $2}' | tr -d '+°C' | cut -d'.' -f1)
		status=$(get_status "$g_temp" 85 75)
		gpu_list="${gpu_list} GPU 0: ${g_temp}°C ($status)\n"
	fi

	# Fan Speeds
	if [[ "$line" == *"fan"* ]]; then
		f_speed=$(echo "$line" | awk '{print $2}')
		if [[ "$f_speed" =~ ^[0-9]+$ ]]; then
			f_label=$(echo "$line" | awk -F: '{print $1}')
			fan_list="${fan_list} ${f_label}: ${f_speed} RPM\n"
		fi
	fi

	# SSD Temperatures
	if [[ "$line" == *"Composite:"* ]]; then
		d_temp=$(echo "$line" | awk '{print $2}' | tr -d '+°C' | cut -d'.' -f1)
		status=$(get_status "$d_temp" 70 55)
		d_label=$(echo "$current_adapter" | sed 's/nvme-pci-/NVMe /')
		drive_list="${drive_list} ${d_label}: ${d_temp}°C ($status)\n"
	fi
done < <(sensors)

# --- Formatting Cleanup ---
cpu_list="${cpu_list%\\n}"
gpu_list="${gpu_list%\\n}"
fan_list="${fan_list%\\n}"
drive_list="${drive_list%\\n}"

[ -z "$gpu_list" ] && gpu_list=" Not Available"
[ -z "$fan_list" ] && fan_list=" Not Available"
[ -z "$drive_list" ] && drive_list=" Not Available"

# --- Waybar Class Logic ---
class="normal"
((max_cpu >= 70)) && class="warning"
((max_cpu >= 80)) && class="critical"

# --- Final JSON Output ---
tooltip="󱎴  Currently shown: CPU $max_id \n  CPU:\n$cpu_list\n󰢮  GPU:\n$gpu_list\n󰋊  SSD:\n$drive_list\n  FAN:\n$fan_list"

echo "{\"text\": \"${max_cpu}°C\", \"tooltip\": \"$tooltip\", \"class\": \"$class\"}"
