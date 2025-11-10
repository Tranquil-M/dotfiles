#!/usr/bin/env bash
set -euo pipefail

# ------------------------------------------------------------
# Configuration
# ------------------------------------------------------------
REPO_URL="https://github.com/Tranquil-M/dotfiles"
DOTFILES_DIR="$HOME/.dotfiles"

# ------------------------------------------------------------
# Clone or update dotfiles repo
# ------------------------------------------------------------
if [[ ! -d "$DOTFILES_DIR" ]]; then
  echo "Cloning dotfiles repo..."
  git clone "$REPO_URL" "$DOTFILES_DIR"
else
  echo "Updating existing dotfiles repo..."
  git -C "$DOTFILES_DIR" pull --recurse-submodules
fi

cd "$DOTFILES_DIR"

# ------------------------------------------------------------
# Detect OS / package manager
# ------------------------------------------------------------
PKG_FILE=""
PKG_INSTALL_CMD=""
PKG_UPDATE_CMD=""

if command -v pacman >/dev/null 2>&1; then
  echo "Detected Arch-based system (pacman)"
  PKG_FILE="packages-arch.txt"
  PKG_INSTALL_CMD="sudo pacman -S --noconfirm --needed"
  PKG_UPDATE_CMD="sudo pacman -Syu --noconfirm"

elif command -v apt-get >/dev/null 2>&1; then
  echo "Detected Debian/Ubuntu-based system (apt)"
  PKG_FILE="packages-debian.txt"
  PKG_INSTALL_CMD="sudo apt-get install -y"
  PKG_UPDATE_CMD="sudo apt-get update"

elif command -v brew >/dev/null 2>&1; then
  echo "Detected macOS or Linuxbrew (brew)"
  PKG_FILE="packages-macos.txt"
  PKG_INSTALL_CMD="brew install"
  PKG_UPDATE_CMD="brew update"

else
  # ------------------------------------------------------------
  # Install Homebrew automatically if no other manager found
  # ------------------------------------------------------------
  echo "No package manager detected — attempting to install Homebrew..."

  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Set up brew in PATH
  if [[ -d /home/linuxbrew/.linuxbrew ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  elif [[ -d /opt/homebrew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    echo "Could not find Homebrew after installation."
  fi

  PKG_FILE="packages-macos.txt"
  PKG_INSTALL_CMD="brew install"
  PKG_UPDATE_CMD="brew update"
fi

# ------------------------------------------------------------
# Install packages if package list exists
# ------------------------------------------------------------
if [[ -f "$PKG_FILE" ]]; then
  echo "Installing packages from $PKG_FILE..."
  mapfile -t PACKAGES < "$PKG_FILE"

  echo "Updating package repositories..."
  eval "$PKG_UPDATE_CMD"

  for pkg in "${PACKAGES[@]}"; do
    echo "Installing: $pkg"
    if ! eval "$PKG_INSTALL_CMD $pkg"; then
      echo "Failed to install $pkg — skipping."
    fi
  done
else
  echo "Package list $PKG_FILE not found — skipping package installation."
fi

# ------------------------------------------------------------
# Symlink dotfiles using GNU Stow
# ------------------------------------------------------------
if ! command -v stow >/dev/null 2>&1; then
  echo "GNU Stow not found — please install it manually."
  exit 1
fi

echo "Linking dotfiles using stow..."
for dir in $(find . -mindepth 1 -maxdepth 1 -type d \
              -not -name '.git' \
              -not -name 'install'); do
  echo "→ Stowing $dir"
  stow --target="$HOME" "$dir"
done

echo "Dotfiles installation complete!"
echo "You may need to restart your shell for changes to take effect."

