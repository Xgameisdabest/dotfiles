## About

___DEVELOP ON UBUNTU 24.10___

my i3 config, up to date as I change my shits

you may see there are some configs and dependencies for hyprland and sway, this is bc im too lazy to make a git repo for those so i decided to put them here. Also, it is highly recommend to use i3wm as it is the most up to date and also the main focus of this repo.

if you have any problems trying to understand my English then heres the **tldr**: 
- **This whole config is mainly for i3wm, not for hyprland and sway.**

> [!NOTE]
> Only work on Debian based distros, might as well change it on your own if you use Arch or Red Hat based OS.

## Preview
V1 (use ```git checkout 4404458``` (use ```git checkout 08e8942``` if you want bottom bar) to use this version and ```git checkout main``` if you want to use the latest)

![alt text](https://github.com/Xgameisdabest/my-i3-config-dotfiles/blob/main/.preview_img/preview.jpg?raw=true)

V2 (up-to-date)

![alt text](https://github.com/Xgameisdabest/my-i3-config-dotfiles/blob/main/.preview_img/preview_2.jpg?raw=true)

## Dependencies for this dotfiles
- FONT: Jetbrainsmono Nerd Font Regular and Jetbrainsmono Nerd Font Bold ([link to download fonts](https://www.nerdfonts.com/font-downloads))
- apt nala pacstall flatpak (essential for Debian based, for Arch just use anything that works for you)
- chrome (i know but it works well for me, you might have to change the ```$mod+c``` keybind command execution in the i3/hyprland/sway config file if you want to use a different browser)
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
- tetris-thefenriswolf gambit (games) ([link to tetris](https://github.com/samtay/tetris)) ([link to gambit](https://github.com/maaslalani/gambit))
- solaar (logitech util setting)
- blueman (essential for bluetooth connection)
- network-manager (essential for wifi connection)
- arandr (essential)
- pipewire (essential, currently using pipewire)
- pipewire-pulse (essential)

> [!NOTE]
> Afaik, there are still some missing dependencies that are not in the list bc I kinda lost track of during the process of developing. So make sure to check all the config files or see if you encounter ANY bugs, it may related to missing dependencies.

## Installation

> [!NOTE]
> picom is a dependency that needs to install and build from source in order to work correctly, it has already been listed in the dependencies list so go check it out

Install most important dependencies
```
sudo apt install zsh i3 polybar rofi ncal neovim alacritty dunst libnotify-bin thunar blueman pipewire-pulse pipewire network-manager fzf xdotool 
```

Install oh-my-zsh (command taken from the official page)
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

REMEMBER TO ADD TERMINAL=/usr/bin/alacritty TO /etc/environment 

have fun ~~suffering~~
