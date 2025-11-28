#!/bin/bash

# i tried my best here, most of the flags i have not tested but i guess not many people use them so yea
# This is just experimental, use it your own risk.
# Does not affect the system since all it does is just works on the interactive shellL.
# I had to use AI (ChatGPT) to write this code since it just too complicated to me, im dumb asf
# No worries, I tested this
# The touch and mkdir has too many issues so i disabled it in the .zshrc

# color codes
green='\033[1;32m'
red='\033[1;31m'
cyan='\033[0;36m'
yellow='\e[0;33m'
reset='\033[0m'

## Message
# echo -e " ${red} You are using an experimental feature: Coreutils verbose rework!${reset}"
# echo -e " ${red} These only affect the ${green}cd, mkdir, touch${red} commands${reset}"
# echo -e " ${red} Use it at your own risk!${reset}"
# echo ""
# echo -n " > Press ${green}Enter${reset} to continue"
# read
# clear

# cd_verbose history file
ZDIR_HISTORY="$HOME/.cd_verbose_history"
touch "$ZDIR_HISTORY" # ensure it exists

## CD
cd_verbose() {
	# Safely escape HOME for sed
	local HOME_ESCAPED
	HOME_ESCAPED="$(printf '%s\n' "$HOME" | sed 's/[][\/.^$*]/\\&/g')"

	# Helper: format path with ~
	_show_path() { echo "$1" | sed "s|^$HOME_ESCAPED|~|"; }

	# Help
	if [[ "$1" == "--help" || "$1" == "-h" ]]; then
		echo -e "${green}cd_verbose${reset}, a cd wrapper by Xytozine - tested 2025"
		echo -e "${green}Usage:${reset} cd [directory]"
		echo -e "Change directories with verbose feedback."
		echo
		echo -e "${green}Options:${reset}"
		echo -e "  ${yellow}~${reset}       Go to home directory"
		echo -e "  ${yellow}.${reset}       Stay in current directory"
		echo -e "  ${yellow}-i${reset}       Interactive selection from history"
		echo -e "  ${yellow}-h, --help${reset}  Show this help message"
		echo
		echo -e "${green}Examples:${reset}"
		echo -e "  cd               Jump to home directory"
		echo -e "  cd ~/projects    Change to '~/projects'"
		echo -e "  cd .             Stay in current directory"
		echo -e "  cd -i            Interactive selection from history"
		echo -e "  cd proj          Jump to most recent match containing 'proj'"
		return
	fi

	# Clear history
	if [[ "$1" == "--clear-hist" ]]; then
		truncate -s 0 "$ZDIR_HISTORY" # set file size to 0
		echo -e "${yellow}cd_verbose history cleared.${reset}"
		return
	fi

	# Interactive mode (-i)
	if [[ "$1" == "-i" ]]; then
		if command -v fzf >/dev/null 2>&1; then
			local target
			target=$(tac "$ZDIR_HISTORY" | fzf --prompt="Jump to directory: ")
			[[ -z "$target" ]] && return # user canceled
			local prev_dir
			prev_dir="$(pwd)"
			if cd "$target" 2>/dev/null; then
				echo -e "${cyan}Jumped from${reset}: ${red}$(_show_path "$prev_dir")${reset} ${yellow}->${reset} ${green}$(_show_path "$PWD")${reset}"
				# Add to history
				if ! grep -Fxq "$PWD" "$ZDIR_HISTORY"; then echo "$PWD" >>"$ZDIR_HISTORY"; fi
				tail -n 100 "$ZDIR_HISTORY" >"$ZDIR_HISTORY.tmp" && mv "$ZDIR_HISTORY.tmp" "$ZDIR_HISTORY"
			else
				echo -e "${red}Failed to cd into '$target'${reset}"
			fi
		else
			echo -e "${red}fzf not installed!${reset}"
		fi
		return
	fi

	# No argument or ~ → home
	if [[ -z "$1" || "$1" == "~" ]]; then
		if [[ "$(pwd)" == "$HOME" ]]; then
			echo -e "${yellow}Already in the ${green}home${yellow} directory!${reset}"
		else
			local prev_dir
			prev_dir="$(pwd)"
			cd "$HOME" && echo -e "${cyan}Jumped from${reset}: ${red}$(_show_path "$prev_dir")${reset} ${yellow}->${reset} ${green}~${reset}"
			# Add to history
			if ! grep -Fxq "$PWD" "$ZDIR_HISTORY"; then echo "$PWD" >>"$ZDIR_HISTORY"; fi
			tail -n 100 "$ZDIR_HISTORY" >"$ZDIR_HISTORY.tmp" && mv "$ZDIR_HISTORY.tmp" "$ZDIR_HISTORY"
		fi
		return
	fi

	# Current directory `.`
	if [[ "$1" == "." ]]; then
		echo -e "${yellow}Already in the current directory${reset}: ${green}$(_show_path "$(pwd)")${reset}"
		return
	fi

	# Target directory / keyword
	local target="$1"
	local prev_dir
	prev_dir="$(pwd)"

	# If path exists
	if [[ -e "$target" ]]; then
		if [[ ! -d "$target" ]]; then
			echo -e "${red}'$target' exists but is not a directory!${reset}"
			return
		elif [[ ! -x "$target" ]]; then
			echo -e "${red}Permission denied:${reset} Cannot access '$target'"
			echo -e "${yellow}Try: ${green}sudo chmod +x \"$target\"${reset}"
			return
		fi
		# cd success
		if cd "$target" 2>/dev/null; then
			echo -e "${cyan}Jumped from${reset}: ${red}$(_show_path "$prev_dir")${reset} ${yellow}->${reset} ${green}$(_show_path "$PWD")${reset}"
			# Add to history
			if ! grep -Fxq "$PWD" "$ZDIR_HISTORY"; then echo "$PWD" >>"$ZDIR_HISTORY"; fi
			tail -n 100 "$ZDIR_HISTORY" >"$ZDIR_HISTORY.tmp" && mv "$ZDIR_HISTORY.tmp" "$ZDIR_HISTORY"
		else
			echo -e "${red}Unexpected error: could not cd to '$target'${reset}"
		fi
		return
	fi

	# If path does NOT exist → try partial match in history
	local match
	match=$(grep -i "$target" "$ZDIR_HISTORY" | tail -n 1)
	if [[ -n "$match" && -d "$match" ]]; then
		if cd "$match" 2>/dev/null; then
			echo -e "${cyan}Jumped from${reset}: ${red}$(_show_path "$prev_dir")${reset} ${yellow}->${reset} ${green}$(_show_path "$PWD")${reset}"
			# Add to history
			if ! grep -Fxq "$PWD" "$ZDIR_HISTORY"; then echo "$PWD" >>"$ZDIR_HISTORY"; fi
			tail -n 100 "$ZDIR_HISTORY" >"$ZDIR_HISTORY.tmp" && mv "$ZDIR_HISTORY.tmp" "$ZDIR_HISTORY"
		else
			echo -e "${red}Failed to cd into '$match'${reset}"
		fi
		return
	fi

	# No match
	echo -e "${red}Failed to change directory to '$target' — does not exist!${reset}"
	echo -e "${red}Maybe create it with ${green}mkdir -p \"$target\"${reset}"
}

