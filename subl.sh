#!/bin/bash
mkdir -p .local/bin
wget https://raw.githubusercontent.com/aurora/rmate/master/rmate -O $HOME/.local/bin/rmate
chmod +x $HOME/.local/bin/rmate

if [[ -z $(echo $PATH | grep -o $HOME/.local/) ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

if [[ -f ~/.profile ]] && [[ -z `cat ~/.profile | grep '$HOME/.local/bin'` ]]; then
cat >> ~/.profile <<'EOF'
if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi
EOF
fi


if [[ -f ~/.bashrc ]] && [[ -z `cat ~/.bashrc | grep 'alias subl'` ]]; then
cat >> ~/.bashrc <<'EOF'

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    alias subl='rmate'
fi
EOF
fi

if [[ -f ~/.zshrc ]] && [[ -z `cat ~/.zshrc | grep 'alias subl'` ]]; then
cat >> ~/.zshrc <<'EOF'

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    alias subl='rmate'
fi
EOF
fi
