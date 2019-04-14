#!/bin/bash 
echo "Write a Shell script that displays list of all the files in the current directory to which the user has read, Write and execute permissions. "

files=$(ls .)

for ifile in $files
do
	[ -r $ifile -a -w $ifile -a -x $ifile ] && \
				echo $ifile
done

