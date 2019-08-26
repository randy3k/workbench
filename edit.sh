#!/bin/bash

set -e

cp -r $HOME/.local/unix-bootstrap $HOME/.local/unix-bootstrap.bk
rm -rf $HOME/.local/unix-bootstrap
git clone git@github.com:randy3k/unix-bootstrap.git $HOME/.local/unix-bootstrap
mv $HOME/.local/unix-bootstrap.bk/* $HOME/.local/unix-bootstrap/
rm -rf $HOME/.local/unix-bootstrap.bk
