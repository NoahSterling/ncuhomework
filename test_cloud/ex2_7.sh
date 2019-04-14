#! /bin/bash
echo "Write a Shell script to find factorial of a given integer. "
read -p "please input the number n:" n

sum=1

if [ $n -le 0 ]
then
	echo "wrong number!"
fi

for ((i=1;i<=n;i++));
do
	sum=$((sum*i))
done

echo "$n!=$sum"
