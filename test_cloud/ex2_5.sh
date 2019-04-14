#!/bin/bash 

echo "Write a Shell script that accepts a list of file names as its arguments, counts and reports the occurrence of each word that is present in the first argument file on other argument files."

read -p "please input the files:" files

set $files

if [ $# -le 1 ] 
then
	echo "Insufficient files!"
	exit 1	
fi

first=$1

words=$(awk 'BEGIN{RS="[,.:;/!?]"}{for(i=1;i<=NF;i++)array[$i]++;}END{for(i in array) print i}' $1)

for ifile in $* 
do
	echo "in $ifile:"
	for iword in $words 
	do
		sum=0
		awk '{for(i=0;i<=NF;i++) if($i=="'$iword'") sum++}END{print "'$iword':", sum}' "$ifile"
	done
	echo "-------------------------------"
done
