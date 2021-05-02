#!/usr/bin/env bash

set -e
shopt -s expand_aliases

git init --bare $HOME/.dotfiles

alias dot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dot config --local status.showUntrackedFiles no
dot config --local core.sparseCheckout true
dot config --local pull.rebase true

if [[ -z "$SSH_AUTH_SOCK" ]]; then
    # has ssh agent forwarded
    dot remote add -f origin git@github.com:randy3k/dotfiles.git
else
    dot remote add -f origin https://github.com/randy3k/dotfiles.git
fi

ln -sf ~/.local/workbench/etc/sparse-checkout ~/.dotfiles/info/sparse-checkout

dot checkout master
dot branch -u origin/master
