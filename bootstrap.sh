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

# git config
curl https://raw.githubusercontent.com/randy3k/dotfiles/master/.gitconfig -o ~/.gitconfig

# write bootstrap function
mkdir -p ~/.local/bin
cat > ~/.local/bin/bootstrap <<'EOF'
#!/usr/bin/env bash

case "$1" in
    subl)
        curl -s https://raw.githubusercontent.com/randy3k/server-bootstrap/master/subl.sh | bash
    ;;
    ruby)
        curl -s https://raw.githubusercontent.com/randy3k/server-bootstrap/master/ruby_local_install.sh | bash
    ;;
    brew)
        curl -s https://raw.githubusercontent.com/randy3k/server-bootstrap/master/linuxbrew.sh | bash
    ;;
    conda)
        curl -s https://raw.githubusercontent.com/randy3k/server-bootstrap/master/conda.sh | bash
    ;;
    julia)
        curl -s https://raw.githubusercontent.com/randy3k/server-bootstrap/master/julia_local_install.sh | bash
    ;;
    vim)
        curl -s https://raw.githubusercontent.com/randy3k/server-bootstrap/master/vimrc.sh | bash
    ;;
    nvim)
        curl -s https://raw.githubusercontent.com/randy3k/server-bootstrap/master/nvimrc.sh | bash
    ;;
    dropbox)
        curl -s https://raw.githubusercontent.com/randy3k/server-bootstrap/master/dropbox.sh | bash
    ;;
    *)
        curl -s https://raw.githubusercontent.com/randy3k/server-bootstrap/master/bootstrap.sh | bash
    ;;
esac
source ~/.bash_profile
EOF
chmod +x ~/.local/bin/bootstrap

echo "bootstrap done"
