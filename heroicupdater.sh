#!/bin/bash

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
    echo -e "\033[31mThis script must be run as root. Please use sudo or run as root.\033[0m"
    exit 1
fi

# Set the GitHub repository URL
REPO_URL="https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher"

# Get the latest release URL
LATEST_RELEASE_URL=$(curl -s https://api.github.com/repos/Heroic-Games-Launcher/HeroicGamesLauncher/releases/latest | grep "browser_download_url.*amd64.deb" | cut -d '"' -f 4)

if [ -z "$LATEST_RELEASE_URL" ]; then
    echo "Failed to fetch the latest release URL. Exiting."
    exit 1
fi

# Download the latest .deb file
echo "Downloading the latest Heroic Games Launcher .deb file..."
wget "$LATEST_RELEASE_URL"

if [ $? -ne 0 ]; then
    echo "Failed to download the .deb file. Exiting."
    exit 1
fi

# Install the .deb file using apt deb
echo "Installing Heroic Games Launcher..."
apt install ./heroic_*_amd64.deb*

if [ $? -ne 0 ]; then
    echo "Failed to install the .deb file. Exiting."
    exit 1
fi

# Clean up the downloaded .deb file
echo "Cleaning up..."
rm heroic_*_amd64.deb

echo "Heroic Games Launcher has been updated successfully!"
