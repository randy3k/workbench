#!/usr/bin/env bash

mkdir -p $HOME/.local/bin
curl https://raw.githubusercontent.com/aurora/rmate/master/rmate -o $HOME/.local/bin/rmate
chmod +x $HOME/.local/bin/rmate

if [[ -f ~/.profile ]] && [[ -z `cat ~/.profile | grep '$HOME/.local/bin'` ]]; then
cat >> ~/.profile <<'EOF'

if [ -d "$HOME/.local/bin" ] && [ -z `echo "$PATH" | grep "$HOME/.local/bin"` ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi
EOF
fi

if [[ -f ~/.profile ]] && [[ -z `cat ~/.profile | grep 'command -v rmate'` ]]; then
cat >> ~/.profile <<'EOF'

alias subl="$(command -v rmate) -H host.docker.internal"
EOF
fi
