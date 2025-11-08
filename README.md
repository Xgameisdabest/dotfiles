## About

___DEVELOP ON UBUNTU 25.10___<BR>
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

V3 - use ```git checkout ef3b956``` to use this version and ```git checkout main``` if you want to use the latest (I do not recommend use this version as i3 is unstable, use this one if you consider Hyprland) (Bar now can be on top or bottom, white or black color. Change it via the specified dotfiles config file, more information at the ___Configuration___ section)
![alt text](https://github.com/Xgameisdabest/my-i3-config-dotfiles/blob/main/.preview_img/preview_3.jpg?raw=true)

Hyprland is now supported!
![alt text](https://github.com/Xgameisdabest/my-i3-config-dotfiles/blob/main/.preview_img/preview_3_hypr.jpg?raw=true)

V4 - (up-to-date)
![alt text](https://github.com/Xgameisdabest/my-i3-config-dotfiles/blob/main/.preview_img/preview_4.jpg?raw=true)

## Installation

Install the font:
- FONT: Jetbrainsmono Nerd Font Regular and Jetbrainsmono Nerd Font Bold ([link to download fonts](https://www.nerdfonts.com/font-downloads))

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

Install dependencies for i3 (for ```apt```)
```
sudo apt install zsh i3 polybar rofi ncal neovim alacritty dunst libnotify-bin btop thunar blueman pipewire-pulse pipewire network-manager fzf xdotool udev redshift x11-xserver-utils lsd xorg jq xclip power-profiles-daemon acpi feh bsdmainutils light kitty x11-utils awk touchegg unclutter-xfixes paplay
```


> [!NOTE]
> Afaik, there are still some missing dependencies that are not in the list bc I kinda lost track of during the process of developing. So make sure to check all the config files or see if you encounter ANY bugs, it may related to missing dependencies.

Hyprland is now supported! Here's how I set it up on my system.
```
sudo add-apt-repository ppa:cppiber/hyprland
sudo apt update
sudo apt install zsh hyprland swaybg hyprsunset hypridle hyprlock waybar rofi ncal neovim alacritty dunst libnotify-bin btop thunar blueman pipewire-pulse pipewire network-manager fzf udev lsd jq wl-clipboard power-profiles-daemon acpi swaybg bsdmainutils light kitty iw wlr-randr awk paplay
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

__EASY PACKAGE MANAGER (COMMAND LINE)__ (Only available on V3 and above)<BR>
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

Run this command to generate the config dir and the file itself:
```
mkdir ~/.config/dtf-config/
touch ~/.config/dtf-config/config
```
FORMAT CONFIG
```
KEY=VALUE (no space before and after the equal sign)
# This is a comment
```
> [!NOTE]
> MAKE SURE TO RELOAD (win/mod + shift + r) TO APPLY THE CHANGES

AVAILABLE CONFIG KEYS (ALL OF THESE BELOW ARE DEFAULT CONFIGS):
```
# PRESS MOD(WINDOWS KEY) + SHIFT + R TO RELOAD IN ORDER TO APPLY CHANGES

# Welcome toast
welcome_notification=true #(OPTIONS: true/false) (One time only)

# Changes polybar/waybar color to black or white
bar_color=black #(OPTIONS: white/black) (Reload required)

# Exclusive feature to polybar, make the icons show less info, cleaner look
bar_compact=false #(OPTIONS: true/false) (Reload required)

# Move the bar to the top of the screen, better than some operating system *cough* windows *cough*
bar_top=false #(OPTIONS: true/false) (Reload required)

# Exclusive i3 feature, hidebar when open up the fullscreen rofi menu
bar_hidden_when_using_launcher=false #(OPTIONS: true/false) (Reload required)

# Set rofi color to white or black
rofi_theme=black #(OPTIONS: white/black)

# Toggle animations for i3 (picom) and Hyprland
animations=true #(OPTIONS: true/false) (Reload required)

# Toggle blur for i3 (picom) and Hyprland
blur=false #(OPTIONS: true/false) (Reload required)

# Hyprsunset or redshift exec on start
autostart_night_mode=false #(OPTIONS: true/false) (One time only)

# Autosleep for Hyprland using Hypridle
auto_sleep=true #(OPTIONS: true/false) (Reload required)

# Special feature for the terminal/TTY, verbose all coreutils such as cd, rm, mv, mkdir, etc...
verbose_coreutils_output=false #(OPTIONS: true/false)

# Launch tmux on startup by default for the terminal/TTY
use_tmux=false #(OPTIONS: true/false)

# Exclusive i3 feature, launch autorandr on reload
autorandr_on_reload=false #(OPTIONS: true/false) (Reload required)

# Set window opacity when unfocused
transparent_window_when_unfocus=true #(OPTIONS: true/false) (Reload required)

# Notifications for caps_lock and num_lock key
caps_lock_notification=true #(OPTIONS: true/false) 
num_lock_notification=true #(OPTIONS: true/false) 

# Battery warning daemon, warn when battery reaches 20%
battery_warning_notification=false #(OPTIONS: true/false) (Relaunch window manager required)

# Set power mode changes brightness for each mode: power-saving, balanced and perfomance
brightness_changes_by_power_mode=false #(OPTIONS: true/false)

# REQUIRE HYPR PLUGINS, hyprwinwrap scripts for fun
cava_background=true #(OPTIONS: true/false) (Relaunch window manager required)
```
