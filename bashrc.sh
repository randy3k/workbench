#!/bin/bash

# exit on error
set -e

# bashrc
mkdir -p ~/.local/etc
curl https://raw.githubusercontent.com/randy3k/dotfiles/master/.bashrc -o ~/.local/etc/.bashrc

# .aliases
curl https://raw.githubusercontent.com/randy3k/dotfiles/master/.aliases -o ~/.local/etc/.aliases


if [ -n "$BASH_VERSION" ]; then
    source ~/.bash_profile
fi
