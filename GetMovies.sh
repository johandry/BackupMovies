#!/bin/sh

[ -z "$1" ] && exit

currentDir=`pwd`
cd "$1"
n=0
printf "%3d" $n 1>&2
for movie in */*
	do 
	echo ${movie} 
	: $((n = $n + 1))
	printf "\b\b\b%3d" $n 1>&2
	#sleep 1
done
echo "   DONE" 1>&2
cd $currentDir