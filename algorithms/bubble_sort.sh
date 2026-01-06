#!/bin/bash

# https://en.wikipedia.org/wiki/Bubble_sort
# n > n+1 = swap
#
#procedure bubbleSort(A : list of sortable items)
#    n := length(A)
#    repeat
#        swapped := false
#        for i := 1 to n-1 inclusive do
#            { if this pair is out of order }
#            if A[i-1] > A[i] then
#                { swap them and remember something changed }
#                swap(A[i-1], A[i])
#                swapped := true
#            end if
#        end for
#    until not swapped
#end procedure

bubble_sort() {
    local A=(${@})
    local n=${#A[@]}

    while true; do
        swapped=false
        for ((i = 1; i <= n-1; i++)); do
            if (( ${A[i-1]} > ${A[i]} ))
            then
                # echo DEBUG: ${A[i-1]} is bigger than ${A[i]}, switching...
                replace=${A[i]}
                A[i]=${A[i-1]}
                A[i-1]=$replace
                # echo DEBUG: new array: ${A[@]}
                swapped=true
            fi
        done
        if [ "${swapped}" == false ]; then
            echo ${A[@]}
            return 0
        fi
        # echo DEBUG: for loop done
    done
}