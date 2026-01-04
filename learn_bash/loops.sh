#!/bin/bash

# Parameters
first_num=$1
second_num=$2

loop_seq() {
  echo -e "\nLoop with parameters start=$first_num & end=$second_num"
  for number in $(seq "$first_num" "$second_num"); do
    echo "Count: $number"
  done
}

loop_c_style() {
    echo -e "\nC Style Loop with parameters start=$first_num & end=$second_num"
  for ((i=$first_num; i<$second_num; i++)); do
    echo "i = $i"
  done
}

loop_globbing() {
  echo -e "\nLoop without parameters start=1 & end=10"
  for number in {1..10}; do
    echo "Count: $number"
  done
}

loop_array() {
  echo -e "\nArray loop"
  fruits_array=(apple banana cherry)
  for item in "${fruits_array[@]}"; do
    echo "Fruit: $item"
  done
}

loop_files() {
  echo -e "\nLooping throw .sh file in dir: /home/$USER"
  shopt -s nullglob
  found=false
  
  cd /home/$USER/
  for file in *.sh; do
    echo "Found file: $file"
    found=true
  done
  
  if [ "$found" = false ]; then
  echo "No files found"
  fi
}

loop_seq
loop_c_style
loop_globbing
loop_array
loop_files
