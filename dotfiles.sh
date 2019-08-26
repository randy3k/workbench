#!/bin/bash

set -e


if [ -d ~/.dotfiles ]; then
    cd ~/.dotfiles
    git pull
    cd -
else
    git clone git@github.com:randy3k/dotfiles.git ~/.dotfiles
fi

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

alias dotfiles='git --git-dir=$HOME/.dotfiles/.git/ --work-tree=$HOME/.dotfiles/'
dotfiles config --local status.showUntrackedFiles no
dotfiles config --local alias.save '!git add -u && git commit -m "Update dotfiles at $(date -u)" && git push'
dotfiles config --local pull.rebase true
