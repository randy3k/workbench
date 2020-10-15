#!/bin/bash

# bash_profile
if [[ ! -f ~/.bash_profile ]]; then
    touch ~/.bash_profile
fi

if [[ -z `cat ~/.bash_profile | grep '## begin bootstrap'` ]]; then
cat >> ~/.bash_profile <<'EOF'

## begin bootstrap
## do not edit by hand

if [[ -f ~/.profile ]]; then
    source ~/.profile
fi

if [[ -f ~/.bashrc ]]; then
   source ~/.bashrc
fi

## end bootstrap

EOF
fi


# .profile
if [[ ! -f ~/.profile ]]; then
    touch ~/.profile
fi

if [[ -z `cat ~/.profile | grep '## begin bootstrap'` ]]; then
cat >> ~/.profile <<'EOF'

## begin bootstrap
## do not edit by hand

if [ -d "$HOME/.local/bin" ] && [ -z `echo "$PATH" | grep "$HOME/.local/bin"` ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

## end bootstrap

EOF
fi
