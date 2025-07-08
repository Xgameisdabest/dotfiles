#!/bin/zsh

# Colors
green='\033[1;32m'
red='\033[1;31m'
cyan='\033[1;36m'
yellow='\e[1;33m'
reset='\033[0m'

# Load OS info
if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    
    if [[ -n "${ID}" ]]; then
    	distro="${ID}"
    else
	distro="Unknown"
    fi

    if [[ -n "${ID_LIKE}" ]]; then
	distro_like="${ID_LIKE}"
    else
	distro_like="${ID}"
    fi

else
    echo -e " ${red} Easy Package Manager: ERROR - Cannot detect Linux distribution!${reset}"
fi

# Define aliases for APT (Debian-based)
set_apt_aliases() {
    alias update="sudo apt update"
    alias upgrade="sudo apt upgrade"
    alias install="sudo apt install"
    alias reinstall="sudo apt reinstall"
    alias remove="sudo apt remove"
    alias autoclean="sudo apt autoclean"
    alias autoremove="sudo apt autoremove"
    echo -e " ${green}${reset} ${yellow}Easy Package Manager:${reset} ${green}apt${reset} for $distro (${distro_like})"
}

# Define aliases for DNF (Fedora-based)
set_dnf_aliases() {
    alias update="sudo dnf check-update"
    alias upgrade="sudo dnf upgrade"
    alias install="sudo dnf install"
    alias reinstall="sudo dnf reinstall"
    alias remove="sudo dnf remove"
    alias autoclean="echo 'dnf does not require autoclean'"
    alias autoremove="sudo dnf autoremove"
    echo -e " ${green}${reset} ${yellow}Easy Package Manager:${reset} ${green}dnf${reset} for $distro (${distro_like})"
}

# Define aliases for yay or pacman (Arch-based)
set_arch_aliases() {
    if command -v yay &>/dev/null; then
        alias update="yay -Sy"
        alias upgrade="yay -Su"
        alias install="yay -S"
        alias reinstall="yay -S --needed"
        alias remove="yay -R"
        alias autoclean="yay -Sc"
        alias autoremove="yay -Rns \$(pacman -Qdtq)"
	echo -e " ${green}${reset} ${yellow}Easy Package Manager:${reset} ${green}yay${reset} for $distro (${distro_like})"
    elif command -v pacman &>/dev/null; then
        alias update="sudo pacman -Sy"
        alias upgrade="sudo pacman -Su"
        alias install="sudo pacman -S"
        alias reinstall="sudo pacman -S --needed"
        alias remove="sudo pacman -R"
        alias autoclean="sudo pacman -Sc"
        alias autoremove="sudo pacman -Rns \$(pacman -Qdtq)"
	echo -e " ${green}${reset} ${yellow}Easy Package Manager:${reset} ${green}pacman${reset} for $distro (${distro_like})"
    fi
}

# Determine alias setup
if [[ "$distro" == "debian" || "$distro_like" == *"debian"* ]]; then
    set_apt_aliases
elif [[ "$distro" == "fedora" || "$distro_like" == *"fedora"* ]]; then
    set_dnf_aliases
elif [[ "$distro" == "arch" || "$distro_like" == *"arch"* ]]; then
    set_arch_aliases
else
    echo " ${red} Easy Package Manager: ERROR - Unsupported distribution:${reset} $distro"
fi
