#!/bin/bash

# exit on error
set -e

cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -

wget "https://www.dropbox.com/download?dl=packages/dropbox.py" -O ~/.local/bin/dropbox
chmod +x ~/.local/bin/dropbox

if [ "$(hostname)" == "marconi" ]; then
    sed -i -e 's|#!/usr/bin/python|#!/home/cslai/.linuxbrew/bin/python|g' ~/.local/bin/dropbox

    cd /home/cslai/.dropbox-dist/dropbox-lnx*

    for f in `find . -name "*.so*"`; do
        echo $f
        patchelf --set-interpreter  ~/.linuxbrew/lib/ld.so "$f" 2> /dev/null
        patchelf --set-rpath  '$ORIGIN:'$PWD':/home/cslai/.linuxbrew/lib' "$f" 2> /dev/null
    done
fi
