#!/bin/bash 

echo "Write a Shell script that receives any number of file names as arguments checks if every argument supplied is a file or a directory and reports accordingly. Whenever the argument is a file, the number of lines on it is also reported."

read -p "please input the files:" files

for ifile in $files
do
	if [ -f $ifile ]
	then
		echo "$ifile is a file and the number of lines is \
			$(sed -n '$=' $ifile)."
	elif [ -d $ifile ]
	then
		echo "$ifile is a directory."
	fi
done
