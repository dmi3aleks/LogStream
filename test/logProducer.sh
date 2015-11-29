#!/usr/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Illegal number of parameters"
    echo "Usage: ./logProducer.sh logKeyword sleepSec"
    echo "Example: ./logProducer.sh \"Some Data\" 1"
    exit
fi

i=0
while true
do 
    echo "$1 $i"
    ((i+=1))
    sleep $2 
done
