#!/usr/bin/env bash

set -e
shopt -s expand_aliases

if [[ -n "$SSH_AUTH_SOCK" || -f ~/.ssh/id_rsa ]]; then
    # has ssh agent forwarded or has ssh key
    git clone --bare git@github.com:randy3k/dotfiles.git $HOME/.dotfiles
else
    git clone --bare https://github.com/randy3k/dotfiles.git $HOME/.dotfiles
fi

alias dot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dot config --local status.showUntrackedFiles no
dot config --local core.sparseCheckout true
dot config --local core.sparseCheckoutCone false
dot config --local pull.rebase true

ln -sf ~/.local/workbench/etc/sparse-checkout ~/.dotfiles/info/sparse-checkout

dot checkout master
