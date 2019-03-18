#! /bin/env bash -l

set -e

curl https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -

echo "deb https://download.sublimetext.com/ apt/dev/" | tee /etc/apt/sources.list.d/sublime-text.list
