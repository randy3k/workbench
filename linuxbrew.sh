#!/bin/bash

# exit on error
set -e

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"

if [[ -f ~/.profile ]] && [[ -z `cat ~/.profile | grep '$HOME/.linuxbrew'` ]]; then
cat >> ~/.profile <<'EOF'

# linuxbrew
export PATH="/home/cslai/.linuxbrew/bin:$PATH"
export MANPATH="/home/cslai/.linuxbrew/share/man:$MANPATH"
export INFOPATH="/home/cslai/.linuxbrew/share/info:$INFOPATH"
EOF
fi
