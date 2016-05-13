# remove mac directory title
printf '\e]7;%s\a'
# ignore ctrl-d
IGNOREEOF=1
PS1="\[\033[33m\](\h)\[\033[00m\]-\W\\$ "
PS1='\[\e]0;\u@\h\a\]'"$PS1"
LS_COLORS='di=34:fi=0:ln=35:pi=36;1:so=33;1:bd=0:cd=0:or=35;4:mi=0:ex=31:su=0;7;31:*.rpm=90'


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

# for gauss
if [ "$(hostname)" == "gauss" ]; then

    function slurm {
        if [[ -n "$SLURM_NTASKS" ]]
        then
            echo -e "[-N${SLURM_NNODES} -n${SLURM_NTASKS}]"
        fi
    }
    PS1="\[\033[33m\](\h)\[\033[00m\]\[\033[32m\]$(slurm)\[\033[00m\]-\W\\\$ "
    PS1='\[\e]0;\u@\h\a\]'"$PS1"

    function sapply {
        if [ -z "$@" ]; then
            cmd="ps ar -o user,pid,pcpu,pmem,nice,stat,cputime,etime,command"
        else
            cmd="$@"
        fi
        # echo $cmd
        hosts=`sinfo|grep -v PARTITION|grep c0|grep -v down|awk {'print $6'}|sed -r 's/(\[|,)([0-9]+)-([0-9]+)/\1$(echo {\2..\3})/g;s/^/echo /'|bash|sed -r 's/ /,/g;s/\[/{/;s/\]/}/;s/^/echo /'|bash|sed 's/\s/\n/g'|sort|uniq`
        for j in $hosts; do echo $j; ssh $j "$cmd"; done;
    }
    alias killr="killall -9 -u rcslai R;sapply 'killall -9 -u rcslai R'"

    function myjobs {
        if [ -z $1 ]
         then
          NAME=$LOGNAME
         else
          NAME=$1
         fi
        hosts=`squeue|grep -v PS|grep c0|grep -w $NAME|awk {'print $8'}|sed -r 's/(\[|,)([0-9]+)-([0-9]+)/\1$(echo {\2..\3})/g;s/^/echo /'|bash|sed -r 's/ /,/g;s/\[/{/;s/\]/}/;s/^/echo /'|bash|sed 's/\s/\n/g'|sort|uniq`
        echo -n `date` "- "
        if [ -z "$hosts" ]
         then
          echo $NAME has no running jobs
         else
          echo $NAME has jobs running on: $hosts
          PS='ps ax -o user,pid,pcpu,pmem,nice,stat,cputime,etime,command'
           for j in $hosts;
            do
             echo jobs for $NAME on $j;
             ssh $j "$PS|head -n 1; $PS|grep $NAME";
            done;
        fi
    }
else
    function git-branch-name {
        echo `git symbolic-ref HEAD --short 2> /dev/null || (git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/.*(\(.*\))/\1/')`
    }

    function git-dirty {
        st=$(git status 2>/dev/null | tail -n 1)
        if [[ ! $st =~ "working directory clean" ]]
        then
            echo "*"
        fi
    }

    function git-unpushed {
        brinfo=`git branch -v | grep "$(git-branch-name)"`
        if [[ $brinfo =~ ("behind "([[:digit:]]*)) ]]
        then
            echo -n "-${BASH_REMATCH[2]}"
        fi
        if [[ $brinfo =~ ("ahead "([[:digit:]]*)) ]]
        then
            echo -n "+${BASH_REMATCH[2]}"
        fi
    }
    function gitcolor {
        st=$(git status 2>/dev/null | head -n 1)
        if [[ ! $st == "" ]]
        then
            if [[ $(git-dirty) == "*" ]];
            then
                echo -e "\033[31m"
            elif [[ $(git-unpushed) != "" ]];
            then
                echo -e "\033[33m"
            else
                echo -e "\033[32m"
            fi
        fi
    }
    function gitify {
        st=$(git status 2>/dev/null | head -n 1)
        if [[ ! $st == "" ]]
        then
            echo -e " ($(git-branch-name)$(git-dirty)$(git-unpushed))"
        fi
    }
    PS1="\[\033[33m\](\h)\[\033[00m\]-\W\[\$(gitcolor)\]\$(gitify)\[\033[00m\]\$ "
    PS1='\[\e]0;\a\]'"$PS1"

fi