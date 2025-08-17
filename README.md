## About

___DEVELOP ON UBUNTU 25.04___<BR>
___TESTED ON ARCH LINUX___

__About:__<BR>
The purpose of this project is to share my configs, my ideas as openly as possible. Feel free to open a VM or try it on your own machine!<BR>
<BR>
__If you encounter any issue just open an issue on the github page, thanks!__<BR>
<BR>

> [!NOTE]
> This dotfiles repo is coded and made on the latest version of Ubuntu, so it is expected to have some compatibility issues with older versions of Ubutu and other distros like Debian or something like that so beware. Arch is fine though.
> I suggest that if you use Debian based distros like Linux Mint, Ubuntu, use ([pacstall](https://pacstall.dev/)) to solve the issue.

## Preview
V1 - use ```git checkout 4404458``` (use ```git checkout 08e8942``` if you want bottom bar) to use this version and ```git checkout main``` if you want to use the latest

![alt text](https://github.com/Xgameisdabest/my-i3-config-dotfiles/blob/main/.preview_img/preview.jpg?raw=true)

V2 - use ```git checkout f82e277``` to use this version and ```git checkout main``` if you want to use the latest

![alt text](https://github.com/Xgameisdabest/my-i3-config-dotfiles/blob/main/.preview_img/preview_2.jpg?raw=true)

V3 - (up-to-date)  (Bar now can be on top or bottom, white or black color. Change it via the specified dotfiles config file, more information at the ___Configuration___ section)
![alt text](https://github.com/Xgameisdabest/my-i3-config-dotfiles/blob/main/.preview_img/preview_3.jpg?raw=true)

## Dependencies for this dotfiles
- FONT: Jetbrainsmono Nerd Font Regular and Jetbrainsmono Nerd Font Bold ([link to download fonts](https://www.nerdfonts.com/font-downloads))
- apt nala pacstall flatpak (essential for Debian based, for Arch just use anything that works for you)
- librewolf (it works)
- ncal (essential)
- neovim (essential)
- fzf (essential for zsh plugins)
- oh-my-zsh (essential) ([link to install oh-my-zsh](https://ohmyz.sh/#install))
    - zsh-autopair (essential) ([link to install zsh-autopair](https://github.com/hlissner/zsh-autopair))
    - zsh-autosuggestions (essential) ([link to install zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions))
    - zsh-syntax-highlighting (essential) ([link to install zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting))
    - fzf-tab (essential) ([link to install fzf-tab](https://github.com/Aloxaf/fzf-tab?tab=readme-ov-file))
- alacritty/kitty (essential)
- i3 (essential)
- sway (optional)
- hyprland (optional)
- polybar (essential)
- waybar (optional for hyprland and sway)
- picom 12 (picom-git) (essential) ([link to picom 12](https://github.com/yshui/picom))
- betterlockscreen (essential) ([link to betterlockscreen](https://github.com/betterlockscreen/betterlockscreen))
- tmux neofetch(terminal util)
- waypaper feh (wallpaper) ([link to waypaper](https://github.com/anufrievroman/waypaper))
- dunst (essential)
- rofi (essential)
- superfile nautilus thunar (file manager)
- spotify (music player)
- cava (audio visualizer)
- solaar (logitech util setting)
- blueman (essential for bluetooth connection)
- network-manager (essential for wifi connection)
- arandr (essential)
- pipewire (essential, currently using pipewire)
- pipewire-pulse (essential)
- redshift (essential)

> [!NOTE]
> Afaik, there are still some missing dependencies that are not in the list bc I kinda lost track of during the process of developing. So make sure to check all the config files or see if you encounter ANY bugs, it may related to missing dependencies.

## Installation

> [!NOTE]
> ```Picom``` is a dependency that needs to be installed and build from source in order to work correctly.
> [Install and build Picom from source, FOLLOW THE INSTRUCTIONS THERE](https://github.com/yshui/picom)

> [!NOTE]
> From what I have experienced, the terminal emulator ```kitty``` starts quite slow when installed from apt (from apt is 0.50 seconds, from source is 0.15 seconds), so it is highly recommend to build it from source.
> [Link to build kitty from source](https://sw.kovidgoyal.net/kitty/build/)

My way to install and build kitty from source:
```
mkdir testenv && cd testenv
git clone https://github.com/kovidgoyal/kitty.git && cd kitty
./dev.sh build
ln -s ~/testenv/kitty/kitty/launcher/kitty ~/.local/bin/
```

To maintain kitty, I created a file in kitty repo directory and named it as update_kitty.sh and give it permission to run ```chmod +x update_kitty.sh```
```
#!/bin/bash

git pull
./dev.sh deps
./dev.sh build --debug
sudo rm -rf ~/go/ && echo "Build deps removed!"
```

Install most important dependencies (for ```apt```)
```
sudo apt install zsh i3 polybar rofi ncal neovim alacritty dunst libnotify-bin btop thunar blueman pipewire-pulse pipewire network-manager fzf xdotool udev redshift x11-xserver-utils lsd xorg jq xclip power-profiles-daemon acpi feh bsdmainutils light kitty x11-utils
```

Install oh-my-zsh (command taken from the official [page](https://github.com/ohmyzsh/ohmyzsh))
```
sudo apt install curl
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Install zsh plugins (zsh-autopair zsh-autosuggestions zsh-syntax-highlighting fzf-tab)
```
cd ~/.oh-my-zsh/plugins/
git clone https://github.com/hlissner/zsh-autopair.git
git clone https://github.com/zsh-users/zsh-autosuggestions.git
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
git clone https://github.com/Aloxaf/fzf-tab.git
```

Install the dotfiles
```
cd ~
git clone https://github.com/Xgameisdabest/dotfiles.git
cd dotfiles
stow .
sudo updatedb
i3-msg restart
```

> [!NOTE]
> REMEMBER TO ADD ```TERMINAL=alacritty``` TO ```/etc/environment``` OR IF YOU USE KITTY ```TERMINAL=kitty``` TO ```/etc/environment``` OR ANY TERMINAL APP PATH TO ```/etc/environment```. IT IS HIGHLY RECOMMENDED TO USE KITTY AS THIS DOTFILES IS USING KITTY! SO PUT ```TERMINAL=kitty``` INTO ```/etc/environment```

FOR LAPTOP USERS THAT HAVE A FUNCTIONAL BATTERY, DO THIS!
```
#Run this:
sudo touch /etc/udev/rules.d/60-power.rules

# Add the following to /etc/udev/rules.d/60-power.rules (replace USERNAME with your current username)
ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="0", ENV{DISPLAY}=":0", ENV{XAUTHORITY}="/home/USERNAME/.Xauthority" RUN+="/usr/bin/su USERNAME -c '/home/USERNAME/.config/dunst/scripts/bat_status.sh discharging'"
ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="1", ENV{DISPLAY}=":0", ENV{XAUTHORITY}="/home/USERNAME/.Xauthority" RUN+="/usr/bin/su USERNAME -c '/home/USERNAME/.config/dunst/scripts/bat_status.sh charging'"

#idea from eric murphy, go check him out on youtube
```

## USAGE ([link to the wiki (still under development)](https://github.com/Xgameisdabest/dotfiles/wiki))

THIS IS ***NOT*** YOUR NORMAL TYPICAL ***DESKTOP*** (the desktop interface on W*ndows, macOS, Gnome, KDE, LXQT, XFCE4...) but a ***TILING WINDOW MANAGER*** (i3, hyprland, sway, dwm...).

It is highly recommend to go on the web to search [what is a tiling window manager](https://en.wikipedia.org/wiki/Tiling_window_manager) and its usage so you can know the basics of a ***TILING WINDOW MANAGER***.

Here is the list of keybinds for this dotfiles (all of this can be viewed in the desktop itself):
- Press (win/mod + shift + r) to reload the tiling window manager (i3wm)
> [!NOTE]
> helpful tip: if you are using a laptop and an external monitor, plug the connection cable (HDMI, VGA, DP) to the laptop and use this key combination, it should cast to the external monitor on reload. ***Do it multiple times if the bar is glitching!***

- Press (win/mod + =) to open the keybinds menu
- Press (win/mod + i) to open the settings menu (require some knowledge of bash scripting and specific program config syntax)
- Press (win/mod + r) to open the app menu (alternatively, this can be launched via clicking on the app title on the bar)
- Press (win/mod + s) to open the web search menu
- Press (win/mod + -) to toggle the visibility of the bar
- Press (win/mod + [1 -> 0]) to change the workspace
- Press (win/mod + shift + [1 -> 0] to move/drop the focused window to the selected number workspace)
- Press (win/mod + v) to toggle between tiling mode (the mode that place windows/programs side by side) and floating mode (the mode you can drag windows/programs around by hold left click on the title)
- Press (win/mod + tab) to open the opened windows menu, select and press ENTER to switch to the opened windows
- Press (win/mod + ARROW_KEYS) to change focus between the tiled windows.
- Press (ctrl + win/mod + ARROW_LEFT/ARROW_RIGHT) to send the focused window to the next numerical workspace.

__EASY PACKAGE MANAGER (COMMAND LINE)__ (Only available on v3)<BR>
Supported Distros (and package managers):
- Arch (yay, pacman)
- Fedora (dnf)
- Debian/Ubuntu (apt)

__USAGE__
- ```update```: update the repo
- ```upgrade```: upgrade the packages
- ```install <package name>```: install the package
- ```reinstall <package name>```: reinstall the package
- ```remove <package name>```: uninstall the package
- ```autoclean```: remove old packages
- ```autoremove```: remove unused packages

## CONFIGURATION
> [!NOTE]
> This is a work-in-progress thing and it only appears on v3 and above

Run this command to generate the config dir and the file itself:
```
mkdir ~/.config/dtf-config/
touch ~/.config/dtf-config/config
```
FORMAT CONFIG
```
KEY=VALUE (no space before and after the equal sign)
```
> [!NOTE]
> MAKE SURE TO RELOAD (win/mod + shift + r) TO APPLY THE CHANGES

AVAILABLE CONFIG KEYS (ALL OF THESE BELOW ARE DEFAULT CONFIGS):
```
polybar_color=black #(OPTIONS: white/black)
polybar_compact=false #(OPTIONS: true/false)
polybar_top=false #(OPTIONS: true/false)
picom_enable=true #(OPTIONS: true/false)
autostart_night_mode=false #(OPTIONS: true/false)
auto_sleep=true #(OPTIONS: true/false)
verbose_coreutils_output=false #(OPTIONS: true/false)
autorandr_on_reload=false #(OPTIONS: true/false)
transparent_window_when_unfocus=true #(OPTIONS: true/false)
caps_lock_notification=true #(OPTIONS: true/false)
num_lock_notification=true #(OPTIONS: true/false)
```
