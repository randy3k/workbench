#!/bin/bash

set -e

# install bootstrap files
DIR=`mktemp -d`
curl -L -o "$DIR/bootstrap.zip" https://github.com/randy3k/unix-bootstrap/archive/master.zip

mkdir -p $HOME/.local/
unzip -q -o $DIR/bootstrap.zip -d $HOME/.local/

rm -rf $HOME/.local/bootstrap
mv $HOME/.local/unix-bootstrap-master $HOME/.local/bootstrap

rm -r "$DIR"


# bash_profile
if [[ ! -f ~/.bash_profile ]]; then
    touch ~/.bash_profile
fi

if [[ -z `cat ~/.bash_profile | grep \~/.profile` ]]; then
cat >> ~/.bash_profile <<'EOF'

if [[ -f ~/.profile ]]; then
    source ~/.profile
fi

if [[ -f ~/.bashrc ]]; then
   source ~/.bashrc
fi
EOF
fi


# .profile
if [[ ! -f ~/.profile ]]; then
    touch ~/.profile
fi

if [[ -z `cat ~/.profile | grep '$HOME/.local/bin'` ]]; then
cat >> ~/.profile <<'EOF'

if [ -d "$HOME/.local/bin" ] && [ -z `echo "$PATH" | grep "$HOME/.local/bin"` ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi
EOF
fi
