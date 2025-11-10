Welcome to...

# Tranquil's Hyprland Dot Files!

This is a repository of my preferred hyprland setup, which currently can only be used on arch-based distrobutions.

## How does it look?

### Window

![Default Color Scheme](https://raw.githubusercontent.com/Tranquil-M/dotfiles/refs/heads/master/Sample/Blue%20Accent%20Window.png)

### Rofi

![Application Selector](https://github.com/Tranquil-M/dotfiles/blob/master/Sample/Blue%20Rofi.png?raw=true)

### Wallpaper Selector

![Wallpaper Selector](https://github.com/Tranquil-M/dotfiles/blob/master/Sample/Blue%20Wallpaper%20Selector.png?raw=true)

### Notification Manager

![SwayNC](https://github.com/Tranquil-M/dotfiles/blob/master/Sample/Blue%20NC.png?raw=true)

### Wlogout

![Wlogout](https://github.com/Tranquil-M/dotfiles/blob/master/Sample/Wlogout.png?raw=true)

### Other Wallpaper Colors

![Snoopy Yellow](https://github.com/Tranquil-M/dotfiles/blob/master/Sample/Snoopy%20Yellow.png?raw=true)

![Cat Pink](https://github.com/Tranquil-M/dotfiles/blob/master/Sample/Cat%20Pink.png?raw=true)

![Cat Club Green](https://github.com/Tranquil-M/dotfiles/blob/master/Sample/Cat%20Club%20Green.png?raw=true)

## Installation

1. Install the git cli tool

```Bash
pacman -Sy git
```

2. Clone this repository into your home directory\
```
git clone https://github.com/Tranquil-M/dotfiles
```

3. Run the install script and let it to all the dirty work.\
```
~/dotfiles/install/install.sh
```

## Please note:

Due to the way GNU Stow works, cloning this repository into a hidden folder will remove Stow access to symlinks. You can make symlinks yourself, but it is significantly more difficult. 

The install script's package install capability is currently only functional for Arch Based distros. The script has functionallity for debian based distros and MacOs, however I have not input the package names for said operating systems. You can, however, just install the packages yourself!

## How does the install script work?

You could always read it yourself, but I digress. Here's how it works:

1. Detects the current operating system and package manager, (includes yay on arch), and if the package manager doesn't currently exist, it installs it onto the system.

2. Looks for a package file in the same directory as the install script, eg. `packages-arch.txt`, then scans the package manager's package repository for said packages. If it finds them, it installs them. In the case of arch linux, it first scans pacman, then the AUR if it can't find it.

3. Uses GNU Stow to create symlinks for each directory saved into the 'dotfiles' repository.

4. Prompts you to restart your system (optional).

## Features

These dotfiles are meant to be basic, and fit everything that I need in my daily drive. However, there are some unique features that I would like to share!

* A screenshot utility, using Grim, Slurp, and Satty. All screenshots are automatically saved into \
`~/Pictures/Screenshots`
* A wallpaper switcher that utilizes Matugen to change the color scheme of other applications. Wallpapers can be added easily by putting .png, .jpg, .jpeg, or .webp files into\
`~/Pictures/Wallpapers`
* An application launcher, file exporer, ssh window, and window switcher all within Rofi.
* A notification center/viewer utilizing SwayNC
* A custom discord theme, utilizing Equicord \
Discord must be manually patched by running the command
```
sudo Equilotl
```
* NvChad, the best NeoVim distrobution (imo)
* Exa, a better list command! (love this sm)
* Zoxide, a better cd command! (LOVE this sm)
* An on screen display for backlight and volume, using Swayosd
* A clean lockscreen using hyprlock
* A minimal logout menu using wlogout

## Bindings

Here's a full list of all the custom bindings i've added, just in case you don't want to scramble around figuring them out.

* Terminal
```
Super + Return
```

* Kill Active Window
```
Super + W
```

* Log Out of Hyprland
```
Super + M
```

* File Manager
```
Super + Shift + F
```

* Toggle Floating Window
```
Super + T
```

* Open Rofi App Launcher
```
Super + Space
```

* Toggle Window Split
```
Super + J
```

* Reload Waybar
```
Super + R
```

* Toggle Notificaion Center
```
Super + N
```

* Open Wlogout
```
Super + Backspace
```

* "Fake" Fullscreen Active Window
```
Super + F
```

* "Real" Fullscreen Active Window
```
Super + Alt + F
```

* Wallpaper Picker
```
Super + E
```

* Screenshot
```
Super + Z
```

* Close Latest Notification
```
Super + Comma
```

* Close All Notifications
```
Super + Shift + Comma
```

* Swap Workspaces
```
Super + 1-9
```

* Move Window to Workspace
```
Super + Shift + 1-9
```

## Packages

* [NvChad](https://nvchad.com/)
* [NvChad Pywal Support](https://github.com/nvchad/pywal)
* [Equicord](https://equicord.org/)
* [SwayNC](https://github.com/ErikReider/SwayNotificationCenter)
* [SwayOSD](https://github.com/ErikReider/SwayOSD)
* [Rofi](https://github.com/davatorium/rofi)
* [Rofi Theme](https://github.com/newmanls/rofi-themes-collection)
* [Matugen](https://github.com/InioX/matugen)
* [Matugen Templates](https://github.com/InioX/matugen-themes)
* [Satty](https://github.com/Satty-org/Satty)
* [Grim](https://github.com/emersion/grim)
* [Slurp](https://github.com/emersion/slurp)
* [GNU Stow](https://www.gnu.org/software/stow/)
* [Zoxide](https://github.com/ajeetdsouza/zoxide)
* [Exa](https://github.com/ogham/exa)
* [hyprlock](https://wiki.hypr.land/Hypr-Ecosystem/hyprlock/)
* [wlogout](https://github.com/ArtsyMacaw/wlogout)

