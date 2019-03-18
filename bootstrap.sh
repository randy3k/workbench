#!/bin/bash

# exit on error
set -e

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

# bashrc
mkdir -p ~/.local/etc
curl https://raw.githubusercontent.com/randy3k/server-bootstrap/master/.bashrc -o ~/.local/etc/.bashrc

if [[ -z `cat ~/.bashrc | grep \~/.local/etc/.bashrc` ]]; then
cat >> ~/.bashrc <<'EOF'

if [ -f ~/.local/etc/.bashrc ]; then
    source ~/.local/etc/.bashrc
fi
EOF
fi

if [ "$(hostname)" == "gauss" ]; then
    curl https://raw.githubusercontent.com/randy3k/server-bootstrap/master/gauss.bashrc >> ~/.local/etc/.bashrc
fi

if [ "$(hostname)" == "gromit" ]; then
    curl https://raw.githubusercontent.com/randy3k/server-bootstrap/master/gromit.bashrc >> ~/.local/etc/.bashrc
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

# Rprofile
curl https://raw.githubusercontent.com/randy3k/dotfiles/master/.Rprofile -o ~/.Rprofile

# .tmux.conf
curl https://raw.githubusercontent.com/randy3k/dotfiles/master/.tmux.conf -o ~/.tmux.conf


# git config
curl https://raw.githubusercontent.com/randy3k/dotfiles/master/.gitconfig -o ~/.gitconfig

# write bootstrap function
mkdir -p ~/.local/bin
cat > ~/.local/bin/bootstrap <<'EOF'
#!/usr/bin/env bash

case "$1" in
    install)
        shift
        [ -z "$1" ] && echo "missing argument" && exit 1
        PROG="$1"
        shift
        curl -s https://raw.githubusercontent.com/randy3k/server-bootstrap/master/$PROG.sh | bash /dev/stdin "$@"
    ;;
    list)
        echo "$(curl -s https://api.github.com/repos/randy3k/server-bootstrap/git/trees/master | sed -n -e 's|.*"path": "\(.*\).sh".*$|\1|p')"
    ;;
    sshkey)
        mkdir -p ~/.ssh
        chmod 700 ~/.ssh
        curl -s https://github.com/randy3k.keys >> ~/.ssh/authorized_keys
        chmod 600 ~/.ssh/authorized_keys
    ;;
    reload)
        curl -s https://raw.githubusercontent.com/randy3k/server-bootstrap/master/bootstrap.sh | bash
    ;;
    *)
        echo "Usage: bootstrap
    - reload
    - install 
    - list
    - sshkey"
    ;;
esac
source ~/.bash_profile
EOF
chmod +x ~/.local/bin/bootstrap

echo "bootstrap done"
