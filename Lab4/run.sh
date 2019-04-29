#!/bin/bash

Qp=2
# 存放进程的队列
Qarr=();

run=0
function push() {
	Qarr=(${Qarr[@]} $1)
	run=${#Qarr[@]}
}

function check() {
	oldQ=(${Qarr[@]})
	Qarr=()
	for p in "${oldQ[@]}";do
		if [[ -d "/proc/$p" ]];then
			Qarr=(${Qarr[@]} $p)	
		fi
	done
	run=${#Qarr[@]}
	
}


i=1

while :
name="test$i"
echo "create container $name"
do
{	
	docker create --name $name --security-opt seccomp:unconfined time
	docker start --checkpoint=ckp2 $name --checkpoint-dir=/home/keil
	docker logs $name
	sleep 2&
        push $i
	while [[ $run -gt $Qp ]];do
		check
		sleep 0.1
	done
}
i=`expr $i + 1`
done
wait
