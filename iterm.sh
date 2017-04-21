#!/bin/bash

# exit on error
set -e

curl -L https://iterm2.com/misc/`basename $SHELL`_startup.in \
    -o ~/.local/etc/.iterm2_shell_integration.`basename $SHELL`

UTILITIES=(imgcat imgls it2attention it2check it2copy it2dl it2getvar it2setcolor it2setkeylabel it2ul it2universion)
for U in "${UTILITIES[@]}"; do
  echo "Downloading $U..."
  curl -SsL "https://iterm2.com/utilities/$U" > ~/.local/bin/$U
  chmod +x ~/.local/bin/$U
done

if [[ `basename $SHELL` = "bash" ]] && \
    [[ -f ~/.bashrc ]] && \
    [[ -z `cat ~/.bashrc | grep '~/.local/etc/.iterm2_shell_integration.bash'` ]]; then
cat >> ~/.bashrc <<'EOF'

if [[ -f ~/.local/etc/.iterm2_shell_integration.bash ]]; then
    function iterm2_print_user_vars {
        printf "\033]1337;CurrentDir=''\007"
    }

   source ~/.local/etc/.iterm2_shell_integration.bash
fi
EOF
fi
