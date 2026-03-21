#!/bin/bash
set -e

# Configure npm to use a custom global prefix
npm config set prefix '~/.npm-global'

# Add the new path to ~/.profile if it's not already there
if ! grep -q 'export PATH=~/.npm-global/bin:$PATH' ~/.profile; then
    echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.profile
    echo "Added ~/.npm-global/bin to ~/.profile"
else
    echo "~/.npm-global/bin is already in ~/.profile"
fi

# Create the directory to ensure it exists
mkdir -p ~/.npm-global/bin

echo "npm global prefix set to ~/.npm-global"
echo "Please restart your shell or run 'source ~/.profile' to update your PATH."
