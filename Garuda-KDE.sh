#!/bin/bash

# Function to check if a package is installed
function is_installed {
    dpkg -l | grep -q "$1"
}

# Function to install a package if it's not installed
function install_if_missing {
    if ! is_installed "$1"; then
        sudo apt install -y "$1"
    else
        echo "$1 is already installed."
    fi
}

# Update and upgrade the system
sudo apt update && sudo apt upgrade -y

# Install KDE Plasma Desktop Environment if not installed
install_if_missing "kde-plasma-desktop"

# Install Latte Dock if not installed
install_if_missing "latte-dock"

# Install Git if not installed
install_if_missing "git"

# Install Kvantum if not installed
install_if_missing "kvantum"

# Set up Sweet Theme for KDE Plasma
THEME_DIR="$HOME/.local/share/plasma/desktoptheme"
mkdir -p "$THEME_DIR"
cd "$THEME_DIR"
if [ ! -d "Sweet" ]; then
    git clone https://github.com/EliverLara/Sweet.git
else
    echo "Sweet theme is already installed."
fi

# Set up Candy Icons
ICON_DIR="$HOME/.local/share/icons"
mkdir -p "$ICON_DIR"
cd "$ICON_DIR"
if [ ! -d "candy-icons" ]; then
    git clone https://github.com/EliverLara/candy-icons.git
else
    echo "Candy icons are already installed."
fi

# Set up Sweet Kvantum theme
KVANTUM_DIR="$HOME/.config/Kvantum"
mkdir -p "$KVANTUM_DIR"
cd "$KVANTUM_DIR"
if [ ! -d "Sweet-Kvantum" ]; then
    git clone https://github.com/EliverLara/Sweet-Kvantum.git
else
    echo "Sweet Kvantum theme is already installed."
fi

# Apply Sweet Kvantum theme
kvantummanager --set Sweet

# Apply KDE Plasma Sweet theme and Candy icons
kwriteconfig5 --file ~/.config/kdeglobals --group General --key Name "Sweet"
kwriteconfig5 --file ~/.config/kdeglobals --group Icons --key Theme "candy-icons"
kwriteconfig5 --file ~/.config/plasmarc --group Theme --key name "Sweet"

# Set up Latte Dock to start at login
mkdir -p ~/.config/autostart
cp /usr/share/applications/org.kde.latte-dock.desktop ~/.config/autostart/

# Download and set a Garuda wallpaper
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
mkdir -p "$WALLPAPER_DIR"
cd "$WALLPAPER_DIR"
if [ ! -f "garuda-wallpaper.jpg" ]; then
    wget -O garuda-wallpaper.jpg https://raw.githubusercontent.com/garudalinux/garuda-wallpapers/main/garuda-wallpaper.jpg
else
    echo "Garuda wallpaper is already downloaded."
fi

# Apply the downloaded wallpaper
kwriteconfig5 --file ~/.config/plasmashellrc --group Desktops --group 0 --group Wallpaper --group org.kde.image --group General --key Image "file:///$WALLPAPER_DIR/garuda-wallpaper.jpg"

# Refresh KDE Plasma to apply changes
kquitapp5 plasmashell
kstart5 plasmashell

echo "Customization to make KDE look like Garuda is complete!"
