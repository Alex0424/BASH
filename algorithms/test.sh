#!/bin/bash

source ./binary_search.sh
source ./linear_search.sh

total=6
succeded_tests=0
failed_tests=0

test_binary_search() {
    tests=(
        "succeed,3,-1,-4 -3 -2 -1"
        "succeed,3,0,-6 -4 -2 0 2 4 6"
        "succeed,13,140,10 20 30 40 50 60 70 80 90 100 110 120 130 140 150 160 170 180 190 200"
        "fail,None,55,10 20 30 40 50 60 70 80 90"
        "succeed,0,10,10 20 30 40 50"
        )

    for ((i=0; i<="${#tests[@]}-1"; i++)); do
        local fail_or_success=($(cut -d ',' -f 1 <<< "${tests[$i]}"))
        local expected=$(cut -d',' -f 2 <<< "${tests[$i]}")
        local target=$(cut -d ',' -f 3 <<< ${tests[$i]})
        local numeric_array=($(echo "${tests[$i]}" | cut -d ',' -f 4-))

        result=$(binary_search "${numeric_array[@]}" $target)
        local exit_status=$?

        if [ 0 -eq $exit_status ] && [ $fail_or_success == "succeed" ] && [ $expected -eq $result ]; then
            echo Test succeeded: Found target number $target at array index $result
            (( ++succeded_tests ))
        elif [ 1 -eq $exit_status ] && [ $fail_or_success == "fail" ] && [ $expected == $result ]; then
            echo "Test succeeded: Test failed on purpose, target ${target} not found in array: (${numeric_array[@]})"
            (( ++succeded_tests ))
        else
            echo "Test failed: Exit code from binary_search func is ${exit_status}"
            (( ++failed_tests ))
        fi
    done
}

test_linear_search() {
    local digits_array=(111 222 333 444 -5 -6 -7 -8 -9)
    local find_digit=-7

    linear_search "${digits_array[@]}" "$find_digit" && echo "Search completed successfully."
    local exit_status=$?
    
    if [ 0 -eq $exit_status ]; then
        echo Test succeeded
        (( ++succeded_tests ))
    fi
}

echo
echo Running test_binary_search && test_binary_search
echo
echo Running test_linear_search && test_linear_search
echo
echo Test outcome:
echo Succeded:  $succeded_tests/$total
echo Failed: $failed_tests
echo