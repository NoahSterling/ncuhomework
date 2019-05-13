#!/bin/bash

array = ("runoob" "runoob1" "runoob2" "runoob3" "runoob5")

function rand(){
    min=$1
    max=$(($2-$min+1))
    num=$(cat /proc/sys/kernel/random/uuid | cksum | awk -F ' ' '{print $1}')
    echo $(($num%$max+$min))
}

rnd=$(rand 0 4)
rnd_ip=$(rand 1 2)
while true
do
{
        curl_cmd="curl -i http://192.168.209.13{$rnd_ip}:28017/test/{$array[$rnd]}/"
        eval "$curl_cmd"
        sleep $rnd
}&
wait
done
