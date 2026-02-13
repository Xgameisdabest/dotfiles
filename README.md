## About

___DEVELOP ON UBUNTU 25.10___<BR>
___TESTED ON ARCH LINUX AND LINUX MINT___

__Project Size__

- dotfiles repo: 35 ~> 36 Megabytes<BR>
- TOTAL (dotfiles, dependencies, build from source apps): ~1.4 Gigabytes<BR>

__About:__<BR>
Been brewing since late __March 2024__ <BR>
Repo officially started in __1st June 2024__ <BR>
The purpose of this project is to share my configs, my ideas as openly as possible. Feel free to open a VM or try it on your own machine!<BR>
<BR>
__If you encounter any issue just open an issue on the ShitHub page, thanks!__<BR>
<BR>

> [!NOTE]
> This dotfiles repo is coded and made on the latest version of Ubuntu, so it is expected to have some compatibility issues with older versions of Ubutu and other distros like Debian or something like that so beware. Arch is fine though.
> I suggest that if you use Debian based distros like Linux Mint, Ubuntu, use ([pacstall](https://pacstall.dev/)) to solve the issue.

## Preview

V1 - use `git checkout 4404458` (use `git checkout 08e8942` if you want bottom bar) to use this version and `git checkout main` if you want to use the latest

![alt text](https://github.com/Xgameisdabest/my-i3-config-dotfiles/blob/main/.preview_img/preview.jpg?raw=true)

V2 - use `git checkout f82e277` to use this version and `git checkout main` if you want to use the latest

![alt text](https://github.com/Xgameisdabest/my-i3-config-dotfiles/blob/main/.preview_img/preview_2.jpg?raw=true)

V3 - use `git checkout ef3b956` to use this version and `git checkout main` if you want to use the latest (I do not recommend use this version as i3 is unstable, use this one if you consider Hyprland) (Bar now can be on top or bottom, white or black color. Change it via the specified dotfiles config file, more information at the ___Configuration___ section)
![alt text](https://github.com/Xgameisdabest/my-i3-config-dotfiles/blob/main/.preview_img/preview_3.jpg?raw=true)

Hyprland is now supported!
![alt text](https://github.com/Xgameisdabest/my-i3-config-dotfiles/blob/main/.preview_img/preview_3_hypr.jpg?raw=true)

V4 - (up-to-date)
![alt text](https://github.com/Xgameisdabest/my-i3-config-dotfiles/blob/main/.preview_img/preview_4.jpg?raw=true)

Material expressive inspired bar style (For Hyprland V4)
![alt text](https://github.com/Xgameisdabest/my-i3-config-dotfiles/blob/main/.preview_img/preview_expressive_hypr.jpg?raw=true)

## Installation

Install the font:

- FONT: Jetbrainsmono Nerd Font Regular and Jetbrainsmono Nerd Font Bold ([link to download fonts](https://www.nerdfonts.com/font-downloads))

> [!NOTE]
> `Picom` is a dependency that needs to be installed and build from source in order to work correctly.
> [Install and build Picom from source, FOLLOW THE INSTRUCTIONS THERE](https://github.com/yshui/picom)

> [!NOTE]
> From what I have experienced, the terminal emulator `kitty` starts quite slow when installed from apt (from apt is 0.50 seconds, from source is 0.15 seconds), so it is highly recommend to build it from source.
> [Link to build kitty from source](https://sw.kovidgoyal.net/kitty/build/)

My way to install and build kitty from source:

```
mkdir testenv && cd testenv
git clone https://github.com/kovidgoyal/kitty.git && cd kitty
./dev.sh build
ln -s ~/testenv/kitty/kitty/launcher/kitty ~/.local/bin/kitty
ln -s ~/testenv/kitty/kitty/launcher/kitten ~/.local/bin/kitten
```

To maintain kitty, I created a file in kitty repo directory and named it as update_kitty.sh and give it permission to run `chmod +x update_kitty.sh`

```
#!/bin/bash

git pull
./dev.sh deps
./dev.sh build --debug
sudo rm -rf ~/go/ && echo "Build deps removed!"
```

Install rofimoji, waypaper via pipx

```
sudo apt install pipx
pipx install waypaper
pipx install rofimoji
```

Install dependencies for i3 (for `apt`)

```
sudo apt install zsh i3 polybar rofi ncal neovim alacritty dunst libnotify-bin btop thunar blueman pipewire-pulse pipewire network-manager fzf xdotool udev redshift x11-xserver-utils lsd xorg jq xclip power-profiles-daemon acpi feh bsdmainutils light kitty x11-utils awk touchegg unclutter-xfixes paplay
```

> [!NOTE]
> Afaik, there are still some missing dependencies that are not in the list bc I kinda lost track of during the process of developing. So make sure to check all the config files or see if you encounter ANY bugs, it may related to missing dependencies.

Hyprland is now supported! Here's how I set it up on my system.

```
sudo add-apt-repository ppa:cppiber/hyprland
sudo apt update
sudo apt install zsh hyprland swaybg hyprsunset hypridle hyprlock waybar rofi ncal neovim alacritty dunst libnotify-bin btop thunar blueman pipewire-pulse pipewire network-manager fzf udev lsd jq wl-clipboard power-profiles-daemon acpi swaybg bsdmainutils light kitty iw wlr-randr awk paplay xwayland hyprpolkitagent hyprland-qt-support0 tty-clock
```

Install oh-my-zsh (command taken from the official [page](https://github.com/ohmyzsh/ohmyzsh))

```
sudo apt install curl
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Install zsh plugins (zsh-autopair zsh-autosuggestions zsh-syntax-highlighting fzf-tab)

```
cd ~/.oh-my-zsh/custom/plugins/
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
> REMEMBER TO ADD `TERMINAL=alacritty` TO `/etc/environment` OR IF YOU USE KITTY `TERMINAL=kitty` TO `/etc/environment` OR ANY TERMINAL APP PATH TO `/etc/environment`. IT IS HIGHLY RECOMMENDED TO USE KITTY AS THIS DOTFILES IS USING KITTY! SO PUT `TERMINAL=kitty` INTO `/etc/environment`

## Hyprland Plugins

This dotfiles supports hyprland plugins such as `hyprbars, Hyprspace, hyprgrass, hyprwinwrap`

In order to install and use these plugins, please install the `hyprpm` package first.

```
sudo apt install hyprpm
```

Then log into the Hyprland environment<BR>

Opent the terminal and install these for the best Hyprland experience.

```
hyprpm update
hyprpm add https://github.com/hyprwm/hyprland-plugins
hyprpm add https://github.com/KZDKM/Hyprspace
hyprpm add https://github.com/horriblename/hyprgrass
hyprpm enable hyprgrass
hyprpm enable Hyprspace
hyprpm enable hyprbars
```

Then `win + shift + r` to reload Hyprland if 2 or more bars spawned.

## USAGE ([link to the wiki (still under development)](https://github.com/Xgameisdabest/dotfiles/wiki))

THIS IS ___NOT___ YOUR NORMAL TYPICAL ___DESKTOP___ (the desktop interface on W\*ndows, macOS, Gnome, KDE, LXQT, XFCE4...) but a ___TILING WINDOW MANAGER___ (i3, hyprland, sway, dwm...).

It is highly recommend to go on the web to search [what is a tiling window manager](https://en.wikipedia.org/wiki/Tiling_window_manager) and its usage so you can know the basics of a ___TILING WINDOW MANAGER___.

Here is the list of keybinds for this dotfiles (all of this can be viewed in the desktop itself):

- Press (win/mod + shift + r) to reload the tiling window manager

> [!NOTE]
> helpful tip: if you are using a laptop and an external monitor, plug the connection cable (HDMI, VGA, DP) to the laptop and use this key combination, it should cast to the external monitor on reload. ___Do it multiple times if the bar is glitching!___

- Press (win/mod + =) to open the keybinds menu
- Press (win/mod + i) to open the settings menu (require some knowledge of bash scripting and specific program config syntax)
- Press (win/mod + r) to open the app menu (alternatively, this can be launched via clicking on the app title on the bar)
- Press (win/mod + s) to open the web search menu
- Press (win/mod + -) to toggle the visibility of the bar
- Press (win/mod + [1 -> 0]) to change the workspace
- Press (win/mod + shift + [1 -> 0] to move/drop the focused window to the selected number workspace)
- Press (win/mod + v) to toggle between tiling mode (the mode that place Bindoj/programs side by side) and floating mode (the mode you can drag Bindoj/programs around by hold left click on the title)
- Press (win/mod + tab) to open the opened Bindoj menu, select and press ENTER to switch to the opened Bindoj
- Press (win/mod + ARROW_KEYS) to change focus between the tiled windows.
- Press (ctrl + win/mod + ARROW_LEFT/ARROW_RIGHT) to send the focused window to the next numerical workspace.

__EASY PACKAGE MANAGER (COMMAND LINE)__ (Only available on V3 and above)<BR>
Supported Distros (and package managers):

- Arch (yay, pacman)
- Fedora (dnf)
- Debian/Ubuntu (apt)

__USAGE__

- `update`: update the repo
- `upgrade`: upgrade the packages
- `install <package name>`: install the package
- `reinstall <package name>`: reinstall the package
- `remove <package name>`: uninstall the package
- `autoclean`: remove old packages
- `autoremove`: remove unused packages

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

# Material expressive style inspired for waybar
# REQUIRED BAR SET TO BLACK
bar_expressive_style=true #(OPTIONS: true/false) (Reload required)

# Material expressive style dynamic, non-translucent when hover
# REQUIRED BAR SET TO BLACK, EXPRESSIVE TRUE
bar_dynamic_style=true #(OPTIONS: true/false) (Reload required)

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

# Hyprland plugins load
hyprland_plugins=true #(OPTIONS: true/false) (Relaunch window manager required)

# Change layouts for Hyprland
layout=dwindle #(OPTIONS: dwindle/master/scrolling) (Scrolling required the hyprscrolling plugin from hyprland plugins) (hyprland_plugins=true is required) (Reload required)

# Hyprsunset (Hyprland) or redshift (i3wm) exec on start
autostart_night_mode=false #(OPTIONS: true/false) (One time only)

# Autosleep for Hyprland using Hypridle
auto_sleep=true #(OPTIONS: true/false) (Reload required)

# Special feature for the terminal/TTY, verbose all coreutils such as cd, rm, mv, mkdir, etc...
verbose_coreutils_output=false #(OPTIONS: true/false)

# Launch tmux on startup by default for the terminal/TTY
use_tmux=false #(OPTIONS: true/false)

# Use nala instead of apt (requires nala package, Ubuntu, Debian only)
use_nala_for_apt=true #(OPTIONS: true/false)

# Exclusive i3 feature, launch autorandr on reload
autorandr_on_reload=false #(OPTIONS: true/false) (Reload required)

# Exclusive Hyprland feature, launch monitor.sh on reload and it will automatically layout your monitors. Highly recommend to turn it off if you are using a desktop with a custom screen layout, vice-versa on laptop.
auto_set_monitors=true #(OPTIONS: true/false) (Reload required)

# Set window opacity when unfocused
transparent_window_when_unfocus=true #(OPTIONS: true/false) (Reload required)

# Notifications for caps_lock and num_lock key
caps_lock_notification=true #(OPTIONS: true/false)
num_lock_notification=true #(OPTIONS: true/false)

# Notifications for usb devices and check if the power is plug or not
usb_notification=true #(OPTIONS: true/false) (Relaunch window manager required)

# Battery warning daemon, warn when battery reaches 20%
battery_warning_notification=false #(OPTIONS: true/false) (Relaunch window manager required)

# Set power mode changes brightness for each mode: power-saving, balanced and perfomance
brightness_changes_by_power_mode=false #(OPTIONS: true/false)

# REQUIRE HYPR PLUGINS, hyprwinwrap scripts for fun
cava_background=false #(OPTIONS: true/false) (Relaunch window manager required)

# Screen saver/zen mode, a fun feature
# This changes the style of the screen saver itself
# This will require to install external package/scripts
# Press alt+q to activate
screen_saver_style=rain #(OPTIONS: clock, pipes, cmatrix, neofetch, rain, cbonsai)
```

__FOR HYPRLAND__<BR>

Now support custom configs. <BR>

At first, you might want to create the directory:

```
mkdir ~/.config/hypr/custom/
```

Put your configs such as Hyprland configs and env vars, also executables into this directory: <BR>

```
#FOR EXAMPLE
~/.config/hypr/custom
               ├── system.conf
               ├── user_custom_config.conf
               ├── startup_script.sh
               ├── it_can_be_anything_that_you_want.conf
               └── window.conf
```

Hyprland will automatically scan that directory and override any default settings that this dotfiles come with (__for .conf files__). <BR>
For .sh files, such as startup scripts, you need to create a .conf file such as `startup.conf` or any other name, then put the script you want to exec in the __.conf__ file.<BR>

```
#EXAMPLE
# Custom config goes here.
# Use the custom directory for your own thing
# For example:
# exec = ~/.config/hypr/custom/your_own_thing.sh
#
# Maybe setup some env vars for a specific machine:
# env = RADV_PERFTEST,gpl,aco
#
# or a Hyprland setting you do not want:
# misc {
# force_default_wallpaper = 1
#}
```

__Have fun__
