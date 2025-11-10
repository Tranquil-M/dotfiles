Welcome to...

# Tranquil's Hyprland Dot Files!

This is a repository of my preferred hyprland setup, which currently can only be used on arch-based distrobutions.

## Installation

1. Install the git cli tool\
Arch Linux:\
`pacman -Sy git`

2. Clone this repository into your home directory\
`git clone https://github.com/Tranquil-M/dotfiles`

3. Run the install script and let it to all the dirty work.\
``~/dotfiles/install/install.sh`

## Please note:

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
* A wallpaper switcher that utilizes Matugen to change the color scheme of other applications. Wallpapers can be added easily by putting png, jpg, jepg, or webp files into\
`~/Pictures/Wallpapers`
* An application launcher, file exporer, ssh window, and window switcher all within Rofi.
* A notification center/viewer utilizing SwayNC
* A custom discord theme, utilizing Equicord. \
Discord must be manually patched by running the command \
`sudo Equilotl`
* NvChad, the best NeoVim distrobution (imo)

## Packages

* [NvChad](https://nvchad.com/)
* [Equicord](https://equicord.org/)
* [SwayNC](https://github.com/ErikReider/SwayNotificationCenter)
* [Rofi](https://github.com/davatorium/rofi)
* [Rofi Theme](https://github.com/newmanls/rofi-themes-collection)
* [Matugen](https://github.com/InioX/matugen)
* [Matugen Templates](https://github.com/InioX/matugen-themes)
* [Satty](https://github.com/Satty-org/Satty)
* [Grim](https://github.com/emersion/grim)
* [Slurp](https://github.com/emersion/slurp)
* [GNU Stow](https://www.gnu.org/software/stow/)

