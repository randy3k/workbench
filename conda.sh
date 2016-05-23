#!/bin/bash

# exit on error
set -e

DIR=$(mktemp -d)

curl https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o "$DIR/miniconda.sh"

chmod +x "$DIR/miniconda.sh"

"$DIR/miniconda.sh" -b

if [[ -f ~/.profile ]] && [[ -z `cat ~/.profile | grep '$HOME/miniconda3/bin'` ]]; then
cat >> ~/.profile <<'EOF'

# miniconda
if [ -d "$HOME/miniconda3/bin" ] && [ -z `echo "$PATH" | grep "$HOME/miniconda3/bin"` ]; then
    export PATH="$HOME/miniconda3/bin:$PATH"
fi
EOF
fi

rm -r "$DIR"
