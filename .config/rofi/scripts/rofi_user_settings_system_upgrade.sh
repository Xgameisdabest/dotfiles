#!/bin/bash

# Define colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}--- Starting Interactive System Upgrade & Cleanup ---${NC}"

# Refresh sudo credentials at the start
sudo -v

# 1. Detect Distribution & Package Manager
if [ -f /etc/arch-release ]; then
	echo -e "${GREEN}Detected Arch Linux.${NC}"
	if command -v yay &>/dev/null; then
		yay -Syu
		echo -e "${BLUE}Reviewing Arch cleanup (yay)...${NC}"
		yay -Yc
	else
		sudo pacman -Syu
		echo -e "${BLUE}Checking for Arch orphans (pacman)...${NC}"
		# We use a subshell check here so it doesn't error out if no orphans exist
		ORPHANS=$(pacman -Qdtq)
		if [ -n "$ORPHANS" ]; then
			sudo pacman -Rs $ORPHANS
		else
			echo "No orphans to remove."
		fi
	fi

elif [ -f /etc/debian_version ] || [ -f /etc/lsb-release ]; then
	echo -e "${GREEN}Detected Debian/Ubuntu-based system.${NC}"
	sudo apt update && sudo apt upgrade
	echo -e "${BLUE}Reviewing APT cleanup...${NC}"
	sudo apt autoremove && sudo apt autoclean

elif [ -f /etc/fedora-release ]; then
	echo -e "${GREEN}Detected Fedora.${NC}"
	sudo dnf upgrade
	echo -e "${BLUE}Reviewing DNF cleanup...${NC}"
	sudo dnf autoremove

else
	echo -e "${RED}Distribution not explicitly supported for system PKG update.${NC}"
fi

# 2. Flatpak Update & Cleanup
if command -v flatpak &>/dev/null; then
	echo -e "${BLUE}Checking Flatpak updates...${NC}"
	flatpak update
	echo -e "${BLUE}Checking for unused Flatpak runtimes...${NC}"
	flatpak uninstall --unused
fi

# 3. Pacstall Update
if command -v pacstall &>/dev/null; then
	echo -e "${BLUE}Updating Pacstall...${NC}"
	# Pacstall's update flags are inherently interactive
	pacstall -U && pacstall -Up
fi

# 4. Python Packages
if command -v pipx &>/dev/null; then
	echo -e "${BLUE}Upgrading pipx packages...${NC}"
	pipx upgrade-all
fi

if command -v pip &>/dev/null; then
	echo -e "${BLUE}Checking for outdated global pip packages...${NC}"

	# Get the list of outdated packages (names only)
	OUTDATED_NAMES=$(pip list --outdated --format=columns | tail -n +3 | awk '{print $1}')

	if [ -n "$OUTDATED_NAMES" ]; then
		echo -e "${GREEN}The following packages have updates available:${NC}"
		pip list --outdated --format=columns

		echo -n "Do you want to upgrade these pip packages? (y/n): "
		read -r confirm
		if [[ "$confirm" =~ ^[yY]$ ]]; then
			# We loop through the names to upgrade them
			echo "$OUTDATED_NAMES" | xargs -n1 pip install -U
		fi
	else
		echo "All pip packages are up to date."
	fi
fi

echo -e "${GREEN}--- All processes complete! ---${NC}"
echo "Press <ENTER> to exit"
read
