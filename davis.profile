# change shell
_SHELL="/home/cslai/.linuxbrew/bin/bash"
if [ "$SHELL" != "$_SHELL" -a -n "$SSH_TTY" -a -x "$_SHELL" ]; then
    export SHELL="$_SHELL"
    exec $SHELL --init-file /home/cslai/.bash_profile
fi
unset _SHELL
