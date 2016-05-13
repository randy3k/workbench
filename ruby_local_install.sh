#!/bin/bash

# exit on error
set -e

git clone https://github.com/rbenv/ruby-build.git ~/.ruby-build

cd ~/.ruby-build
env PREFIX="$HOME/.local" ./install.sh
cd -
~/.local/bin/ruby-build 2.3.1 ~/.local/ruby-2.3.1
