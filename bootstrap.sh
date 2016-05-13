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
if [[ -f ~/.bashrc ]]; then
    cat ~/.bashrc | sed "s|~/.local/etc/bashrc|~/.local/etc/.bashrc|g" > ~/.bashrc
else
    touch ~/.bashrc
fi
if [[ -z `cat ~/.bashrc | grep \~/.local/etc/.bashrc` ]]; then
cat >> ~/.bashrc <<'EOF'
if [ -f ~/.local/etc/.bashrc ]; then
    source ~/.local/etc/.bashrc
fi
EOF
fi

mkdir -p ~/.local/etc
wget https://raw.githubusercontent.com/randy3k/server-bootstrap/master/.bashrc -O ~/.local/etc/.bashrc

# Rprofile
wget https://raw.githubusercontent.com/randy3k/dotfiles/master/.Rprofile -O ~/.Rprofile

# git config
wget https://raw.githubusercontent.com/randy3k/dotfiles/master/.gitconfig -O ~/.gitconfig

# inputrc, for case-insensitive tab completion
if [ ! -a ~/.inputrc ]; then
    echo "\$include /etc/inputrc" > ~/.inputrc
fi
echo "set completion-ignore-case On" >> ~/.inputrc


# local bin
if [[ -f ~/.profile ]] && [[ -z `cat ~/.profile | grep '$HOME/.local/bin'` ]]; then
cat >> ~/.profile <<'EOF'
if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi
EOF
fi
