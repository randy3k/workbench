#!/bin/bash

# exit on error
set -e

git clone https://github.com/rbenv/ruby-build.git ~/.ruby-build

cd ~/.ruby-build
env PREFIX="$HOME/.local" ./install.sh
cd -
~/.local/bin/ruby-build 2.3.1 ~/.local/ruby-2.3.1

if [[ -z $(echo $PATH | grep "$HOME/.local/ruby-2.3.1/bin") ]]; then
    export PATH="$HOME/.local/ruby-2.3.1/bin:$PATH"
fi

if [[ -f ~/.profile ]] && [[ -z `cat ~/.profile | grep '$HOME/.local/ruby-2.3.1/bin'` ]]; then
cat >> ~/.profile <<'EOF'

# ruby 2.3.1
if [ -d "$HOME/.local/ruby-2.3.1/bin" ] ; then
    export PATH="$HOME/.local/ruby-2.3.1/bin:$PATH"
fi
EOF
fi
