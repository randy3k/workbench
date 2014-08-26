# bash_profile
if [[ ! -f ~/.bash_profile ]]; then
    touch ~/.bash_profile
fi
if [[ -z `cat ~/.bash_profile | grep \~/.profile` ]]; then
    curl https://raw.githubusercontent.com/randy3k/server-bootstrap/master/bash_profile >> ~/.bash_profile
fi

# bashrc
if [[ ! -f ~/.bashrc ]]; then
    touch ~/.bashrc
fi
if [[ -z `cat ~/.bashrc | grep \~/.local/etc/bashrc` ]]; then
cat >> ~/.bashrc <<'EOF'
if [[ -z "$PS1" ]]; then
    if [ -f ~/.local/etc/bashrc ]; then
        source ~/.local/etc/bashrc
    fi
fi
EOF
fi

mkdir -p ~/.local/etc
curl https://raw.githubusercontent.com/randy3k/server-bootstrap/master/bashrc > ~/.local/etc/bashrc

# Rprofile
curl https://raw.githubusercontent.com/randy3k/server-bootstrap/master/Rprofile > ~/.Rprofile

# subl
curl https://raw.githubusercontent.com/randy3k/server-bootstrap/master/subl.sh | sh
