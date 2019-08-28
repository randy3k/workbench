#!/bin/bash

set -e
shopt -s expand_aliases

git init --bare $HOME/.dotfiles

alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
dotfiles config --local core.sparseCheckout true
dotfiles config --local alias.save '!git add $(git diff-files --diff-filter=M --name-only) && git commit -m \"Update dotfiles at $(date -u)\" && git push'
dotfiles config --local pull.rebase true

dotfiles remote add -f origin git@github.com:randy3k/dotfiles.git

echo .gitconfig > ~/.dotfiles/info/sparse-checkout
dotfiles checkout master
dotfiles branch -u origin/master
