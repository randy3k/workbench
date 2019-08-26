#!/bin/bash

set -e

git clone --no-checkout git@github.com:randy3k/unix-bootstrap.git $HOME/.local/unix-bootstrap.tmp
mv $HOME/.local/unix-bootstrap.tmp/.git $HOME/.local/unix-bootstrap/

rm -rf $HOME/.local/unix-bootstrap.tmp
cd $HOME/.local/unix-bootstrap
git reset
