#!/usr/bin/env bash

# exit on error
set -e

read -p "Add user '$USER' to the 'wheel' group? [y/N] " -r choice
echo
if [[ "$choice" =~ ^[yY]$ ]]; then
    getent group wheel >/dev/null || sudo groupadd wheel
    sudo usermod -aG wheel "$USER"
    echo "User '$USER' has been added to the 'wheel' group."

    if ! sudo grep -Fq -- "%wheel" /etc/sudoers; then
        sudo sed -i '/^%sudo/a '"%wheel  ALL=(ALL) NOPASSWD: ALL" /etc/sudoers
        echo "Configured sudo to allow 'wheel' group members to run commands without a password."
    fi
    echo "Please log out and back in for group changes to take effect."
fi
