#!/bin/bash

# exit on error
set -e

cd ~ && curl -L "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -

curl -L "https://www.dropbox.com/download?dl=packages/dropbox.py" -o ~/.local/bin/dropbox
chmod +x ~/.local/bin/dropbox

sed -i -e '2s/^/export DISPLAY=\n/' ~/.dropbox-dist/dropboxd

if [ "$(hostname)" == "marconi" ]; then
    sed -i -e '1s|^#!/usr/bin/python|#!/usr/bin/env python2|' ~/.local/bin/dropbox

    cd /home/cslai/.dropbox-dist/dropbox-lnx*

    patchelf --set-interpreter  $HOME/.linuxbrew/lib/ld.so dropbox

    for f in `find . -name "*.so*"`; do
        patchelf --set-rpath '$ORIGIN':$PWD:/home/cslai/.linuxbrew/lib "$f"
    done
fi
