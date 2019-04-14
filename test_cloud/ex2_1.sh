#!/bin/bash 

echo "Write a Shell script that accepts a filename, starting and ending line numbers as arguments and displays all the lines between the given line numbers. "

read -p "please input the filename, start & end line:" name start0 end0

sed -n "${start0},${end0}p" $name
