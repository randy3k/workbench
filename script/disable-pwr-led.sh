#!/usr/bin/env bash

set -e

if ! grep -Fq "pwr_led_trigger=default-on" /boot/firmware/config.txt; then
    cat <<'EOF' | sudo tee -a /boot/firmware/config.txt > /dev/null
dtparam=pwr_led_trigger=default-on
dtparam=pwr_led_activelow=off

EOF
fi

echo 0 | sudo tee /sys/class/leds/PWR/brightness
