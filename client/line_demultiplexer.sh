#!/usr/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters"
    echo "Usage: line_demultiplexer destinationDirectory"
    echo "Example: demultiplexer ../test/destDir"
    exit
fi

defaultOutFile="default.log"

while read line
do
    fileName=$(echo $line | sed -e 's/\[\(.*\)\]\(.*\)/\1/')
    data=$(echo $line | sed -e 's/\[\(.*\)\] \(.*\)/\2/')
 
    if [ "$line" != "$fileName" ]; then
       echo $data >> "$1/$fileName"
    else
       echo $data >> "$1/$defaultOutFile"
    fi
done
