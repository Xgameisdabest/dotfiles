#ENVIRONMENT VARIABLES
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$PATH:/home/xytozine/.spicetify
export PATH=$HOME/bin:$PATH
export PATH=/home/linuxbrew/.linuxbrew/bin:$PATH

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

export EDITOR=nvim

export MANPAGER='nvim +Man!'

#Path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

#PLUGINS
plugins=(
zsh-autopair
zsh-autosuggestions 
zsh-syntax-highlighting 
fzf-tab
command-not-found
sudo
)

#GENERAL SETTINGS

# CASE_SENSITIVE="true"

# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

#fzf-tab
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd -1 --color=always $realpath'
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group ',' '.'
#IDE suggest pop-up
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:complete:cd:*' popup-pad 17 0

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="true"

# see 'man strftime' for details.
HIST_STAMPS="%T %d/%m/%y"

HISTSIZE=9999

source $ZSH/oh-my-zsh.sh

# User configuration

export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#   exec tmux
# fi

# if [[ $- =~ i ]] && [[ -z "$TMUX" ]] && [[ -n "$SSH_TTY" ]]; then
#   tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

#ALIASES

#system configuration
alias consoleconfig="sudo dpkg-reconfigure console-setup "

#i3
alias i3config="cd ~/.config/i3/"

#rofi
alias roficonfig="cd ~/.config/rofi/"

#polybar
alias polybarconfig="cd ~/.config/polybar/"

#cava
alias cavawindow="alacritty cava"
alias cavaconfig="nvim ~/.config/cava/config"

#exit terminal
#alias exit="echo && echo '[Process completed - Press <ENTER> to comfirm]' && read && exit"
alias out="exit"
alias quit="exit"

#gnome
#alias logout="gnome-session-quit"
alias logout="i3-msg exit"

# --------------------------------
#system related

# zsh
alias zshconfig="nvim ~/.zshrc"
alias zshreload="source ~/.zshrc"
alias ohmyzsh="cd ~/.oh-my-zsh"

# tmux
alias tmuxconfig="nvim ~/.config/tmux/tmux.conf"

# system related
#alias cat=batcat
alias god=sudo
alias fucking=sudo
alias open=xdg-open
alias poweroff="sudo poweroff"
alias cls=clear
alias rm="rm -v"
alias mdir="mkdir"
alias mv="mv -v"
alias du="du -h"

# listing files, dirs
alias ls=lsd
alias dir="lsd --color never --directory-only"
alias sysls=ls

# --------------------------------

#jump between dirs

alias z=zoxide

alias programmingdir="cd ~/programming/"
alias cdir="cd ~/programming/c/"
alias luadir="cd ~/programming/lua/"
alias pythondir="cd ~/programming/python/"
alias pydir="cd ~/programming/python/"
alias usrbindir="cd ~/.local/bin/"

#dev, programming
alias py=python3

#package management
alias update="sudo nala update"
alias upgrade="sudo nala upgrade"
alias update-all="sudo nala update && sudo nala upgrade && pacstall -U && pacstall -Up && python -m pip install --upgrade pip"
alias install="sudo nala install"
alias reinstall="sudo apt reinstall"
alias remove="sudo nala remove"
alias autoclean="sudo apt autoclean"
alias autoremove="sudo apt autoremove"

#games
alias games="ls /usr/games/"
alias pacman=pacman4console
alias chess=gambit

#fetching programs
alias nfetch=neofetch
alias neofetchconfig="nvim ~/.config/neofetch/config.conf"

# clock
alias clock="tty-clock -cC7Ss"

#spotify
alias spotifythemes="ls ~/.config/spicetify/Themes"
alias spt="spotifyd && spt"

#neovide/nvim/vim
alias nvide=neovide
alias v=nvim
alias suv="sudo -e"
alias vconfig="cd ~/.config/nvim/"

#files
alias df="duf"

#binaries viewing
alias lsbin="ls /usr/bin"
alias usrbin="ls ~/.local/bin"

#web
alias unixporn="open https://reddit.com/r/unixporn/"

#fzf
alias fzf="fzf --height 40% --layout=reverse --border"

#power
alias pwr-max="powerprofilesctl set performance"
alias pwr-mid="powerprofilesctl set balanced"
alias pwr-low="powerprofilesctl set power-saver"

#key binding
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line
bindkey '^ ' autosuggest-accept
bindkey '	' fzf-tab-complete

#STUFF
#
# if type brew &>/dev/null
# then
#   FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
#
#   autoload -Uz compinit
#   compinit
# fi

autoload bashcompinit
bashcompinit
source /usr/share/bash-completion/completions/pacstall

autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '

#PS1="%B%F{black}╭ %B%F{white}%n%F{red}@%F{white}%m%f%F{red} - %F{black}  %F{red}- %F{white}%B%~%b%f%F{black}%B "$'\n'"╰%F{white}%B%F{red}➜ %b%f"

newline=$'\n'
ZSH_THEME_GIT_PROMPT_PREFIX=" ${newline} $fg_bold[red]󰊢 $fg_bold[white]( $fg_bold[cyan]"
ZSH_THEME_GIT_PROMPT_SUFFIX="$fg_bold[white] )"
ZSH_THEME_GIT_PROMPT_CLEAN=" $fg_bold[green]"
ZSH_THEME_GIT_PROMPT_DIRTY=" $fg_bold[red]"
ZSH_THEME_GIT_PROMPT_ADDED=" $fg_bold[red]󰆺"
ZSH_THEME_GIT_PROMPT_AHEAD=" $fg_bold[cyan]"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE=" $fg_bold[cyan] "
ZSH_THEME_GIT_PROMPT_BEHIND=" $fg_bold[yellow]"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE=" $fg_bold[yellow] "

# printf '\e]12;#71adf4\007'
#printf '\033[?25l'
# PROMPT=' $(git_prompt_info)
#  %B%F{yellow} %f %F{white}%~%f
#  ┗┅%B%F{red}%f '

PROMPT='  $(git_prompt_info)
  %B%F{white}%~%f%b  %B%F{red}%f%b  '

RPROMPT='%B%F{red}|%f%F{white}%f%T%F{red}|%f%b %(?:%{$fg_bold[green]%}%1{✔%}:%{$fg_bold[red]%}%1{✗%})%{$fg_bold[white]%} '

#STARTUP
#echo "\n  $(whoami) - 󰟀 $(hostname)"
#echo "Tip of the day:" 
#fortune ubuntu-server-tips
#echo
#ls
