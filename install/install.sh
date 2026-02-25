#!/usr/bin/env bash
set -euo pipefail

PKG_FILE=""
PKG_INSTALL_CMD=""
PKG_UPDATE_CMD=""

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")
DOTFILES_DIR=$SCRIPT_DIR/..

if command -v pacman >/dev/null 2>&1; then
  echo "Detected Arch-based system (pacman)"
  PKG_FILE="$SCRIPT_DIR/packages/packages-arch.txt"
  PKG_INSTALL_CMD="sudo pacman -S --noconfirm --needed"
  PKG_UPDATE_CMD="sudo pacman -Syu --noconfirm"

  if ! command -v yay >/dev/null 2>&1; then
    echo "yay (AUR helper) not found — installing yay..."
    temp_dir=$(mktemp -d)
    git clone https://aur.archlinux.org/yay.git "$temp_dir/yay"
    pushd "$temp_dir/yay" >/dev/null
    makepkg -si --noconfirm
    popd >/dev/null
    rm -rf "$temp_dir"
  fi

elif command -v apt-get >/dev/null 2>&1; then
  echo "Detected Debian/Ubuntu-based system (apt)"
  PKG_FILE="$SCRIPT_DIR/packages/packages-debian.txt"
  PKG_INSTALL_CMD="sudo apt-get install -y"
  PKG_UPDATE_CMD="sudo apt-get update"

elif command -v brew >/dev/null 2>&1; then
  echo "Detected macOS or Linuxbrew (brew)"
  PKG_FILE="$SCRIPT_DIR/packages/packages-macos.txt"
  PKG_INSTALL_CMD="brew install"
  PKG_UPDATE_CMD="brew update"

else
  # Install Homebrew automatically if no other manager found
  echo "No package manager detected — attempting to install Homebrew..."

  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [[ -d /home/linuxbrew/.linuxbrew ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  elif [[ -d /opt/homebrew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    echo "Could not find Homebrew after installation."
  fi

  PKG_FILE="$SCRIPT_DIR/packages/packages-macos.txt"
  PKG_INSTALL_CMD="brew install"
  PKG_UPDATE_CMD="brew update"
fi

# Install packages if package list exists
if [[ -f "$PKG_FILE" ]]; then
  echo "Installing packages from $PKG_FILE..."
  mapfile -t PACKAGES < "$PKG_FILE"

  for pkg in "${PACKAGES[@]}"; do
    echo "Installing: $pkg"

    if ! eval "$PKG_INSTALL_CMD $pkg"; then 
      if command -v pacman >/dev/null 2>&1; then
        echo "$pkg not found in official repos, trying AUR..."
        if ! yay -S --noconfirm --needed "$pkg"; then
          echo "Package $pkg not found in the AUR either!"
        fi
      fi
      echo "Failed to install $pkg — skipping."
    fi
  done

  echo "Updating package repositories..."
  eval "$PKG_UPDATE_CMD"

else
  echo "Package list $PKG_FILE not found — skipping package installation."
fi

# Symlink dotfiles using GNU Stow
if ! command -v stow >/dev/null 2>&1; then
  echo "GNU Stow not found — please install it manually."
  exit 1
fi

echo "Linking dotfiles using stow..."

cd $DOTFILES_DIR
stow --target "$HOME" "stow" --adopt

echo "Creating custom NeoVim Chadwal Theme..."
bash ./install/create_nvim_config.sh
echo "Created successfully!"

echo "Installing SDDM Silent Theme..."
cd ~
git clone -b main --depth=1 https://github.com/uiriansan/SilentSDDM
cd SilentSDDM
sed -i 's|^ConfigFile=.*|ConfigFile="configs/catppuccin-macchiato.conf"|' metadata.desktop
bash ./install.sh
echo "Installed successfully!"
cd ..
rm -rf ./SilentSDDM
sudo systemctl enable sddm.service

echo "Removing unneccesary dependencies..."
if command -v pacman >/dev/null 2>&1; then
  sudo pywalfox install
  mapfile -t orphans < <(pacman -Qtdq 2>/dev/null || true)

  if [ ${#orphans[@]} -eq 0 ]; then
    echo "No orphaned packages to remove."
  else
    printf '%s\n' "${orphans[@]}" | sudo pacman -Rns -
  fi

elif command -v apt-get >/dev/null 2>&1; then
  sudo apt autoremove --purge
elif command -v brew >/dev/null 2>&1; then
  brew autoremove
  brew cleanup
fi

echo "Dotfiles installation complete!"
echo "Upon logging in again, some colors and wallpaper may look inconsistent. A simple selection of a new wallpaper will easily fix the problem."
echo "You may need to restart your system for changes to take effect."

while true; do
    read -p "Do you want to reboot the system? (y/n): " answer
    answer=${answer,,}

    if [[ "$answer" == "y" ]]; then
        echo "Rebooting now..."
        sudo reboot now
        break
    elif [[ "$answer" == "n" ]]; then
        echo "Reboot canceled! Enjoy your new hyprland setup! If you have any issues, feel free to open one up on my repo."
        break
    else
        echo "Invalid input. Please enter 'y' or 'n'."
    fi
done

