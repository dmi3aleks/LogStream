#!/usr/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters"
    echo "Usage: demultiplexer destinationDirectory"
    echo "Example: demultiplexer ../test/destDir"
    exit
fi

outFile="default.log"
prevLine=" "
isCurMeta=0
isPrevMeta=0

while read line
do
    fileName=$(echo $line | sed -e 's/==> \(.*\) <==/\1/')
    
    #echo $line

    if [ "$line" != "$fileName" ]; then
       isCurMeta=1
       fileName=$(basename $fileName)
       #echo "Writing to $fileName\n"
       outFile=$fileName
    else
       isCurMeta=0
       if [ "$isPrevMeta" == "0" ]; then
           echo $prevLine >> "$1/$outFile"
       fi
    fi
    prevLine=$line
    isPrevMeta=$isCurMeta
done
