#!/bin/bash

for i in "$@"; do
    if [[ -e $i ]] && [[ -f $i ]]; then
        ls -l $i
    fi
done
