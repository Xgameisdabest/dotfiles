#!/bin/bash
stack_file="/tmp/hide_window_pid_stack.txt"

touch "$stack_file"

function hide_window() {
	pid=$(hyprctl activewindow -j | jq '.pid')
	hyprctl dispatch movetoworkspacesilent special:magic,pid:$pid
	if [[ $pid != "null" ]]; then
		echo $pid >>$stack_file
	fi
}

function show_window() {
	pid=$(tail -1 $stack_file && sed -i '$d' $stack_file)
	[ -z $pid ] && exit

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
