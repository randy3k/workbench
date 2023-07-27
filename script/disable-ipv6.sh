#!/usr/bin/env bash

set -e

if ! grep -Fxq "net.ipv6.conf.all.disable_ipv6 = 1" /etc/sysctl.conf; then
    cat <<'EOF' | sudo tee -a /etc/sysctl.conf > /dev/null
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1

EOF
fi

sudo sysctl -p > /dev/null
