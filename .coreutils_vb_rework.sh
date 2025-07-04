#!/bin/sh

# i tried my best here, most of the flags i have not tested but i guess not many people use them so yea

# color codes
green='\033[1;32m'
red='\033[1;31m'
cyan='\033[0;36m'
yellow='\e[0;33m'
reset='\033[0m'

cd_verbose() {
    local home_dir="$HOME"
    if [ -z "$1" ] || [ "$1" = ~ ]; then
	if [ "$(pwd)" != "$home_dir" ]; then
        	local prev_dir=$(pwd)
        	cd ~ && echo -e "${cyan}Jumped from${reset}: ${red}$(echo "$prev_dir" | sed "s|^$home_dir|~|")${reset} ${yellow}->${reset} ${green}$(pwd | sed "s|^$home_dir|~|")${reset}"
	else
		echo "${yellow}Already in the ${green}home${yellow} directory!${reset}"
	fi

    elif [ "$1" = "." ]; then
        echo "${yellow}Already in the current directory${reset}: ${green}$(pwd | sed "s|^$home_dir|~|")"${reset}

    else
        local prev_dir=$(pwd)
        if cd "$1" 2>/dev/null; then
            echo -e "${cyan}Jumped from${reset}: ${red}$(echo "$prev_dir" | sed "s|^$home_dir|~|")${reset} ${yellow}->${reset} ${green}$(pwd | sed "s|^$home_dir|~|")${reset}"
        else
            echo -e "${red}Failed to change directory to '$1'!${reset}"
	    echo -e "${red}Maybe create it with ${green}'mkdir $1/'${red}?${reset}"
        fi
    fi
}

mkdir_rework_verbose() {
    if [ -z "$1" ]; then
        echo -e "${red}Please specify a name for the directory you are going to create!${reset}"
    elif [ "$1" = "-p" ]; then
        shift
        if [ -z "$1" ]; then
            echo -e "${red}Please specify a directory name for the -p option!${reset}"
        else
            mkdir -p "$1" && echo -e "${cyan}Directory created with -p option! Name: ${green}$1${reset}"
        fi
    elif [ "$1" = "-m" ]; then
        mode=$2
         if [ -z "$mode" ]; then
            echo -e "${red}Please specify the permission mode after the -m option!${reset}"
            return 1
        fi
        shift 2        
	if [ -z "$1" ]; then
            echo -e "${red}Please specify a directory name for the -m option!${reset}"
        else
            mkdir -m "$mode" "$1" && echo -e "${cyan}Directory created with permission ${green}$mode${cyan}! Name: ${green}$1${reset}"
        fi
    elif [ "$1" = "--help" ]; then
        command mkdir --help
        return 0
    elif [ "$1" = "--version" ]; then
        command mkdir --version
        return 0
    else
        mkdir "$1" && echo -e "${cyan}Directory created! Name: ${green}$1${reset}"
    fi
}

touch_verbose() {
    if [ -z "$1" ]; then
        echo -e "${red}Please specify a file name!${reset}"
    elif [ "$1" = "-c" ]; then
        shift
        if [ -z "$1" ]; then
            echo -e "${red}Please specify a file name for the -c option!${reset}"
        else
            touch -c "$1" && echo -e "${cyan}Touched (no create if missing). File: ${green}$1${reset}"
        fi
    elif [ "$1" = "-t" ]; then
        timestamp=$2
        if [ -z "$timestamp" ]; then
            echo -e "${red}Please specify a timestamp (in [[CC]YY]MMDDhhmm[.ss] format) after -t!${reset}"
            return 1
        fi
        shift 2
        if [ -z "$1" ]; then
            echo -e "${red}Please specify a file name for the -t option!${reset}"
        else
            touch -t "$timestamp" "$1" && echo -e "${cyan}File touched with timestamp ${green}$timestamp${cyan}. File: ${green}$1${reset}"
        fi
    elif [ "$1" = "--help" ]; then
        command touch --help
        return 0
    elif [ "$1" = "--version" ]; then
        command touch --version
        return 0

    else
        touch "$1" && echo -e "${cyan}File created/touched! Name: ${green}$1${reset}"
    fi
}
