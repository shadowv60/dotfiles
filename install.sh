#!/usr/bin/env bash

set -euo pipefail

echo "==> Starting dotfiles bootstrap..."

# -----------------------------
# 1. Ensure Arch Linux
# -----------------------------
if ! grep -q "Arch" /etc/os-release; then
    echo "This script is intended for Arch Linux."
    exit 1
fi

# -----------------------------
# 2. Install Required Packages
# -----------------------------
PKGS=(
    base-devel
    git
    stow
    xorg
    xorg-xinit
    libx11
    libxft
    libxinerama
    freetype2
    fontconfig
    noto-fonts
    noto-fonts-emoji
    kitty
    fish
    starship
    picom
    feh
    neovim
    docker
)

echo "==> Installing packages..."

sudo pacman -S --needed --noconfirm "${PKGS[@]}"

# -----------------------------
# 3. Enable Docker
# -----------------------------
sudo systemctl enable docker.service

# -----------------------------
# 4. Stow Dotfiles
# -----------------------------
echo "==> Stowing dotfiles..."

cd "$(dirname "$0")"

for dir in */ ; do
    case "$dir" in
        .git/|.github/)
            continue
            ;;
    esac

    echo "Stowing $dir"
    stow -R "${dir%/}"
done

# -----------------------------
# 5. Build Suckless Tools
# -----------------------------

build_if_exists() {
    if [ -f "$1/Makefile" ]; then
        echo "==> Building $1"
        make -C "$1" clean
        make -C "$1"
        sudo make -C "$1" install
    fi
}

build_if_exists "$HOME/dwm"
build_if_exists "$HOME/dmenu"
build_if_exists "$HOME/dwmblocks"
build_if_exists "$HOME/st"

# -----------------------------
# 6. Done
# -----------------------------

echo "==> Bootstrap complete."

