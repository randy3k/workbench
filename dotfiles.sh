#!/bin/bash

set -e


[ -d ~/.dotfiles ] || git clone git@github.com:randy3k/dotfiles.git ~/.dotfiles

mkdir -p ~/.local/etc/

symlink () {
    rm "$2" 2>/dev/null || true
    ln -s "$1" "$2"
}

symlink ~/.dotfiles/.Rprofile ~/.Rprofile
symlink ~/.dotfiles/.aliases ~/.local/etc/.aliases
symlink ~/.dotfiles/.bashrc ~/.local/etc/.bashrc
symlink ~/.dotfiles/.gitconfig ~/.gitconfig
symlink ~/.dotfiles/.gitignore ~/.gitignore
symlink ~/.dotfiles/.lintr ~/.lintr
symlink ~/.dotfiles/.screenrc ~/.screenrc
symlink ~/.dotfiles/.tmux.conf ~/.tmux.conf
symlink ~/.dotfiles/.zprofile ~/.zprofile
symlink ~/.dotfiles/.zshrc ~/.zshrc

