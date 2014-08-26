#!/bin/bash
mkdir -p .local/bin
wget --no-check-certificate -O $HOME/.local/bin/rmate https://raw.github.com/aurora/rmate/master/rmate
chmod +x $HOME/.local/bin/rmate

if [[ -z $(echo $PATH | grep -o $HOME/.local/) ]];
then cat >> ~/.profile <<'EOF'

if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi
EOF
fi

if [[ -z `cat ~/.bashrc | grep 'alias subl'` ]]; then
cat >> ~/.bashrc <<'EOF'

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    alias subl='rmate'
fi
EOF
fi