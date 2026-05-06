# All configurations are made by me Xgameisdabest
# Get ready because this code is gonna be messy

# Colors
green='\033[1;32m'
red='\033[1;31m'
cyan='\033[0;36m'
yellow='\e[0;33m'
reset='\033[0m'

# Check for config file if it exists
if [[ -f "$HOME/.config/dtf-config/config" ]]; then
	source "$HOME/.config/dtf-config/config"
fi

#ENVIRONMENT VARIABLES
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.spicetify:$PATH
export PATH=$HOME/bin:$PATH
export PATH=/home/linuxbrew/.linuxbrew/bin:$PATH
export EDITOR=nvim
export MANPAGER='nvim +Man!'
export ZSH="$HOME/.oh-my-zsh"
export LANG=en_US.UTF-8
export MANPATH="/usr/local/man:$MANPATH"

# Source the user configured variable use_tmux from the ~/.config/dtf-config/config file
: ${use_tmux:=false}
# Check the condition then played the tmux execution procedure
if [[ $use_tmux == "true" ]]; then
	if command -v tmux &>/dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
		exec tmux
	fi
	if [[ $- =~ i ]] && [[ -z "$TMUX" ]] && [[ -n "$SSH_TTY" ]]; then
		tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux
	fi
fi

#ZSH COMPLETION
autoload -Uz compinit
compinit

#PACSTALL COMPLETION
autoload bashcompinit
bashcompinit
if [[ -f "/usr/share/bash-completion/completions/pacstall" ]]; then
	source /usr/share/bash-completion/completions/pacstall
fi

#KEYBINDINGS
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line
bindkey '^ ' autosuggest-accept
bindkey '	' fzf-tab-complete

#PLUGINS
plugins=(
	zsh-autopair
	zsh-autosuggestions
	zsh-syntax-highlighting
	fzf-tab
	command-not-found
	sudo
)

#fzf-tab
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd -1 --icon=always $realpath'
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:*' prefix '·'
# give a preview of commandline arguments when completing `kill`
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
	'[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap
# systemd
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-flags --preview-window=down:50%
# env vars
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
	fzf-preview 'echo ${(P)word}'
# commands
zstyle ':fzf-tab:complete:-command-:*' fzf-preview \
	'(out=$(tldr --color always "$word") 2>/dev/null && echo $out) || (out=$(MANWIDTH=$FZF_PREVIEW_COLUMNS man "$word") 2>/dev/null && echo $out) || (out=$(which "$word") && echo $out) || echo "${(P)word}"'
zstyle ':fzf-tab:complete:-command-:*' fzf-flags --preview-window=right:75%

#Oh-my-zsh settings options
DISABLE_AUTO_UPDATE=true
DISABLE_AUTO_TITLE=false
ENABLE_CORRECTION=false
COMPLETION_WAITING_DOTS=true
HIST_STAMPS="%T %d/%m/%y"
HISTSIZE=9999
source $ZSH/oh-my-zsh.sh

#function for verbose cd command
# Source the user configured variable verbose_coreutils_output from the ~/.config/dtf-config/config file
: ${verbose_coreutils_output:=true}
if [[ $- == *i* ]]; then
	# Set up the verbose output for all supported coreutils command
	if [[ "$verbose_coreutils_output" == "true" ]]; then
		chpwd() {
			# Actual cd verbose function
			echo -e "${red}$OLDPWD${reset} ${yellow}~>${reset} ${green}$PWD${reset}" | sed "s/\/home\/$USER/~/g"
		}
		alias mkdir="mkdir --verbose"
		alias rm="rm --verbose"
		alias rmdir="rmdir --verbose"
		alias mv="mv --verbose"
		alias cp="cp --verbose"
		alias ln="ln --verbose"
		alias chmod="chmod --verbose"
		alias chown="chown --verbose"
		alias chgrp="chgrp --verbose"
		alias chcon="chcon --verbose"
	fi

	#ALIASES

	if command -v lsd >/dev/null 2>&1; then
		alias ls="lsd -t"
		alias lss="command ls"
	fi

	if command -v zoxide >/dev/null 2>&1; then
		eval "$(zoxide init zsh)"
		export _ZO_MAXAGE=120
		alias cd="z"
		alias cdi="zi"
	fi

	alias sudo="sudo -B"
	alias consoleconfig="sudo dpkg-reconfigure console-setup "
	alias i3config="cd ~/.config/i3/"
	alias out="exit"
	alias quit="exit"
	alias zshconfig="nvim ~/.zshrc"
	alias zshreload="source ~/.zshrc"
	alias open=xdg-open
	alias poweroff="sudo poweroff"
	alias cls=clear
	alias du="du -h"
	alias lsl="ls -lt"
	alias lsla="ls -lta"
	alias lst='lsd --tree'
	alias py=python3
	alias nfetch=neofetch
	alias v=nvim
	alias lgit=lazygit
	alias suv="sudo -e"
	alias pwr-stat="powerprofilesctl get"
	alias pwr-max="powerprofilesctl set performance"
	alias pwr-mid="powerprofilesctl set balanced"
	alias pwr-low="powerprofilesctl set power-saver"
	alias rofi="rofi -x11"
