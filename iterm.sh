#!/bin/bash

# exit on error
set -e

curl -L https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | bash

if [[ `basename $SHELL` = "bash" ]] && \
    [[ -f ~/.bashrc ]] && \
    [[ -z `cat ~/.bashrc | grep '~/.iterm2_shell_integration.bash'` ]]; then
cat >> ~/.bashrc <<'EOF'

if [[ -f ~/.iterm2_shell_integration.bash ]]; then
    function iterm2_print_user_vars {
        printf "\033]1337;CurrentDir=''\007"
    }

   source ~/.iterm2_shell_integration.bash
fi
EOF
fi
