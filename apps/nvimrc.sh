#!/bin/bash

# exit on error
set -e

curl https://raw.githubusercontent.com/randy3k/dotfiles/master/.nvimrc -o ~/.nvimrc

mkdir -p ~/.config/nvim/
[ -f '~/.config/nvim/init.vim' ] && rm ~/.config/nvim/init.vim
ln -sf ~/.nvimrc ~/.config/nvim/init.vim

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
