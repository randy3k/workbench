# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# bash completion
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"
bind "set colored-stats on"
bind "set colored-completion-prefix on"
bind TAB:menu-complete

# alt arrow keys
bind '"\e[1;3C": forward-word'
bind '"\e[1;3D": backward-word'
# ctrl arrow keys
bind '"\C-f": forward-word'
bind '"\C-b": backward-word'
# substring search
bind '"\e[A": history-search-backward'
bind '"\e[B":history-search-forward'

# ignore ctrl-d
IGNOREEOF=1

# PS1
PS1="\[\033[33m\](\h)\[\033[00m\]-\W\\$ "
PS1='\[\e]0;\u@\h\a\]'"$PS1"

# color
LS_COLORS='di=34:fi=0:ln=35:pi=36;1:so=33;1:bd=0:cd=0:or=35;4:mi=0:ex=31:su=0;7;31:*.rpm=90'

# aliases
PS_COMMAND="ps ax -o user,pid,pcpu,pmem,nice,stat,cputime,etime,command"
alias nps="$PS_COMMAND"'|awk '"'"'NR==1||$3>0.5'"'"'|if [[ -t 1 ]];then (cat | cut -c 1-$COLUMNS);else cat;fi'
alias rsync="rsync -av --exclude \".*\""
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias h=history
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias R='R --no-save'
alias r='R --no-save'
alias p='ipython'
alias j='julia'
alias jnb='jupyter notebook'

# to allow sudo subl
alias sudo='sudo '

# prompt
function git-branch-name {
    echo `git symbolic-ref HEAD --short 2> /dev/null || (git branch | sed -n 's/\* (*\([^)]*\))*/\1/p')`
}
function git-dirty {
    [[ `wc -l <<< "$1" ` -eq 1  ]] || echo "*"
}
function git-unpushed {
    if [[ "$1" =~ ("behind "([[:digit:]]*)) ]]
    then
        echo -n "-${BASH_REMATCH[2]}"
    fi
    if [[ "$1" =~ ("ahead "([[:digit:]]*)) ]]
    then
        echo -n "+${BASH_REMATCH[2]}"
    fi
}
function gitcolor {
    st=$(git status -b --porcelain 2>/dev/null)
    [[ $? -eq 0 ]] || return

    if [[ $(git-dirty "$st") == "*" ]];
    then
        echo -e "\033[31m"
    elif [[ $(git-unpushed "$st") != "" ]];
    then
        echo -e "\033[33m"
    else
        echo -e "\033[32m"
    fi
}
function gitify {
    st=$(git status -b --porcelain 2>/dev/null)
    [[ $? -eq 0 ]] || return
    dirty=$(git-dirty "$st")
    unpushed=$(git-unpushed "$st")
    echo -e " ($(git-branch-name)$dirty$unpushed)"
}

PS1="\[\033[33m\](\h)\[\033[00m\]-\W\[\$(gitcolor)\]\$(gitify)\[\033[00m\]\$ "

PROMPT_COMMAND='reset_terminal_title'

function reset_terminal_title {
    printf "\033]0;%s\007" "${HOSTNAME%%.*}"
    printf '\033]7;\007'
    printf "\033]1337;CurrentDir=''\007"
}

function iterm2_print_user_vars {
    printf "\033]1337;CurrentDir=''\007"
}
