#!/usr/bin/env bash

# bash_profile
if [[ ! -f ~/.bash_profile ]]; then
    touch ~/.bash_profile
fi

if [[ -z $(cat ~/.bash_profile | grep 'source ~/.profile') ]]; then
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

if [[ -z $(cat ~/.bashrc | grep '~/.bashrc.d/init.bashrc') ]]; then
cat >> ~/.bashrc <<'EOF'
[[ -f ~/.bashrc.d/init.bashrc ]] && . ~/.bashrc.d/init.bashrc

EOF
fi

# .profile
if [[ ! -f ~/.profile ]]; then
    touch ~/.profile
fi

if [[ -z $(cat ~/.profile | grep '$HOME/.local/bin') ]]; then
cat >> ~/.profile <<'EOF'
if [[ -d "$HOME/.local/bin" ]] && [[ -z $(echo "$PATH" | grep "$HOME/.local/bin") ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

EOF
fi
