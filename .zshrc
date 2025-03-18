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
export ZSH="$HOME/.oh-my-zsh"
export LANG=en_US.UTF-8
export MANPATH="/usr/local/man:$MANPATH"

autoload bashcompinit
bashcompinit
source /usr/share/bash-completion/completions/pacstall

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
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd -1 --color=always $realpath'
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:complete:cd:*' popup-pad 17 0
DISABLE_AUTO_TITLE="false"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="%T %d/%m/%y"
HISTSIZE=9999
source $ZSH/oh-my-zsh.sh

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

#exit i3
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
alias open=xdg-open
alias poweroff="sudo poweroff"
alias cls=clear
alias rm="rm -v"
alias mdir="mkdir"
alias mv="mv -v"
alias du="du -h"

# listing files, dirs
alias ls=lsd
alias lss=/usr/bin/ls

#jump between dirs

alias programmingdir="cd ~/programming/"
alias cdir="cd ~/programming/c/"
alias luadir="cd ~/programming/lua/"
alias pythondir="cd ~/programming/python/"
alias pydir="cd ~/programming/python/"
alias usrbindir="cd ~/.local/bin/"

#dev, programming
alias py=python3

#package management
alias update="sudo apt update"
alias upgrade="sudo apt upgrade"
alias update-all="sudo apt update && sudo apt upgrade && pacstall -U && pacstall -Up && python -m pip install --upgrade pip"
alias install="sudo apt install"
alias reinstall="sudo apt reinstall"
alias remove="sudo apt remove"
alias autoclean="sudo apt autoclean"
alias autoremove="sudo apt autoremove"

#fetching programs
alias nfetch=neofetch

# clock
alias clock="tty-clock -cC7Ss"

#neovide/nvim/vim
alias v=nvim
alias suv="sudo -e"
alias vconfig="cd ~/.config/nvim/"

#power
alias pwr-max="powerprofilesctl set performance"
alias pwr-mid="powerprofilesctl set balanced"
alias pwr-low="powerprofilesctl set power-saver"

#STUFF

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

# PROMPT=' $(git_prompt_info)
#  %B%F{yellow} %f %F{white}%~%f
#  ┗┅%B%F{red}%f '

PROMPT='  $(git_prompt_info)
  %B%F{white}%~%f%b  %B%F{red}λ%f%b  '

#PROMPT='  $(git_prompt_info)
#  %B%F{white}%~%f%b  %B%F{red}%f%b  '

RPROMPT='%B%F{red}|%f%F{white}%f%T%F{red}|%f%b %(?:%{$fg_bold[green]%}%1{✔%}:%{$fg_bold[red]%}%1{✗%})%{$fg_bold[white]%} '
