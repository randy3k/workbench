#!/bin/bash

# exit on error
set -e

sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

if [[ -d /home/linuxbrew ]]; then
    BREWDIR="/home/linuxbrew/.linuxbrew"
else
    BREWDIR="$HOME/.linuxbrew"
fi


if [[ -f ~/.profile ]] && [[ -z `cat ~/.profile | grep '$HOME/.linuxbrew'` ]]; then
cat >> ~/.profile <<'EOF'

# linuxbrew
if [ -d "$BREWDIR" ] && [ -z `echo "$PATH" | grep "$BREWDIR"` ]; then
    export PATH="$BREWDIR/bin:$PATH"
    export PATH="$BREWDIR/sbin:$PATH"
    export MANPATH="$BREWDIR/share/man:$MANPATH"
    export INFOPATH="$BREWDIR/share/info:$INFOPATH"
fi
EOF
fi
