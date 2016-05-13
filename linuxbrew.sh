#!/bin/bash

# exit on error
set -e

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"

if [[ -z $(echo $PATH | grep "$HOME/.linuxbrew/bin") ]]; then
    export PATH="$HOME/.linuxbrew/bin:$PATH"
    export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
    export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
fi

if [[ -f ~/.profile ]] && [[ -z `cat ~/.profile | grep '$HOME/.linuxbrew'` ]]; then
cat >> ~/.profile <<'EOF'

# linuxbrew
export PATH="$HOME/.linuxbrew/bin:$PATH"
export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
EOF
fi
