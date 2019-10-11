#!/bin/bash

if [[ $# == 0 ]] || [[ $# > 1 ]]; then
    echo "Pass ONE filename as argument to script!!!"
elif [[ $# == 1 ]]; then
    if [[ -e $1 ]]; then
        if [[ -f $1 ]]; then
            chmod u+x $1
            echo "Added execute permission to the file for user!!!"
        elif [[ ! -f $1 ]]; then
            echo "Error!!! $1 is not a regular file!!!"
        fi
    elif [[ ! -e $1 ]]; then
        echo "Error!!! $1 does not exist!!!"
    fi
fi
