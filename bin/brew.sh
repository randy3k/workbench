#!/usr/bin/env bash

# exit on error
set -e

sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"


if [[ -f ~/.profile ]] && [[ -z `cat ~/.profile | grep 'linuxbrew'` ]]; then

cat >> ~/.profile <<EOF

# linuxbrew
EOF

if [[ -d /home/linuxbrew ]]; then
    echo BREWDIR="/home/linuxbrew/.linuxbrew" >> ~/.profile
else
    echo BREWDIR="$HOME/.linuxbrew" >> ~/.profile
fi
cat >> ~/.profile <<'EOF'
if [ -d "$BREWDIR" ] && [ -z `echo "$PATH" | grep "$BREWDIR"` ]; then
    export PATH="$BREWDIR/bin:$PATH"
    export PATH="$BREWDIR/sbin:$PATH"
    export MANPATH="$BREWDIR/share/man:$MANPATH"
    export INFOPATH="$BREWDIR/share/info:$INFOPATH"
fi
EOF
fi
