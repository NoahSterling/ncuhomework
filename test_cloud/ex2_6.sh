#!/bin/bash 

echo "Write a Shell script to list all of the directory files in a directory."

read -p "Enter the directory where you will query:" dir

ls -l $dir |awk '/^d/ {print $NF}'
