#!/bin/zsh

# Source dotfiles configuration
source ~/.config/dtf-config/config
: ${use_nala_for_apt:-false}

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
    # Check if user wants nala AND if nala is actually installed
    if [[ "$use_nala_for_apt" == "true" ]]; then
        if command -v nala &> /dev/null; then
            alias update="sudo nala update"
            alias upgrade="sudo nala upgrade"
            alias install="sudo nala install"
            alias reinstall="sudo nala reinstall"
            alias remove="sudo nala remove"
            alias purge="sudo nala purge"
            alias autoclean="sudo nala autoclean"
            alias autoremove="sudo nala autoremove"
            local manager="nala"
        else
            # Warning if nala is requested but missing
            echo -e " ${red}${reset} ${yellow}Warning:${reset} ${green}nala${reset} is not installed. Falling back to ${green}apt${reset}."
            local fallback=true
        fi
    fi

    # Default to apt if nala isn't requested or isn't found
    if [[ "$use_nala_for_apt" != "true" || "$fallback" == "true" ]]; then
        alias update="sudo apt update"
        alias upgrade="sudo apt upgrade"
        alias install="sudo apt install"
        alias reinstall="sudo apt reinstall"
        alias remove="sudo apt remove"
        alias purge="sudo apt purge"
        alias autoclean="sudo apt autoclean"
        alias autoremove="sudo apt autoremove"
        local manager="apt"
    fi

    echo -e " ${green}${reset} ${yellow}Easy Package Manager:${reset} ${green}${manager}${reset} for $distro (${distro_like})"
}

# Define aliases for DNF (Fedora-based)
set_dnf_aliases() {
    alias update="sudo dnf check-update"
    alias upgrade="sudo dnf upgrade"
    alias install="sudo dnf install"
    alias reinstall="sudo dnf reinstall"
    alias remove="sudo dnf remove"
    # DNF doesn't have a distinct purge; 'remove' usually handles cleanup
    alias purge="sudo dnf remove" 
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
        alias purge="yay -Rns"
        alias autoclean="yay -Sc"
        alias autoremove="yay -Rns \$(pacman -Qdtq)"
    echo -e " ${green}${reset} ${yellow}Easy Package Manager:${reset} ${green}yay${reset} for $distro (${distro_like})"
    elif command -v pacman &>/dev/null; then
        alias update="sudo pacman -Sy"
        alias upgrade="sudo pacman -Su"
        alias install="sudo pacman -S"
        alias reinstall="sudo pacman -S --needed"
        alias remove="sudo pacman -R"
        alias purge="sudo pacman -Rns"
        alias autoclean="sudo pacman -Sc"
        alias autoremove="sudo pacman -Rns \$(pacman -Qdtq)"
    echo -e " ${green}${reset} ${yellow}Easy Package Manager:${reset} ${green}pacman${reset} for $distro (${distro_like})"
    fi
}

# Determine alias setup
if [[ "$distro" == "debian" || "$distro_like" == *"debian"* || "$distro" == "ubuntu" ]]; then
    set_apt_aliases
elif [[ "$distro" == "fedora" || "$distro_like" == *"fedora"* ]]; then
    set_dnf_aliases
elif [[ "$distro" == "arch" || "$distro_like" == *"arch"* ]]; then
    set_arch_aliases
else
    echo " ${red} Easy Package Manager: ERROR - Unsupported distribution:${reset} $distro"
fi
