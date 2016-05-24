# for gauss

function slurm_badge {
    if [[ -n "$SLURM_NTASKS" ]]
    then
        echo -e "[-N${SLURM_NNODES} -n${SLURM_NTASKS}]"
    fi
}
PS1="\[\033[33m\](\h)\[\033[00m\]\[\033[32m\]$(slurm_badge)\[\033[00m\]-\W\\\$ "
PS1='\[\e]0;\u@\h\a\]'"$PS1"


function sapply {
    if [ -z "$@" ]; then
        cmd="$PS_COMMAND"'|awk '"'"'$3>0.5'"'"''
    else
        cmd="$@"
    fi
    # echo $cmd
    hosts=`sinfo|grep -v ^PARTITION|grep c0|grep -v down|awk {'print $6'}|sed -r 's/(\[|,)([0-9]+)-([0-9]+)/\1$(echo {\2..\3})/g;s/^/echo /'|bash|sed -r 's/ /,/g;s/\[/{/;s/\]/}/;s/^/echo /'|bash|sed 's/\s/\n/g'|sort|uniq`
    for j in $hosts; do 
        echo $j
        ssh $j "$cmd" | if [[ -t 1 ]];then (cat | cut -c 1-$COLUMNS);else cat;fi
    done
}

alias killr="killall -9 -u rcslai R; sapply 'killall -9 -u rcslai R'"

function sjobs {
    if [ -z $1 ]; then
        NAME=$LOGNAME
    else
        NAME=$1
    fi
    sapply "$PS_COMMAND"'|awk '"'"'$3>0.5'"'"''"|grep $USER|grep -v grep"
}
