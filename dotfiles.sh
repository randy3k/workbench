#!/bin/bash

set -e
shopt -s expand_aliases

git init --bare $HOME/.dotfiles

alias dgit='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dgit config --local status.showUntrackedFiles no
dgit config --local core.sparseCheckout true
dgit config --local pull.rebase true

dgit remote add -f origin git@github.com:randy3k/dotfiles.git

echo .gitconfig > ~/.dotfiles/info/sparse-checkout
dgit checkout master
dgit branch -u origin/master
