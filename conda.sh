#!/bin/bash

# exit on error
set -e

DIR=$(mktemp -d)

wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O "$DIR/miniconda.sh"

bash "$DIR/miniconda.sh"

if [[ -f ~/.profile ]] && [[ -z `cat ~/.profile | grep '$HOME/miniconda3/bin'` ]]; then
cat >> ~/.profile <<'EOF'

# miniconda
export PATH="$HOME/miniconda3/bin:$PATH"
EOF
fi

rm -r "$DIR"
