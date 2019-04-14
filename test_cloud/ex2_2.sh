#!/bin/bash 
echo " Write a Shell script that deletes all lines containing a specified word in one or more files supplied as arguments to it. "

read -p "please input the word:" word
read -p "please input the selected files:" files
for ifile in $files
do
	echo "the file $ifile:"
	sed "/$word/d" $ifile
done
~                                       
