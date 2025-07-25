#!/usr/bin/env bash

. "./shell/src/is_desktop_environment.sh"
. "./shell/src/is_installed.sh"

# Install Obsidian
# TODO: Fix this. Use flatpak to install Obsidian
install_obsidian() {
    local version="1.8.10"
    local release_url="https://github.com/obsidianmd/obsidian-releases/releases/download/v${version}/obsidian_${version}_amd64.deb"
    wget "$release_url" -O /tmp/obsidian.deb

    sudo dpkg -i /tmp/obsidian.deb
}

if is_desktop_environment; then
    # Check if Obsidian is installed
    if is_installed "obsidian" >/dev/null 2>&1; then
        print "Obsidian already installed" "$_YELLOW"
    else
        install_obsidian
    fi
fi
