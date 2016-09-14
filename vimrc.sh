#!/bin/bash

# exit on error
set -e

curl https://raw.githubusercontent.com/randy3k/dotfiles/master/.vimrc -o ~/.vimrc

mkdir -p ~/.vim/bundle

cd ~/.vim/bundle

git clone https://github.com/VundleVim/Vundle.vim
