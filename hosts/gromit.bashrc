# for gromit

function pbs_badge {
    if [[ -n "$PBS_NP" ]]
    then
        echo -e "[-N${PBS_NUM_NODES} -n${PBS_NUM_PPN}]"
    fi
}
PS1="\[\033[33m\](\h)\[\033[00m\]\[\033[32m\]$(pbs_badge)\[\033[00m\]-\W\\\$ "
