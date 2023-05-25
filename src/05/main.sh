#!/bin/bash
. ./supp.sh

if [[ -n $1 ]]
then 
    if [[ -d $1 ]]
    then
	if [[ ${1: -1} = "/" ]]
	then
	    START_POINT=$(date +%s%N)
	    count_folders $1
	    top_five_folders $1
	    count_files $1
	    conf_files $1
	    ten_largest_files $1
	    ten_exec_largest_files $1
	    END_POINT=$(date +%s%N)
	    DIFF=$(bc -l <<< "scale=1; ($END_POINT - $START_POINT)/1000000000")

	    echo "Script execution time(in seconds) = $DIFF"
	else
	    echo "directory should end with '/'"
	fi
    else
	echo "directory does not exist"
    fi
else
    echo "parameter is required. Try again"
fi
