#!/usr/bin/env bash

set -e

# bash_profile
if [[ ! -f ~/.bash_profile ]]; then
    touch ~/.bash_profile
fi

if ! grep -Fq 'source ~/.profile' ~/.bash_profile; then
cat >> ~/.bash_profile <<'EOF'

if [[ -f ~/.profile ]]; then
    source ~/.profile
fi

if [[ -f ~/.bashrc ]]; then
   source ~/.bashrc
fi

EOF
fi


# bashrc
if [[ ! -f ~/.bashrc ]]; then
    touch ~/.bashrc
fi

if ! grep -Fq '~/.bashrc.d/init.bashrc' ~/.bashrc; then
cat >> ~/.bashrc <<'EOF'

if [[ -f ~/.bashrc.d/init.bashrc ]]; then
    source ~/.bashrc.d/init.bashrc
fi

EOF
fi

# .profile
if [[ ! -f ~/.profile ]]; then
    touch ~/.profile
fi

if ! grep -Fq '$HOME/.local/bin' ~/.profile; then
cat >> ~/.profile <<'EOF'

if [[ -d "$HOME/.local/bin" ]] && [[ ! "$PATH" =~ "$HOME/.local/bin" ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

EOF
fi
