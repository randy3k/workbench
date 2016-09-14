#!/bin/bash

# exit on error
set -e

curl https://raw.githubusercontent.com/randy3k/dotfiles/master/.nvimrc -o ~/.nvimrc

mkdir -p ~/.config/nvim/bundle

ln -s ~/.nvimrc ~/.config/nvim/init.vim

cd ~/.config/nvim/bundle

git clone https://github.com/VundleVim/Vundle.vim

if [[ -f ~/.bashrc ]] && [[ -z `cat ~/.bashrc | grep 'alias vim'` ]]; then
cat >> ~/.bashrc <<'EOF'

# nvim
alias vim='nvim'
EOF
fi
