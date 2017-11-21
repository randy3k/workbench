#!/bin/bash

# exit on error
set -e

sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"


if [[ -f ~/.profile ]] && [[ -z `cat ~/.profile | grep '$HOME/.linuxbrew'` ]]; then
cat >> ~/.profile <<'EOF'

# linuxbrew
if [ -d "$HOME/.linuxbrew" ] && [ -z `echo "$PATH" | grep "$HOME/.linuxbrew"` ]; then
    export PATH="$HOME/.linuxbrew/bin:$PATH"
    export PATH="$HOME/.linuxbrew/sbin:$PATH"
    export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
    export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
fi
EOF
fi
