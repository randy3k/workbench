#!/bin/bash

# exit on error
set -e

cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -

cd /home/cslai/.dropbox-dist/dropbox-lnx*

for f in `find . -name "*.so*"`; do
    echo $f
    patchelf --set-interpreter  ~/.linuxbrew/lib/ld.so "$f"
    patchelf --set-rpath  '$ORIGIN:'$PWD':/home/cslai/.linuxbrew/lib' "$f"
done
