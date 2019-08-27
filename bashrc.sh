#!/bin/bash

# exit on error
set -e


if [[ -z `cat ~/.bashrc | grep \~/.local/etc/.bashrc` ]]; then
cat >> ~/.bashrc <<'EOF'

if [ -f ~/.local/etc/.bashrc ]; then
    source ~/.local/etc/.bashrc
fi
EOF
fi

# bashrc
mkdir -p ~/.local/etc
curl https://raw.githubusercontent.com/randy3k/dotfiles/master/.bashrc -o ~/.local/etc/.bashrc

# .aliases
curl https://raw.githubusercontent.com/randy3k/dotfiles/master/.aliases >> ~/.local/etc/.bashrc


if [ -n "$BASH_VERSION" ]; then
    source ~/.bash_profile
fi
