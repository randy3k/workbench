#!/bin/bash

set -e

if [[ "$1" = "dev" ]]; then
    CHANNEL="dev"
else
    CHANNEL="stable"
fi

curl https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -

echo "deb https://download.sublimetext.com/ apt/$CHANNEL/" | tee /etc/apt/sources.list.d/sublime-text.list

apt-get upgrade
apt-get install sublime-text
