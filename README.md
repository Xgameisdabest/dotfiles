## About
my i3 config, up to date as I change my shits

you may see there are some configs and dependencies for hyprland and sway, this is bc im too lazy to make a git repo for those so i decided to put them here. Also, it is highly recommend to use i3wm as it is the most up to date and also the main focus of this repo.

if you have any problems trying to understand my English then heres the **tldr**: 
- **This whole config is mainly for i3wm, not for hyprland and sway.**

> [!NOTE]
> Only work on Debian based distros, might as well change it on your own if you use Arch or Red Hat based OS.

## Preview
![alt text](https://github.com/Xgameisdabest/my-i3-config-dotfiles/blob/main/preview.jpg?raw=true)

## Dependencies for this dotfiles
- FONT: Jetbrainsmono Nerd Font Regular
- apt snap nala pacstall flatpak (essential for Debian based, for Arch just use anything that works for you)
- chrome (i know but it works well for me, you might have to change some variables if you want to use a different browser)
- ncal (essential)
- neovim (essential)
- alacritty/kitty (essential)
- i3 (essential)
- sway (optional)
- hyprland (optional)
- polybar waybar (essential)
- picom 12 (picom-git) (essential)
- betterlockscreen (essential)
- tmux neofetch(terminal util)
- waypaper feh (wallpaper)
- dunst (essential)
- rofi (essential)
- superfile nautilus thunar (file manager)
- moc spotify spt spotifyd (music player)
- cava (audio visualizer)
- tetris-thefenriswolf gambit (games)
- solaar (logitech util setting)
- blueman (essential for bluetooth connection)
- xfce4-power-manager (essential for laptops)


> [!NOTE]
> Afaik, there are still some missing dependencies that are not in the list bc I kinda lost track of during the process of developing. So make sure to check all the config files or see if you encounter ANY bugs, it may related to missing dependencies.

## Installation

1st, git clone the whole thing

2nd, cd into that shit

3rd, use GNU stow to create symlink

``````
stow .
``````
if you borrow some of mine:
``````
stow --adopt .
``````
NI*** HAS NO IDEA WHAT IS HE TALKING ABOUT HAHAHAHAHAHAAAHAAAAAAAAAAAHAHAHAHAHAHAHAHAHAHAHAHHAAAAAAHAHAHAHAHAHAHA 💀💀💀💀💀💀💀💀💀