_cd_verbose_completion() {
	local cur opts dirs
	cur="${COMP_WORDS[COMP_CWORD]}" # current word being completed

	# Options for cd_verbose
	opts="--help --clear-hist -i"

	# If current word starts with -, suggest options
	if [[ "$cur" == -* ]]; then
		COMPREPLY=($(compgen -W "$opts" -- "$cur"))
		return
	fi

	# Otherwise, suggest directories in filesystem
	COMPREPLY=($(compgen -d -- "$cur"))

	# Optional: add last 100 history directories for autocomplete
	if [[ -f "$ZDIR_HISTORY" ]]; then
		dirs=$(tail -n 100 "$ZDIR_HISTORY")
		COMPREPLY+=($(compgen -W "$dirs" -- "$cur"))
	fi
}

## MKDIR

mkdir_verbose() {
	local use_p=false
	local dry_run=false
	local mode=""
	local dirs=()

	if [ $# -eq 0 ]; then
		echo -e "${red}Error:${reset} No directory name provided."
		return 1
	fi

	# Parse arguments
	while [[ $# -gt 0 ]]; do
		case "$1" in
		-p)
			use_p=true
			shift
			;;
		-m)
			if [[ ! "$2" =~ ^[0-7]{3,4}$ ]]; then
				echo -e "${red}Error:${reset} Invalid mode after -m. Use numeric (e.g. 755)."
				return 1
			fi
			mode="$2"
			shift 2
			;;
		--dry-run)
			dry_run=true
			shift
			;;
		--help)
			command mkdir --help
			return 0
			;;
		--version)
			command mkdir --version
			return 0
			;;
		--*)
			echo -e "${red}Error:${reset} Unknown option: ${yellow}$1${reset}"
			echo -e "${yellow}Tip:${reset} Use ${green}--help${reset} to view available options."
			return 1
			;;
		-*)
			echo -e "${red}Error:${reset} Unsupported short flag: ${yellow}$1${reset}"
			return 1
			;;
		*)
			dirs+=("$1")
			shift
			;;
		esac
	done

	if [ ${#dirs[@]} -eq 0 ]; then
		echo -e "${red}Error:${reset} No directory name(s) provided."
		return 1
	fi

	for dir in "${dirs[@]}"; do
		# Ensure dir is not empty or malformed before running dirname
		if [ -z "$dir" ]; then
			echo -e "${red}Error:${reset} Invalid empty path."
			continue
		fi

		local parent_dir
		parent_dir=$(dirname "$dir" 2>/dev/null)

		if [ -e "$dir" ]; then
			if [ -d "$dir" ]; then
				echo -e "${yellow}Notice:${reset} Directory already exists: ${green}$dir${reset}"
			else
				echo -e "${red}Error:${reset} A file with the same name exists: ${yellow}$dir${reset}"
			fi
			continue
		fi

		if [ ! -d "$parent_dir" ] && [ "$use_p" = false ]; then
			echo -e "${red}Error:${reset} Parent directory missing: ${yellow}$parent_dir${reset}"
			echo -e "${yellow}Tip:${reset} Use ${green}-p${reset} to create parent directories."
			continue
		fi

		if [ ! -w "$parent_dir" ] && [ "$use_p" = false ]; then
			echo -e "${red}Permission denied:${reset} Cannot write to: ${yellow}$parent_dir${reset}"
			continue
		fi

		# Build mkdir command
		cmd=(mkdir)
		$use_p && cmd+=("-p")
		[ -n "$mode" ] && cmd+=("-m" "$mode")
		cmd+=("$dir")

		if $dry_run; then
			echo -e "${cyan}[dry-run]${reset} Would run: ${green}${cmd[*]}${reset}"
			continue
		fi

		if "${cmd[@]}" 2>err.log; then
			echo -e "${cyan}Created:${reset} ${green}$dir${reset}"
		else
			errmsg=$(<err.log)
			case "$errmsg" in
			*"Permission denied"*)
				echo -e "${red}Permission denied:${reset} Cannot create '$dir'."
				;;
			*"File exists"*)
				echo -e "${red}Already exists:${reset} A file or directory with that name exists."
				;;
			*"No space left on device"*)
				echo -e "${red}Disk full:${reset} No space left to create '$dir'."
				;;
			*"Read-only file system"*)
				echo -e "${red}Read-only FS:${reset} Cannot create directory on this device."
				;;
			*"Input/output error"*)
				echo -e "${red}I/O error:${reset} Disk or device issue while creating '$dir'."
				;;
			*"File name too long"*)
				echo -e "${red}Error:${reset} File name too long."
				;;
			*"Too many links"*)
				echo -e "${red}Error:${reset} Too many directories in parent."
				;;
			*"Too many open files"*)
				echo -e "${red}Error:${reset} System limit reached: too many open files."
				;;
			*"Stale file handle"*)
				echo -e "${red}Error:${reset} Stale NFS mount or device issue."
				;;
			*)
				echo -e "${red}mkdir failed:${reset} $errmsg"
				;;
			esac
		fi

		rm -f err.log
	done
}

