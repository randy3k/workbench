# case insensitive
unsetopt CASE_GLOB

# prevent zsh to print an error when no match can be found
unsetopt nomatch

# enable i-search
stty -ixon -ixoff


# history
setopt share_history
setopt inc_append_history
export HISTSIZE=2000
export HISTFILE="$HOME/.zhistory"
export SAVEHIST=$HISTSIZE

# color
export CLICOLOR=1
LS_COLORS='di=34:fi=0:ln=35:pi=36;1:so=33;1:bd=0:cd=0:or=35;4:mi=0:ex=31:su=0;7;31:*.rpm=90'

setopt nolistambiguous
setopt correct
autoload -U compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)*==34=34}:${(s.:.)LS_COLORS}")';

zstyle -s ':completion:*:hosts' hosts _ssh_config
if [[ -r ~/.ssh/config ]]; then
    _ssh_config+=($(cat ~/.ssh/config | sed -ne 's/Host[=\t ]//p'))
    _ssh_config+=($(cat ~/.ssh/config | sed -ne 's/^[ ]*HostName[=\t ]//p'))
fi
zstyle ':completion:*:hosts' hosts $_ssh_config

alias rsync="rsync -av --exclude \".*\""
alias nps='ps ar -o user,pid,pcpu,pmem,nice,stat,cputime,etime,command'
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias h=history
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias sudo='sudo '

autoload -U colors && colors
setopt prompt_subst
PROMPT='%{$fg[yellow]%}(%m)%{$reset_color%}-%c%{$reset_color%}$ '

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    alias subl='rmate'
fi
