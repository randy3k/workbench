#!/usr/bin/env bash

# exit on error
set -e

# Warning to prevent lockout
if [ ! -f ~/.ssh/authorized_keys ] || [ ! -s ~/.ssh/authorized_keys ]; then
    echo "Warning: ~/.ssh/authorized_keys is empty or missing. Disabling password login could lock you out."
    read -p "Are you sure you want to continue? [y/N] " -r choice
    if [[ ! "$choice" =~ ^[yY]$ ]]; then
        echo "Aborting."
        exit 1
    fi
fi

set_config() {
    local key=$1
    local value=$2
    local file="/etc/ssh/sshd_config"
    
    if sudo grep -q "^#\?${key}" "$file"; then
        sudo sed -i "s/^#\?${key}.*/${key} ${value}/" "$file"
    else
        echo "${key} ${value}" | sudo tee -a "$file" > /dev/null
    fi
}

echo "Configuring SSH for key-only authentication..."

# Ensure PubkeyAuthentication is enabled
set_config "PubkeyAuthentication" "yes"

# Disable PasswordAuthentication
set_config "PasswordAuthentication" "no"

# Disable ChallengeResponseAuthentication (older name for KbdInteractiveAuthentication)
set_config "ChallengeResponseAuthentication" "no"

# Disable KeyboardInteractiveAuthentication
set_config "KbdInteractiveAuthentication" "no"

# Restart SSH service
if systemctl is-active --quiet ssh; then
    echo "Restarting ssh service..."
    sudo systemctl restart ssh
elif systemctl is-active --quiet sshd; then
    echo "Restarting sshd service..."
    sudo systemctl restart sshd
else
    echo "Error: Could not find active 'ssh' or 'sshd' service to restart."
    exit 1
fi

echo "Success: SSH server configured to only allow key-based authentication."
