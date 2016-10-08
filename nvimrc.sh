#!/bin/bash

# exit on error
set -e

curl https://raw.githubusercontent.com/randy3k/dotfiles/master/.nvimrc -o ~/.nvimrc

mkdir -p ~/.config/nvim/bundle

[ -f '~/.config/nvim/init.vim' ] && rm ~/.config/nvim/init.vim
ln -sf ~/.nvimrc ~/.config/nvim/init.vim

cd ~/.config/nvim/bundle

rm -rf ~/.config/nvim/bundle/Vundle.vim

git clone https://github.com/VundleVim/Vundle.vim