## TOUCH

touch_verbose() {
	if [ -z "$1" ]; then
		echo -e "${red}Please specify a file name!${reset}"
		return 1

	elif [ "$1" = "-c" ]; then
		shift
		if [ -z "$1" ]; then
			echo -e "${red}Please specify a file name for the -c option!${reset}"
			return 1
		fi
		if [ ! -e "$1" ]; then
			echo -e "${yellow}Skipped:${reset} File does not exist, and -c prevents creation: ${green}$1${reset}"
			return 0
		fi
		if touch -c "$1" 2>err.log; then
			echo -e "${cyan}Touched (no create if missing). File:${reset} ${green}$1${reset}"
		else
			echo -e "${red}touch failed:${reset} $(<err.log)"
		fi
		rm -f err.log
		return 0

	elif [ "$1" = "-t" ]; then
		timestamp=$2
		shift 2
		if [ -z "$timestamp" ] || [ -z "$1" ]; then
			echo -e "${red}Please provide both a timestamp and a file name for -t!${reset}"
			return 1
		fi
		local file="$1"
		local parent_dir=$(dirname "$file" 2>/dev/null)

		if [ ! -d "$parent_dir" ]; then
			echo -e "${red}Error:${reset} Parent directory does not exist: ${yellow}$parent_dir${reset}"
			return 1
		elif [ ! -w "$parent_dir" ]; then
			echo -e "${red}Permission denied:${reset} Cannot write to: ${yellow}$parent_dir${reset}"
			return 1
		fi

		if touch -t "$timestamp" "$file" 2>err.log; then
			echo -e "${cyan}File touched with timestamp ${green}$timestamp${cyan}. File: ${green}$file${reset}"
		else
			echo -e "${red}touch failed:${reset} $(<err.log)"
		fi
		rm -f err.log
		return 0

	elif [ "$1" = "--help" ]; then
		command touch --help
		return 0

	elif [ "$1" = "--version" ]; then
		command touch --version
		return 0

	elif [[ "$1" == --* ]]; then
		echo -e "${red}Error:${reset} Unknown option '${yellow}$1${reset}'"
		echo -e "${yellow}Tip:${reset} Use ${green}--help${reset} to see valid options."
		return 1

	else
		local file="$1"
		local parent_dir=$(dirname "$file" 2>/dev/null)

		if [ ! -d "$parent_dir" ]; then
			echo -e "${red}Error:${reset} Parent directory does not exist: ${yellow}$parent_dir${reset}"
			return 1
		elif [ ! -w "$parent_dir" ]; then
			echo -e "${red}Permission denied:${reset} Cannot write to: ${yellow}$parent_dir${reset}"
			return 1
		fi

		if touch "$file" 2>err.log; then
			echo -e "${cyan}File created/touched! Name:${reset} ${green}$file${reset}"
		else
			echo -e "${red}touch failed:${reset} $(<err.log)"
		fi
		rm -f err.log
	fi
}
