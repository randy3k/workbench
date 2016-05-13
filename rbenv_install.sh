#!/bin/bash

# exit on error
set -e

git clone https://github.com/rbenv/rbenv.git ~/.rbenv
# try to compile dynamic bash extension to speed up rbenv
cd ~/.rbenv && src/configure && make -C src
cd -

if [[ -f ~/.profile ]] && [[ -z `cat ~/.profile | grep '$HOME/.rbenv/bin'` ]]; then
cat >> ~/.profile <<'EOF'

export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
EOF
fi
