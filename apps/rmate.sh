#!/bin/bash
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

if [[ -f ~/.profile ]] && [[ -z `cat ~/.profile | grep 'RMATE_PORT'` ]]; then
cat >> ~/.profile <<'EOF'

if ([[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]) && [[ -n `command -v rmate` ]]; then
    alias subl=$(command -v rmate)
    export RMATE_PORT=52658
fi
EOF
fi
