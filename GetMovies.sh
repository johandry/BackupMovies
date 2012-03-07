#!/bin/sh

[ -z "$1" ] && exit

currentDir=`pwd`
cd "$1"
for movie in */*; do echo ${movie}; done
cd $currentDir