fi

### DISPLAY ON STARTUP SECTION
####################################################
#DISTRO NAME AND VERSION
OS_NAME=$(source /etc/os-release && echo "$PRETTY_NAME")
OS_CODENAME="<Codename: $(source /etc/os-release && echo "$VERSION_CODENAME")>"
echo -e " \033[1;32m\033[0m \e[1;33mDistro:\033[0m $OS_NAME $OS_CODENAME"

#KERNEL VERSION
if [[ -f /proc/version_signature ]]; then
	echo -e " \033[1;32m\033[0m \e[1;33mKernel Version:\033[0m $(cat /proc/version_signature)"
else
	echo -e " \033[1;32m\033[0m \e[1;33mKernel Version:\033[0m $(uname -r)"
fi

#LINUX USE DATE
echo -e " \033[1;32m\033[0m \e[1;33mUsed Linux since \033[1;36m$(date -d "$(stat / | grep Birth | awk '{print $2}')" +%d/%b/%Y)\e[1;33m for \033[1;31m$((($(date +%s) - $(date -d "$(stat / | grep Birth | awk '{print $2}')" +%s)) / 86400))\e[1;33m days\033[0m"

#PACKAGE MANAGERS ALIASES
if [[ -f "$HOME/.easy_package_managers.sh" ]]; then
	source "$HOME/.easy_package_managers.sh"
fi
####################################################

#PROMPT

autoload -Uz vcs_info
precmd() { vcs_info; }
zstyle ':vcs_info:git:*' formats '%b '

#PS1="%B%F{black}╭ %B%F{white}%n%F{red}@%F{white}%m%f%F{red} - %F{black}  %F{red}- %F{white}%B%~%b%f%F{black}%B "$'\n'"╰%F{white}%B%F{red}➜ %b%f"

newline=$'\n'
ZSH_THEME_GIT_PROMPT_PREFIX="${newline} %F{#ff6f91}%B󰊢%f%b %F{#e0e6ed}%B(%f%b %F{#94e2d5}%B"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f%b%F{#e0e6ed}%B )%f%b"
ZSH_THEME_GIT_PROMPT_CLEAN=" %F{#a6e3a1}%B%f%b"
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{#ff6f91}%B%f%b"
ZSH_THEME_GIT_PROMPT_ADDED=" %F{#ff6f91}%B󰆺%f%b"
ZSH_THEME_GIT_PROMPT_AHEAD=" %F{#94e2d5}%B%f%b"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE=" %F{#94e2d5}%B %f%b"
ZSH_THEME_GIT_PROMPT_BEHIND=" %F{#f9e2af}%B%f%b"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE=" %F{#f9e2af}%B %f%b"

PS2='%B%F{#797d8a}     ↪%f%b '

# PROMPT=' $(git_prompt_info)
#  %B%F{yellow} %f %F{white}%~%f
#  ┗┅%B%F{red}%f '

PROMPT='$(git_prompt_info)
  %B%(?:%F{#a6e3a1}%f:%F{#ff6f91}%f) %F{#f9e2af}<%f%F{#89b4fa} %f%F{#94e2d5}%m%f%F{#f9e2af}>%f
  %F{#e0e6ed}%~%f %(?:%F{#a6e3a1}λ%f%b:%F{#ff6f91}λ%f%b)  '

# PROMPT='$(git_prompt_info)
#  %B%F{#e0e6ed}%~%f  %(?:%F{#a6e3a1}λ%f%b:%F{#ff6f91}λ%f%b)  '

# PROMPT='$(git_prompt_info)
#   %B%F{#ff6f91} %f%F{#f7a8b8}%n%f %F{#797d8a}-%f %F{#89b4fa} %f%F{#94e2d5}%m%f%b
#   %B%F{#e0e6ed}%~%f  %(?:%F{#a6e3a1}λ%f%b:%F{#ff6f91}λ%f%b)  '

#PROMPT='  $(git_prompt_info)
#  %B%F{white}%~%f%b  %B%F{red}%f%b  '

RPROMPT='%(?:%B%F{#a6e3a1}|%f%F{#e0e6ed}%f%T%F{#a6e3a1}|%f%b %B%F{#a6e3a1}✔%f%b:%B%F{#ff6f91}|%f%F{#e0e6ed}%f%T%F{#ff6f91}|%f%b %B%F{#ff6f91}✗%f%b)%F{#e0e6ed}%f '
