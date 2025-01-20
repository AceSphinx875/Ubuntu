#!/bin/bash

# Update package list and upgrade all packages
sudo apt update && sudo apt upgrade -y

# Install necessary dependencies
sudo apt install -y git cmake g++ qt5-qmake qt5-default qttools5-dev-tools

# Clone Kvantum repository
git clone https://github.com/tsujan/Kvantum.git

# Navigate to Kvantum directory
cd Kvantum/Kvantum

# Create build directory and navigate to it
mkdir build && cd build

# Run cmake to configure the build
cmake ..

# Compile Kvantum
make

# Install Kvantum
sudo make install

# Clean up by removing the cloned repository
cd ../../..
rm -rf Kvantum

# Verify Kvantum installation
kvantum --version

echo "Kvantum has been installed successfully."
