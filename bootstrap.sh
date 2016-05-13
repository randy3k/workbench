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
curl https://raw.githubusercontent.com/randy3k/server-bootstrap/master/.bashrc > ~/.local/etc/.bashrc

# Rprofile
curl https://raw.githubusercontent.com/randy3k/dotfiles/master/.Rprofile > ~/.Rprofile

# inputrc, for case-insensitive tab completion
if [ ! -a ~/.inputrc ]; then
    echo "\$include /etc/inputrc" > ~/.inputrc
fi
echo "set completion-ignore-case On" >> ~/.inputrc
