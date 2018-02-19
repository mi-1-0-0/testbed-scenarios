#!/bin/bash

HOST_FILES=$(ls *.lst)

for i in $HOST_FILES; do
    # Parse target list files
    OLD_IFS=$IFS
	IFS=$'\n'
    TMP=( $(cat $i) )
    IFS=$OLD_IFS
    # Number of tmux window splits
    NUM_SPLITS=${TMP[0]}
    unset TMP[0];

	# Command to be executed on targets
    CMD="${TMP[1]}"
    unset TMP[1];
	
	# Target hosts
    HOSTS=${TMP[@]}
    
    ./tmux_exec_cmd.sh -i '~/.ssh/cit.key' -c "$CMD" --ihost "wally180" -n "$NUM_SPLITS" ${HOSTS[@]}
done

tmux a -t "tmux"
