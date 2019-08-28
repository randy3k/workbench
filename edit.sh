#!/bin/bash

set -e

git clone --no-checkout git@github.com:randy3k/unix-bootstrap.git $HOME/.local/bootstrap.tmp
mv $HOME/.local/bootstrap.tmp/.git $HOME/.local/bootstrap/

rm -rf $HOME/.local/bootstrap.tmp
cd $HOME/.local/bootstrap
git reset
