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
    rmate)
        curl -s https://raw.githubusercontent.com/randy3k/server-bootstrap/master/rmate.sh | bash
    ;;
    rmate-docker)
        curl -s https://raw.githubusercontent.com/randy3k/server-bootstrap/master/rmate-docker.sh | bash
    ;;
    brew)
        curl -s https://raw.githubusercontent.com/randy3k/server-bootstrap/master/brew.sh | bash
    ;;
    conda)
        curl -s https://raw.githubusercontent.com/randy3k/server-bootstrap/master/conda.sh | bash
    ;;
    julia)
        curl -s https://raw.githubusercontent.com/randy3k/server-bootstrap/master/julia.sh | bash
    ;;
    julia-dev)
        curl -s https://raw.githubusercontent.com/randy3k/server-bootstrap/master/julia.sh | bash /dev/stdin dev
    ;;
    nvimrc)
        curl -s https://raw.githubusercontent.com/randy3k/server-bootstrap/master/nvimrc.sh | bash
    ;;
    dropbox)
        curl -s https://raw.githubusercontent.com/randy3k/server-bootstrap/master/dropbox.sh | bash
    ;;
    sublime_text)
        curl -s https://raw.githubusercontent.com/randy3k/server-bootstrap/master/sublime_text.sh | bash
    ;;
    enpass)
        curl -s https://raw.githubusercontent.com/randy3k/server-bootstrap/master/enpass.sh | bash
    ;;
    r)
        curl -s https://raw.githubusercontent.com/randy3k/server-bootstrap/master/r.sh | bash
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
        echo "Usage: bootstrap [reload|rmate(-docker)|brew|conda|julia|julia-dev|nvimrc|dropbox|sshkey]"
    ;;
esac
source ~/.bash_profile
EOF
chmod +x ~/.local/bin/bootstrap

echo "bootstrap done"
