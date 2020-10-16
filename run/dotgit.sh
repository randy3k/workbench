#!/usr/bin/env bash

set -e
shopt -s expand_aliases

git init --bare $HOME/.dotfiles

alias dotgit='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dotgit config --local status.showUntrackedFiles no
dotgit config --local core.sparseCheckout true
dotgit config --local pull.rebase true

dotgit remote add -f origin git@github.com:randy3k/dotfiles.git

ln -sf ~/.local/workbench/run/sparse-checkout ~/.dotfiles/info/sparse-checkout

dotgit checkout master
dotgit branch -u origin/master
