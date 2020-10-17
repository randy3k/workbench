#!/usr/bin/env bash

set -e
shopt -s expand_aliases

git init --bare $HOME/.dotfiles

alias dotgit='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dotgit config --local status.showUntrackedFiles no
dotgit config --local core.sparseCheckout true
dotgit config --local pull.rebase true

if [[ -z "$SSH_AUTH_SOCK" ]]; then
    # has ssh agent forwarded
    dotgit remote add -f origin git@github.com:randy3k/dotfiles.git
else
    dotgit remote add -f origin https://github.com/randy3k/dotfiles.git
fi

ln -sf ~/.local/workbench/etc/sparse-checkout ~/.dotfiles/info/sparse-checkout

dotgit checkout master
dotgit branch -u origin/master
