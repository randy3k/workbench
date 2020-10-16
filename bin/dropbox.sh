#!/usr/bin/env bash

# exit on error
set -e

rm -r $HOME/.dropbox-dist || true

cd ~ && curl -L "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -

curl -L "https://www.dropbox.com/download?dl=packages/dropbox.py" -o ~/.local/bin/dropbox
chmod +x ~/.local/bin/dropbox

sed -i -e '2s/^/export DISPLAY=\n/' ~/.dropbox-dist/dropboxd

if [ "$(hostname)" == "marconi" ]; then
    sed -i -e '1s|^#!/usr/bin/python|#!/usr/bin/env python2|' ~/.local/bin/dropbox

    cd $HOME/.dropbox-dist/dropbox-lnx*

    patchelf --set-interpreter  $HOME/.linuxbrew/lib/ld.so dropbox

    patchelf --set-rpath '$ORIGIN':$PWD:$HOME/.linuxbrew/lib dropbox

    for f in `find . -name "*.so*"`; do
        patchelf --set-rpath '$ORIGIN':$PWD:$HOME/.linuxbrew/lib "$f"
    done
fi
