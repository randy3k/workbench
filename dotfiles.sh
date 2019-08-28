#!/bin/bash

set -e
shopt -s expand_aliases

git clone git@github.com:randy3k/dotfiles.git $HOME/.local/dotfiles
alias dotfiles='git --git-dir=$HOME/.local/dotfiles/.git/ --work-tree=$HOME/.local/dotfiles/'
dotfiles config --local status.showUntrackedFiles no
dotfiles config --local alias.save '!git add $(git diff-files --diff-filter=M --name-only) && git commit -m \"Update dotfiles at $(date -u)\" && git push'
dotfiles config --local pull.rebase true

dotfiles reset --hard
