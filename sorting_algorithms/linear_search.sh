#!/bin/bash

linear_search() {
    local digits="${@:1:$#-1}"
    local target="${@: -1}"
    local count=0

    for digit in ${digits[@]}; do
        count=$(($count + 1)) && echo "Searching... checked $digit"
        if [ $digit = $target ]; then
            echo Found the target: $target after $count searches
            return 0
        fi
    done
}

digits_array=(1 2 3 4 5 6 7 8 9)
find_digit=7

linear_search "${digits_array[@]}" "$find_digit" && echo "Search completed successfully."