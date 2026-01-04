#!/bin/bash

linear_search() {
    local digits="${@:1:$#-1}"
    local target="${@: -1}"
    local count=0

    for digit in ${digits[@]}; do
        count=$(($count + 1))
        if [ $digit = $target ]; then
            echo Found the target: $target after $count searches
            return 0
        fi
    done
}