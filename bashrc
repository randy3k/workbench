# remove mac directory title
printf '\e]7;%s\a'
# ignore ctrl-d
IGNOREEOF=1
PS1="\[\033[33m\](\h)\[\033[00m\]-\W\\$ "
PS1='\[\e]0;\u@\h\a\]'"$PS1"
LS_COLORS='di=34:fi=0:ln=35:pi=36;1:so=33;1:bd=0:cd=0:or=35;4:mi=0:ex=31:su=0;7;31:*.rpm=90'
alias nps='ps -o user,pid,pcpu,pmem,nice,stat,cputime,etime,command axr|grep -v user|cut -c-$COLUMNS|grep -v cut'
alias myjobs='ps -o user,pid,pcpu,pmem,nice,stat,cputime,etime,command ax|grep $USER|grep -v user|grep -v grep|cut -c-$COLUMNS|grep -v cut'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias h=history
alias sudo='sudo '

# for gauss
if [ "$(hostname)" == "gauss" ]; then

    unalias myjobs
    function slurm {
        if [[ -n "$SLURM_NTASKS" ]]
        then
            echo -e "[-N${SLURM_NNODES} -n${SLURM_NTASKS}]"
        fi
    }
    PS1="\[\033[33m\](\h)\[\033[00m\]\[\033[32m\]$(slurm)\[\033[00m\]-\W\\\$ "
    PS1='\[\e]0;\u@\h\a\]'"$PS1"

    function sshapply {
        if [ -z "$@" ]; then
            cmd="ps -o user,pid,pcpu,pmem,nice,stat,cputime,etime,command axr|grep -v user|cut -c-$COLUMNS|grep -v cut"
        else
            cmd="$@"
        fi
        # echo $cmd
        for j in $(echo c0-{10..25}); do echo $j; ssh $j $cmd; done;
    }
    alias killr="killall -9 -u rcslai R;sshapply 'killall -9 -u rcslai R'"

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
          PS='ps -o user,pid,pcpu,pmem,nice,stat,cputime,etime,command ax'
           for j in $hosts;
            do
             echo jobs for $NAME on $j;
             ssh $j "$PS|head -n 1; $PS|grep $NAME|grep -v user|grep -v grep|grep -v sshd|cut -c-$COLUMNS|grep -v cut";
            done;
        fi
    }

fi
