#!/bin/bash

# Refference source: https://en.wikipedia.org/wiki/Binary_search
#
# Pseudocode:
#
#function binary_search(A, n, T) is
#    L := 0
#    R := n − 1
#    while L ≤ R do
#        m := L + floor((R - L) / 2)
#        if A[m] < T then
#            L := m + 1
#        else if A[m] > T then
#            R := m − 1
#        else:
#            return m
#    return unsuccessful

binary_search() {
    local A=("${@:1:$#-1}")
    local n=${#A[@]}
    local T=${@: -1}
    local L=0
    local R=$(( n - 1 ))

    while [ $L -le $R ]
    do
        local m=$(( L + (R - L) / 2))
        if (( A[m] < T )); then
            L=$((m + 1))
        elif (( A[m] > T )); then
            R=$((m - 1))
        else
            echo $m
            return 0
        fi
    done

    echo "None"
    return 1
}