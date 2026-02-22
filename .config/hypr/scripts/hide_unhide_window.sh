#!/bin/bash
stack_file="/tmp/hide_window_pid_stack.txt"

touch "$stack_file"

function hide_window() {
	window_count=$(hyprctl activeworkspace -j | jq '.windows')

	if [[ "$window_count" -eq 0 ]]; then
		exit 0
	fi

	pid=$(hyprctl activewindow -j | jq '.pid')

	if [[ $pid != "null" ]]; then
		hyprctl dispatch movetoworkspacesilent special:magic,pid:$pid
		echo $pid >>$stack_file
		notify-send "Window hidden!" "Use Mod+Shift+D to unhide it"$'\n'"Process ID: $pid" -t 2200
	fi
}

function show_window() {
	pid=$(tail -1 $stack_file && sed -i '$d' $stack_file)
	[ -z $pid ] && exit
	notify-send "Window showed!" "Process ID: $pid"
	current_workspace=$(hyprctl activeworkspace -j | jq '.id')
	hyprctl dispatch movetoworkspacesilent $current_workspace,pid:$pid
	hyprctl dispatch focuswindow pid:$pid
}

if [ ! -z $1 ]; then
	if [ "$1" == "h" ]; then
		hide_window >>/dev/null
	else
		show_window >>/dev/null
	fi
fi
