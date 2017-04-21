# change shell
_SHELL="$HOME/.linuxbrew/bin/bash"
if [ "$SHELL" != "$_SHELL" -a -n "$SSH_TTY" -a -x "$_SHELL" ]; then
    export SHELL="$_SHELL"
    exec $SHELL --init-file "$HOME/.bash_profile"
fi
unset _SHELL
