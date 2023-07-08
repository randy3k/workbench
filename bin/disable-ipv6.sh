#!/usr/bin/env bash

if ! grep -Fxq "net.ipv6.conf.all.disable_ipv6 = 1" /etc/sysctl.conf; then
    cat <<'EOF' | tee -a /etc/sysctl.conf > /dev/null
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1

EOF
fi

sysctl -p
